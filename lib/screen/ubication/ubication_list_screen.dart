import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/models/ubication/ubication.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/ubication.service.dart';
import 'package:invapp/utils/formatters/uppercase_text_formatter.dart';
import 'package:invapp/widgets/list_tile_widget.dart';
import 'package:provider/provider.dart';

class UbicationListScreen extends StatelessWidget {

  final _ubicationSvc   = new UbicationService();
  final textController  = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;
    final userName = ModalRoute.of(context).settings.arguments;

    _ubicationSvc.getUbications();

    return Scaffold(
      appBar: AppBar(
        title:TextField(
          controller: textController,
          inputFormatters: [ UpperCaseTextFormatter() ],
          style: TextStyle( color: Colors.white ),
          decoration: InputDecoration( hintText: 'Busqueda de Ubicaciones', hintStyle: TextStyle( color: Colors.white )),
          onChanged: ( filter ) => this._ubicationSvc.applyFilter( filter )
        ),
        actions: [ IconButton( icon: Icon (Icons.refresh , color: Colors.white ), onPressed: _refresh ) ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: listUbication() ,
      ),
       floatingActionButton:
        user.role.privileges.createUbications 
        ? FloatingActionButton(
          child: Icon( Icons.add ),
          elevation: 1,
          onPressed:() { addNewUbication( context, userName );}
        )
        : Container(),
    );
  }
      StreamBuilder<List<Ubication>> listUbication() {
    return StreamBuilder<List<Ubication>>(
      stream: _ubicationSvc.ubicationStream,
      builder: ( BuildContext context, AsyncSnapshot<List<Ubication>> snapshot ) {
        
        if ( !snapshot.hasData && snapshot.data == null ) return Center( child: CircularProgressIndicator() );
        
        List listStream            = snapshot.data;
        List<Widget> listUbication  = [];
        
        for ( final data in listStream ) {
          listUbication.add( _groupTile( context, data) );
        }
        return Wrap( alignment: WrapAlignment.start, children: listUbication );
      
      }
    );
  }

  _groupTile( context, Ubication ubication ) {
    return ListTileCustom(
      iconName: ubication.icon,
      title: Text( ubication.name ),
      // subtitle: Text( ubication.action ),
      onTap: () => Navigator.pushNamed( context, 'ubication-detail', arguments: ubication )
    );
  }

  addNewUbication( context, String userName ) async {
    
    if ( Platform.isAndroid ) {
      // Android
      return showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text( 'Nueva Ubicacion:' ),
            content: TextField(
              controller: textController,
              textCapitalization: TextCapitalization.sentences,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text( 'Add' ),
                elevation: 5,
                textColor: Colors.blue,
                onPressed:() => _sendInformation( context, userName )
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text( 'Nueva Ubicacion:' ),
          content: CupertinoTextField(
            controller: textController,
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text( 'Add' ),
              onPressed:() => _sendInformation(_, userName)
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(_)
            )
          ],
        );
      }
    );
  }

  _refresh() async {

    final refresh = await _ubicationSvc.getUbications();
    ( refresh.ok ) ? print('Refresco correacto') : print('Hubo algun problema al recargar');
  
  }

  _sendInformation( context, String userName ) async {
    
    if( textController.text.isEmpty ) return textController.text = 'Ingrese un dato';
    
    final result  = await _ubicationSvc.addNewUbication( name: textController.text , icon: 'FAandroid', userName: userName );
    
    ( result  )   
    ? print('Ubicacion Creada')
    : print('Problemas al crear Ubicacion');

    return Navigator.pop(context);

  }
}