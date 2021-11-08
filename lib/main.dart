import 'package:flutter/material.dart';
import 'package:invapp/routes/routes.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/socket_service.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ 
          ChangeNotifierProvider(create: ( _ ) => SocketService()),
          ChangeNotifierProvider(create: ( _ ) => AuthService())
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'INVAPP',
        initialRoute: 'loading',
        routes: appRoutes
      ),
    );
  }
}