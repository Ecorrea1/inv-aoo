import 'package:flutter/material.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/theme/theme.dart';
import 'package:invapp/utils/icons_string_util.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    
    final authService   = Provider.of<AuthService>( context, listen : false );
    final user          = authService.user;

    return Scaffold(
      body: Stack(
        children: [
          _createBackground( context ),
          _createMenu( context, user, user.role.menuOptions ),
        ],
      ),
    );
  }

  Widget _createBackground( BuildContext context ) {
    return Row(
      children: [
        Material(
          elevation: 10,
          child: Container(
            width: MediaQuery.of( context ).size.width * 0.25,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only( top: 100.0 ),
                  child: Image(
                    width: 70.0,
                    image: AssetImage( 'assets/logo-iglesia.png' ),
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only( bottom: 10.0 ),
                  child: IconButton(
                    icon: Icon( Icons.edit, size: 30, color: Colors.white,),
                    // iconSize: 30.0,
                    onPressed: () {
                      Navigator.pushNamed( context, 'user-update' );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _createMenu( BuildContext context, User user ,List<MenuOption> menuScreens ) {
    return Container(
      height: MediaQuery.of( context ).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only( top: 120, bottom: 50 ),
            width: MediaQuery.of( context ).size.width * 0.72,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('!Hola: ${ user.name.substring(0, user.name.length) }',
                    style: Theme.of( context ).textTheme.headline6,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.only( bottom: 10.0 ),
                    icon: Icon(
                      Icons.logout,
                      size: 30.0,
                    ),
                    onPressed: () => _logout( context ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [...menuScreens.map( ( option ) => _createMenuOption( option.name, option.icon, option.page, user, context ) ).toList() ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only( right: 15.0, bottom: 10.0, top: 30.0 ),
            alignment: Alignment.centerRight,
            width: MediaQuery.of( context ).size.width * 0.75,
            child: Text(
              'INVAPP ${DateTime.now().year} | Copyright © Todos los derechos reservados',
              style: CustomTheme.footText.copyWith( color: Colors.grey ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createMenuOption( String title, String icon, String route, User user, BuildContext context ) {

    double paddingLeft = MediaQuery.of( context ).size.width * 0.1;
    
    return Container(
      padding: EdgeInsets.only( top: 5 ),
      margin: EdgeInsets.only( left: paddingLeft, right: 10 ),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed( context, route, arguments: user.email );
              },
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.blue,
                size: 25.0,
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    getIcon( icon ),
                    color: Colors.blue,
                    size: 25.0,
                  )
                ],
              ),
              title: Text( title ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout( BuildContext context ) {
    AuthService.deleteToken();
    Navigator.pushReplacementNamed( context, 'login' );
  }
}
