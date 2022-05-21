import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/models/product_group/product-group.model.dart';
import 'package:invapp/models/product_group/product_group_response.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/product_group_service.dart';
import 'package:invapp/widgets/list_tile_widget.dart';
import 'package:provider/provider.dart';

class ProductGroupAdminScreen extends StatelessWidget {

  final _productGroupSvc  = new ProductGroupService();
  final contactgroup      = new ProductGroup();
  final contactResponse   = new ProductGroupResponseModel();
  final textController    = new TextEditingController();
  //final _nameFilterController = new TextEditingController();

  @override
  Widget build( BuildContext context ) {

    _productGroupSvc.getContactGroup();
    final userEmail = ModalRoute.of(context).settings.arguments;
    // _productGroupSvc.getContactGroup(token: Provider.of<UserProvider>(context).token);

    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;
    return Scaffold(
      appBar: AppBar( title: Text( 'Grupo de Ministerio' ) ),
      body: SingleChildScrollView( child: listContactGroup( user: userEmail.toString() ) ),
      floatingActionButton: addGroupBottom(context, userEmail, user),
    );
  }

  FloatingActionButton addGroupBottom(BuildContext context, Object userEmail, User user) {
    if ( !user.role.privileges.createGroup ) return null;

    return FloatingActionButton(
      child: Icon( Icons.add ),
      elevation: 1,
      onPressed: () => addNewGroup( context, userEmail )
    );
  }

  StreamBuilder<List<ProductGroup>> listContactGroup( { String user } ) {
    return StreamBuilder<List<ProductGroup>>(
      stream: _productGroupSvc.productGroupStream,
      builder: ( BuildContext context, AsyncSnapshot<List<ProductGroup>> snapshot ) {
        
        if ( !snapshot.hasData && snapshot.data == null ) return Center( child: CircularProgressIndicator() );
        
        List listStream                 = snapshot.data;
        List<Widget> listContactsGroup  = [];
        
        for ( final contactGroup in listStream ) {
          listContactsGroup.add( _groupTile( context, contactGroup, user ) );
        }
        return Wrap( alignment: WrapAlignment.start, children: listContactsGroup );
      
      }
    );
  }

  _groupTile( context, ProductGroup group, String user ) {
    return ListTileCustom(
      iconName: group.icon,
      title: Text( group.name ),
      iconColor: _selectedColor(group.name),
      onTap: () {
        final data = [ group.name, user ];
        Navigator.pushNamed( context, 'product', arguments: data );
      },
    );
  }


  addNewGroup( context, String userName ) async {
    
    if ( Platform.isAndroid ) {
      // Android
      return showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text( 'Nuevo Grupo :' ),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text( 'Agregar' ),
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
          title: Text( 'Nuevo Grupo:' ),
          content: CupertinoTextField(
            controller: textController,
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

  _sendInformation( context, String userName ) async {
    
    final result = await _productGroupSvc.addNewProductGroup( name: textController.text , icon: 'FAandroid', userName: userName );
    print( 'result: $result ' );
    if( result  ){ 
      print('creado grupo');   
    }else{
      print('no se a creado grupo');
    }
    return Navigator.pop(context);
  }
  _selectedColor( String action ) {
    switch ( action ) {
      case 'Eliminados': return Colors.red;
      case 'Prestamos': return Colors.green;
      case 'Todos': return Colors.yellow;
      default: return Colors.blue;
    }
  }
}