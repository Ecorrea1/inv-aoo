import 'package:flutter/material.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/theme/theme.dart';
import 'package:invapp/utils/icons_string_util.dart';
import 'package:provider/provider.dart';

class ProductGroupScreen extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    
    final authService   = Provider.of<AuthService>( context, listen : false );
    final user          = authService.user;

    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, iconTheme: IconThemeData( color: Colors.blue ) , ),
      body: Stack(
        children: [
          // _createBackground( context ),
          _createMenu( context, user, user.role.groupOptions ),
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
                    image: AssetImage( 'assets/tag-logo.png' ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _createMenu( BuildContext context, User user ,List<GroupOption> menuScreens ) {
    return Container(
      height: MediaQuery.of( context ).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [...menuScreens.map( ( option ) => _createMenuOption( option.name, option.icon, user.email, context ) ).toList() ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only( right: 15.0, bottom: 10.0, top: 30.0 ),
            alignment: Alignment.centerRight,
            width: MediaQuery.of( context ).size.width * 0.75,
            child: Text(
              'INVAPP 2021 Copyright © Todos los derechos reservados',
              style: CustomTheme.footText.copyWith( color: Colors.grey ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createMenuOption( String title, String icon, String user, BuildContext context ) {

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
                final data = [ title, user ];
                Navigator.pushNamed( context, 'product', arguments: data );
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
