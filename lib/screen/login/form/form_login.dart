import 'package:flutter/material.dart';
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
              bool loginOk = await authService.login( emailController.text.trim(), passController.text.trim() );
              ( loginOk ) 
              ? Navigator.pushReplacementNamed( context, 'menu' ) 
              : showAlert( context,'Alerta','Tuvimos algunos problemas al iniciar sesion' );
            }
          ),
        ],
      ),
    );
  }
}