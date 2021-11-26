import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/config/config_model.dart';
import 'package:invapp/screen/login/form/form_login.dart';
import 'package:invapp/services/config_service.dart';
import 'package:invapp/widgets/logo_login.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String version = '';
  final bool earlyAccess = false;
  final bool inMaintenance = true;
  final bool isProduction = Enviroments.isProduction;

  @override
  void initState() {
    checkVersion(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogoScreen(title: isProduction ? 'InvApp' : 'InvApp Dev'),
                  FormLogin(),
                  // LabelsLogin(
                  // route: 'register',
                  // title: '¿No tienes una cuenta?',
                  // subtitle: 'Crear una cuenta!',
                  // ),
                  Text((earlyAccess) ? 'V$version - beta' : 'V$version',
                      style: TextStyle(fontWeight: FontWeight.w300))
                ],
              ),
            ),
          ),
        ));
  }

  ///chequea la version para determinar si hay una versión nueva en las tiendas
  checkVersion(context) async {
    // ConfigService configService = new ConfigService();
    // final appConfig = await configService.getAppConfig();
    print('---------------------------');
    // print(appConfig);
    final PackageInfo info = await PackageInfo.fromPlatform();
    // final platform = Platform.isAndroid ? 'android' : 'ios';
    //se actualiza la versión que se muestra en la pantalla
    setState(() => this.version = info.version);
    // int versionInstalada = int.parse(info.version.trim().replaceAll(".", ""));
    // if (appConfig.inMaintenance) platformBlockDialog(context, 'in_maintenance', 'we_are_doing_maintenance', 'close');
    // this._prefs.autoLoginDays = appConfig.autoLoginDays;
    // int versionStore = appConfig.versionActualStore(platform);
    // print('Esta es la version Store :$versionStore');
    // if (versionStore > versionInstalada) _showVersionDialog(context, appConfig);
  }

  ///muestra alerta de que hay una versión nueva en las tiendas
  _showVersionDialog(context, Config config) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String titulo = 'new_update_available';
        String mensaje = 'there_is_new_version';
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(titulo),
                content: Text(mensaje),
                actions: <Widget>[
                  TextButton(
                    child: Text('to_update'),
                    onPressed: () => _abrirURL(config.appStoreUrl),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(titulo),
                content: Text(mensaje),
                actions: <Widget>[
                  TextButton(
                    child: Text('to_update'),
                    onPressed: () => _abrirURL(config.playStoreUrl),
                  )
                ],
              );
      },
    );
  }

  _abrirURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
