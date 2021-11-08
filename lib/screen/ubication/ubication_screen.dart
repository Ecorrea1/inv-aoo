import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/ubication.service.dart';
import 'package:invapp/utils/icons_string_util.dart';
import 'package:invapp/models/ubication/ubication.model.dart';
import 'package:provider/provider.dart';

class UbicationScreen extends StatelessWidget {

  final _ubicationService = new UbicationService();
  final textController    = TextEditingController();

  @override
    Widget build( BuildContext context ) {

    Ubication ubication = ModalRoute.of( context ).settings.arguments;
    final authService   = Provider.of<AuthService>( context, listen : false );
    final user          = authService.user;
    Size size           = MediaQuery.of( context ).size;

    _addInfoController( name: ubication.name );
    
    return Scaffold(
      appBar: AppBar( 
        actions: [ IconButton( icon: Icon(Icons.delete, color: Colors.white), onPressed: () => _deleteInfo( context, ubication, user.email ) ) ],
        elevation: 0.0 ),
      body: Container(
        child: Column(
          children: <Widget>[
            _ubicationHeader( context, size, ubication ), 
            _ubicationListData( size, ubication )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.edit ),
        elevation: 1,
        onPressed:() { addNewUbication( context, ubication, user.email );}
        // onPressed: () => Navigator.pushNamed( context, 'update-ubication', arguments: ubication )
      ),
    );
  }

  Widget _ubicationHeader( context, size, Ubication ubication ) {
    return Container(
      width: size.width,
      height: size.height * 0.25,
      color: Theme.of( context ).primaryColor,
      child: Icon(
        getIcon( ubication.icon ),
        size: 150,
        color: Colors.white,
      )
    );
  }

  _ubicationListData( size, Ubication ubication ) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _ubicationItemData( title: 'Nombre', data: ubication.name ),
          _ubicationItemData( title: 'Icono', data: ubication.icon ),
          _ubicationItemData( title: 'Activo', data: ubication.active.toString(), color: ( ubication.active ) ? Colors.green : Colors.red ),
        ],
      ),
    );
  }

  Widget _ubicationItemData( { @required String data , @required title, Color color } ) {
    
    if( data.isEmpty ) return Container();
    return Column(
      children: [
        Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text( 
          '$title :',
              style: TextStyle( 
                fontSize: 15,
                fontWeight: FontWeight.bold
              )          
        ),
            SizedBox( width: 10 ),
            Text( 
              data, 
              style: TextStyle( 
                fontSize: 15.0,
                color: (color == null ) ? Colors.black : color
              ),
            ),
          ]
        ),
        Divider(height: 20,),
      ],
    );
  }
  addNewUbication( context, Ubication ubication, String user ) async {
    
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
                onPressed:() => _sendInformation( context, ubication, user )
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
              onPressed:() => _sendInformation(_, ubication, user )
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


  _sendInformation( context, Ubication ubication, String user ) async {
    
    if( textController.text.isEmpty ) return textController.text = 'Ingrese un dato';
    
    final result  = await _ubicationService.updateUbication( uid: ubication.id, data: {
      'name'          : textController.text,
      'user'          : user
    } );
    
    ( result  )   
    ? textController.text = textController.text
    : print('Problemas al crear Ubicacion');

    return Navigator.pop(context);

  }
  
  _deleteInfo(context, Ubication ubication, String user) async {

    final delete = await _ubicationService.deleteUbication( uid: ubication.id, userName: user );
    print( 'Esto es el :  $delete' );
    if ( delete ) {
      print('Eliminacion de ubicacion sin problemas');
    } else {
      print('Tuvo algunos problemas');
    }
    Navigator.pop(context);
  }

  _addInfoController({ name }) async { textController.text = name; }

  _cleanController() { textController.text = ''; }

}