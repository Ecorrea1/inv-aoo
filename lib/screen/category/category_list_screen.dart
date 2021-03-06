import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/models/category/category.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/category.service.dart';
import 'package:invapp/utils/formatters/formatterText.dart';
import 'package:invapp/utils/formatters/uppercase_text_formatter.dart';
import 'package:invapp/widgets/list_tile_widget.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatelessWidget {

  final _categorySvc    = new CategoryService();
  final textController  = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;
    final userName = ModalRoute.of(context).settings.arguments;

    _categorySvc.getCategories();

    return Scaffold(
      appBar: AppBar(
        title:TextField(
          controller: textController,
          inputFormatters: [ UpperCaseTextFormatter() ],
          style: TextStyle( color: Colors.white ),
          decoration: InputDecoration( hintText: 'Busqueda de Categorias', hintStyle: TextStyle( color: Colors.white )),
          onChanged: ( filter ) => this._categorySvc.applyFilter( filter )
        ),
        actions: [ IconButton( icon: Icon (Icons.refresh , color: Colors.white ), onPressed: _refresh ) ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: listHistorial(),
      ),
       floatingActionButton:
      !!user.role.privileges.createCategory ?
        FloatingActionButton(
        child: Icon( Icons.add ),
        elevation: 1,
        onPressed:() { addNewCategory( context, userName );}
      )
      : Container(),
      
    );
  }

     StreamBuilder<List<Category>> listHistorial() {
    return StreamBuilder<List<Category>>(
      stream: _categorySvc.categoryStream,
      builder: ( BuildContext context, AsyncSnapshot<List<Category>> snapshot ) {
        
        if ( !snapshot.hasData && snapshot.data == null ) return Center( child: CircularProgressIndicator() );
        
        List listStream            = snapshot.data;
        List<Widget> listCategory  = [];
        
        for ( final data in listStream ) {
          listCategory.add( _groupTile( context, data) );
        }
        return Wrap( alignment: WrapAlignment.start, children: listCategory );
      
      }
    );
  }

  _groupTile( context, Category category ) {
    return ListTileCustom(
      iconName: category.icon,
      title: Text( formatterName(category.name) ),
      onTap: () => Navigator.pushNamed( context, 'category-detail', arguments: category )
    );
  }

    addNewCategory( context, String userName ) async {  
    if ( Platform.isAndroid ) {
      // Android
      return showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text( 'Nueva Categoria :' ),
            content: TextField(
              controller: textController,
              textCapitalization: TextCapitalization.sentences,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text( 'Agregar' ),
                elevation: 5,
                textColor: Colors.blue,
                onPressed:() => _sendInformation( context, formatterName(userName) )
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
          title: Text( 'Nueva Categoria:' ),
          content: CupertinoTextField(
            controller: textController,
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text( 'Agregar' ),
              onPressed:() => _sendInformation(_, formatterName(userName))
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
    final refresh = await _categorySvc.getCategories();
    ( refresh.ok ) ? print('Refresco correacto') : print('Hubo algun problema al recargar');
  }

  _sendInformation( context, String userName ) async {
    if( textController.text.isEmpty ) return textController.text = 'Ingrese un dato';
    final result  = await _categorySvc.addNewCategory( name: formatterName(textController.text) , icon: 'FAandroid', userName: userName );
    ( result  )   
    ? print('Ubicacion Creada')
    : print('Problemas al crear Ubicacion');
    return Navigator.pop(context);  
  }
}