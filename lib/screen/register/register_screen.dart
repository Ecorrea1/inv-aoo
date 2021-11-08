import 'package:flutter/material.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/widgets/alert.dart';
import 'package:invapp/widgets/buttons.dart';
import 'package:invapp/widgets/custom_iput.dart';
import 'package:invapp/widgets/labels_login.dart';
import 'package:invapp/widgets/logo_login.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    

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
              LogoScreen( title: 'Crear cuenta',),
              _FormLogin(),
              // LabelsLogin(
              //   route: 'login',
              //   title: 'Tienes tu cuenta',
              //   subtitle: 'Ingresa tu cuenta',
              // ),
              // Text('Terminos de Uso', style: TextStyle( fontWeight: FontWeight.w300 ),)
              GestureDetector(
                child: Text('Volver', style: TextStyle( fontWeight: FontWeight.w300 ),),
                onTap: () => Navigator.pop(context),

              )
            ],
            ),
          ),
        ),
      )
    );
  }
}

class _FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<_FormLogin> {

  final nameController  = TextEditingController();
  final emailController = TextEditingController();
  final passController  = TextEditingController();

  @override
  Widget build( BuildContext context ) {
    final authService   = Provider.of<AuthService>( context );
    final userEmail     = ModalRoute.of(context).settings.arguments;
    return Container(
      margin: EdgeInsets.only( top: 5 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: [
          CustomImput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            textController: nameController, 
          ),
          CustomImput(
            icon: Icons.email_outlined,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomImput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passController,
            isPass: true,
          ),
          CustomButtom(
            title: 'Crear Cuenta', 
            onPressed: authService.authentify ? null : () async {
              FocusScope.of( context ).unfocus();
              final registerOk = await authService.register( name :nameController.text.trim(), email: emailController.text.trim(), pass: passController.text.trim(), user :userEmail );
              if( registerOk != null ) {

                // showAlert( context, 'Registro Exitoso', registerOk.toString() );
                Navigator.pushReplacementNamed( context, 'menu' ); 
              
              } else {
                showAlert( context, 'Registro incorrecto', registerOk.toString() );
              }
            }
          ),
        ],
      ),
    );
  }
}