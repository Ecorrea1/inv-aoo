import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/screen/login/form/form_login.dart';
import 'package:invapp/widgets/logo_login.dart';
// import 'package:package_info/package_info.dart';

class LoginScreen extends StatelessWidget {

  // PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // final String appName = packageInfo.appName;
  // final String packageName = packageInfo.packageName;
  // final String buildNumber = packageInfo.buildNumber;
  // final String version = packageInfo.version;
  final String version = '1.1.1';
  final bool earlyAccess = true;
  final bool inMaintenance = true;

  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      backgroundColor: Color( 0xffF2F2F2 ),
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
              Text( (earlyAccess) ? 'V$version - beta': 'V$version', style: TextStyle( fontWeight: FontWeight.w300 ) )
            ],
          ),
          ),
        ),
      )
    );
  }
}
