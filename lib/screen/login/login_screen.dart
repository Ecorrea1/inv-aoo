import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/models/config/config_model.dart';
import 'package:invapp/screen/login/form/form_login.dart';
import 'package:invapp/services/config_service.dart';
import 'package:invapp/services/socket_service.dart';
import 'package:invapp/shared/platform_dialog.dart';

import 'package:invapp/widgets/logo_login.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {

  String version = '1.0.0';
  bool inMaintenance = false;

  @override
  Widget build( BuildContext context ) {
    
    // final socketService = Provider.of<SocketService>(context);
    // if( socketService.serverStatus == ServerStatus.Online ) checkearVersion(context);
  
    return Scaffold(
      backgroundColor: Color( 0xffF2F2F2 ),
      //appBar: AppBar(title: Text('Login'),),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of( context ).size.height * 0.9,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LogoScreen( title: 'InvApp' ),
              FormLogin(),
              // LabelsLogin(
                // route: 'register',
                // title: '¿No tienes una cuenta?',
                // subtitle: 'Crear una cuenta!',
              // ),
              Text( 'V$version', style: TextStyle( fontWeight: FontWeight.w300 ) )
            ],
          ),
          ),
        ),
      )
    );
  }


//   ///chequea la version para determinar si hay una versión nueva en las tiendas
//   checkearVersion( context ) async {

//     try {

//       final PackageInfo info = await PackageInfo.fromPlatform();
//       final platform = Platform.isAndroid ? 'android' : 'ios';
  
//       //se actualiza la versión que se muestra en la pantalla
//       version = info.version;
  
//       double versionInstalada = double.parse( info.version.trim().replaceAll(".", "") );
  
//       //buscamos la versión que esta en la tienda según lo parametrizado en la BD
//       ConfigService configService = new ConfigService();
//       Config appConfig = await configService.getAppConfig();
  
//       if ( appConfig.inMaintenance ) return platformBlockDialog(context, 'En mantención', 'Estamos haciendo mantenimiento sobre la aplicación, por favor intenta más tarde', "Cerrar");
  
//       double versionStore = appConfig.versionActualStore( platform );
  
//       if ( versionStore > versionInstalada ) return _showVersionDialog(context, appConfig );
//     } catch (e) {

//       return print(e);
//     }
//   }

//   ///muestra alerta de que hay una versión nueva en las tiendas
//   _showVersionDialog( context, Config config ) async {
    
//     await showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         String titulo = "Nueva actualización disponible";
//         String mensaje = "Hay una nueva versión de la aplicación disponible, por favor actualice";
//         return Platform.isIOS
//         ? new CupertinoAlertDialog(
//             title: Text(titulo),
//             content: Text(mensaje),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text("Actualizar"),
//                 onPressed: () => _abrirURL( config.appStoreUrl ),
//               ),
//             ],
//           )
//         : new AlertDialog(
//             title: Text(titulo),
//             content: Text(mensaje),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text("Actualizar"),
//                 onPressed: () => _abrirURL( config.playStoreUrl ),
//               )
//             ],
//         );
//       },
//     );
// }

//   _abrirURL(String url) async {
//     if (await canLaunch( url )) {
//         await launch( url );
//       } else {
//         throw 'Could not launch $url';
//     }
//   }
}
