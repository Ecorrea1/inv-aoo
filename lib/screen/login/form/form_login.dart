import 'package:flutter/material.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/widgets/alert.dart';
import 'package:invapp/widgets/buttons.dart';
import 'package:invapp/widgets/custom_iput.dart';
import 'package:provider/provider.dart';

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final emailController = TextEditingController();
  final passController  = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final authService   = Provider.of<AuthService>( context );
    return Container(
      margin: EdgeInsets.only( top: 0 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: [
          CustomImput(
            icon: Icons.email_outlined,
            // labelText: 'Correo',
            placeholder: 'Ingrese su correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
            
          ),
          CustomImput(
            icon: Icons.lock_outline,
            // labelText: 'Contraseña',
            placeholder: 'Ingrese su contraseña',
            textController: passController,
            isPass: true,
          ),
          CustomButtom(
            title: 'Ingrese', 
            onPressed: authService.authentify ? null : () async{
              FocusScope.of( context ).unfocus();
              final resp = await authService.login( emailController.text.trim(), passController.text.trim() );
              if( resp == null ) return showAlert( context,'Alerta','Tuvimos un problema al conectarnos con el servidor' );
              if( resp == false ) return showAlert( context,'Alerta','Tuvimos un problema al iniciar sesion, verificar Credenciales de acceso' );
              User user = resp;
              user.resetPassCode 
              ? Navigator.pushNamed( context, 'user-update' )
              : Navigator.pushReplacementNamed( context, 'menu' );
            }
          ),
        ],
      ),
    );
  }
}