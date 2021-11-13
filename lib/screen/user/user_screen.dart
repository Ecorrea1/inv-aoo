import 'package:flutter/material.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/user_service.dart';
import 'package:invapp/utils/icons_string_util.dart';
import 'package:invapp/models/ubication/ubication.model.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {

  final _userSvc = new UserService();

  @override
    Widget build( BuildContext context ) {

    Ubication ubication = ModalRoute.of( context ).settings.arguments;
    final authService   = Provider.of<AuthService>( context, listen : false );
    final user          = authService.user;
    Size size           = MediaQuery.of( context ).size;
    
    return Scaffold(
      appBar: AppBar( 
        actions: [ IconButton( icon: Icon(Icons.delete, color: Colors.white), onPressed: () { _deleteInfo( context, ubication, user.email ); } ) ],
        elevation: 0.0 ),
      body: Container(
        child: Column(
          children: <Widget>[
            _userHeader( context, size, ubication ), 
            _userListData( size, ubication )
          ],
        ),
      )
    );
  }

  Widget _userHeader( context, size, Ubication ubication ) {
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

  _userListData( size, Ubication ubication ) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          ( ubication.name != null ) ?  _userItemData( Icons.contacts, ubication.name )     : Container(),
          ( ubication.icon != null ) ?  _userItemData( Icons.poll, ubication.icon )         : Container(),
          ( ubication.id   != null ) ?  _userItemData( Icons.code, ubication.id.toString()) : Container(),
        ],
      ),
    );
  }

  Widget _userItemData( IconData icono, String data ) {
    return Column(
      children: [
        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Icon( icono, size: 25.0 ),
          Text( data, style: TextStyle( fontSize: 15.0 )),
        ]),
        Divider(),
      ],
    );
  }
  
  _deleteInfo(context, Ubication ubication, String user) async {

    final delete = await _userSvc.deleteUser( uid: ubication.id, user: user );
    print( 'Esto es el :  $delete' );
    if ( delete ) {
      print('Eliminacion de Usuario sin problemas');
    } else {
      print('Tuvo algunos problemas');
    }
    Navigator.pop(context);
  }
}