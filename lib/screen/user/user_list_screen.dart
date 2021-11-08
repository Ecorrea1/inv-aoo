import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/user_service.dart';
import 'package:invapp/widgets/list_tile_widget.dart';

class UserListScreen extends StatelessWidget {

  final _userSvc   = new UserService();
  final textController  = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userName = ModalRoute.of(context).settings.arguments;

    _userSvc.getUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),
      body: SingleChildScrollView(
        child: listUsers() ,
      ),
      //  floatingActionButton: FloatingActionButton(
        // child: Icon( Icons.add ),
        // elevation: 1,
        // onPressed:() { addNewUser( context, userName );}
      // ),
    );
  }
      StreamBuilder<List<User>> listUsers() {
    return StreamBuilder<List<User>>(
      stream: _userSvc.userStream,
      builder: ( BuildContext context, AsyncSnapshot<List<User>> snapshot ) {
        
        if ( !snapshot.hasData && snapshot.data == null ) return Center( child: CircularProgressIndicator() );
        
        List listStream         = snapshot.data;
        List<Widget> listUsers  = [];
        
        for ( final data in listStream ) {
          listUsers.add( _groupTile( context, data) );
        }
        return Wrap( alignment: WrapAlignment.start, children: listUsers );
      
      }
    );
  }

  _groupTile( context, User user ) {
    return ListTileCustom(
      // iconName: 'FAcode',
      title: Text( user.name ),
      // subtitle: Text( user.action ),
      onTap: () => Navigator.pushNamed( context, 'user-detail', arguments: user )
    );
  }

  //   addNewUser( context, String userName ) async {
    
  //   if ( Platform.isAndroid ) {
  //     // Android
  //     return showDialog(
  //       context: context,
  //       builder: ( context ) {
  //         return AlertDialog(
  //           title: Text( 'Nueva Ubicacion:' ),
  //           content: TextField(
  //             controller: textController,
  //           ),
  //           actions: <Widget>[
  //             MaterialButton(
  //               child: Text( 'Add' ),
  //               elevation: 5,
  //               textColor: Colors.blue,
  //               onPressed:() => _sendInformation( context, userName )
  //             )
  //           ],
  //         );
  //       },
  //     );
  //   }

  //   showCupertinoDialog(
  //     context: context, 
  //     builder: ( _ ) {
  //       return CupertinoAlertDialog(
  //         title: Text( 'Nueva Ubicacion:' ),
  //         content: CupertinoTextField(
  //           controller: textController,
  //         ),
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             isDefaultAction: true,
  //             child: Text( 'Add' ),
  //             onPressed:() => _sendInformation(_, userName)
  //           ),
  //           CupertinoDialogAction(
  //             isDestructiveAction: true,
  //             child: Text('Dismiss'),
  //             onPressed: () => Navigator.pop(_)
  //           )
  //         ],
  //       );
  //     }
  //   );
  // }

  //   _sendInformation( context, String userName ) async {
    
  //   if( textController.text.isEmpty ) return textController.text = 'Ingrese un dato';
    
  //   final result  = await _userSvc.addNewUser( name: textController.text , icon: 'FAandroid', userName: userName );
    
  //   ( result  )   
  //   ? print('Ubicacion Creada')
  //   : print('Problemas al crear Ubicacion');

  //   return Navigator.pop(context);

  // }
}