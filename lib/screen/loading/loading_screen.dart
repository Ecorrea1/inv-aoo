import 'package:flutter/material.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      body: FutureBuilder(
        future: _sesion( context ),
        builder: ( BuildContext context, AsyncSnapshot<dynamic> snapshot ) { 
         return Center( child: CircularProgressIndicator(),); 
       },
      )
    );
  }
  _sesion( BuildContext context ) async {
    final authService   = Provider.of<AuthService>( context, listen : false );
    final authenticared = await authService.isLoggedIn();
    ( authenticared ) ? Navigator.pushReplacementNamed( context, 'menu' ) : Navigator.pushReplacementNamed( context, 'login' );
  }
}