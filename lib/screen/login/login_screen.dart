import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/config/config_model.dart';
import 'package:invapp/screen/login/form/form_login.dart';
import 'package:invapp/services/config_service.dart';
import 'package:invapp/shared/platform_dialog.dart';
import 'package:invapp/widgets/logo_login.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget { @override _LoginScreenState createState() => _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {
  String version = '';
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
                LogoScreen(title: Enviroments.isProduction ? 'InvApp' : 'InvApp Dev'),
                FormLogin(),
                // LabelsLogin(
                // route: 'register',
                // title: '¿No tienes una cuenta?',
                // subtitle: 'Crear una cuenta!',
                // ),
                Text((Enviroments.isProduction) ? 'V$version' : 'V$version - dev',
                    style: TextStyle(fontWeight: FontWeight.w300))
              ],
            ),
          ),
        ),
      )
    );
  }

  checkVersion(context) async {
    ConfigService configService = new ConfigService();
    Config appConfig = await configService.getAppConfig();
    String platform = Platform.isAndroid ? 'android' : 'ios';
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() => this.version = info.version);
    int versionInstalada = int.parse(info.version.trim().replaceAll(".", ""));
    if (appConfig.inMaintenance) return platformBlockDialog(context, 'En Mantenimiento', 'Esperamos solucionar el problema lo mas pronto posible.\n\n - Emmanuel Correa ( Soporte Técnico )', 'cerrar');
    // this._stor.autoLoginDays = appConfig.autoLoginDays;
    int versionStore = appConfig.versionActualStore(platform);
    if (versionStore > versionInstalada) _showVersionDialog(context, appConfig, info.version);
  }

  _showVersionDialog(context, Config config, String versionActual) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String titulo = 'Nueva versión disponible';
        String mensaje = 'Hay una nueva versión disponible en las tiendas.\n\n'
            'Versión instalada: $versionActual\n'
            'Versión en las tiendas: ${config.androidVersion}\n\n'
            '¿Desea actualizar?';
        String btnActualizar = 'Actualizar';
        String btnCancelar = 'Cancelar';
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(titulo),
                content: Text(mensaje),
                actions: <Widget>[
                  TextButton(
                    child: Text(btnActualizar),
                    onPressed: () => _abrirURL(config.appStoreUrl),
                  ),
                  TextButton(
                    child: Text(btnCancelar),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(titulo),
                content: Text(mensaje),
                actions: <Widget>[
                  TextButton(
                    child: Text(btnActualizar),
                    onPressed: () => _abrirURL(config.playStoreUrl),
                  ),
                  TextButton(
                    child: Text(btnCancelar),
                    onPressed: () => Navigator.of(context).pop(),
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
