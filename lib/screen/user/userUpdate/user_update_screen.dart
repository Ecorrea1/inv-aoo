import 'package:flutter/material.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/user_service.dart';
import 'package:invapp/widgets/alert.dart';
import 'package:invapp/widgets/buttons.dart';
import 'package:invapp/widgets/custom_iput.dart';
import 'package:provider/provider.dart';

class UserUpdateScreen extends StatelessWidget {
  const UserUpdateScreen ({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color( 0xffF2F2F2 ),
      appBar: AppBar(
        title: Text('Cambio de contraseña'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FormUpdated(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormUpdated extends StatefulWidget {
  @override
  _FormUpdatedState createState() => _FormUpdatedState();
}

class _FormUpdatedState extends State<_FormUpdated> {
  final nameController  = TextEditingController();
  final emailController = TextEditingController();
  final passController  = TextEditingController();
  final pass2Controller  = TextEditingController();
  String pass1 = '';
  @override
  Widget build( BuildContext context ) {
    final authService   = Provider.of<AuthService>( context );
     _addInfoController(
      name : authService.user.name,
      email: authService.user.email,
      pass : authService.user.pass,
    );
    return Container(
      margin: EdgeInsets.only( top: 20 ),
      padding: EdgeInsets.symmetric( horizontal: 30 ),
      child: Column(
        children: [
          CustomImput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            textController: nameController,
            enabled: (authService.user.resetPassCode) ? false : true,
          ),
          CustomImput(
            icon: Icons.email_outlined,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
            enabled: (authService.user.resetPassCode) ? false : true,
          ),
          CustomImput(
            icon: Icons.lock_outline,
            placeholder: (authService.user.resetPassCode) ? 'Contraseña - OBLIGATORIO':'Contraseña - OPCIONAL',
            textController: passController,
            isPass: true,
          ),
          CustomImput(
            icon: Icons.lock_outline,
            placeholder: (authService.user.resetPassCode) ? 'Repita Contraseña' : 'Repita Contraseña si desea cambiarla',
            textController: pass2Controller,
            isPass: true,
          ),
          CustomButtom(
            title: 'Actualizar Cuenta', 
            onPressed: () => _updatedUser(context, authService),
          ),
        ],
      ),
    );
  }

  _addInfoController({ name, email, pass}) async {
    nameController.text  = name;
    emailController.text = email;
    passController.text  = pass;
  }

  _updatedUser(context, AuthService user) async {
    if(nameController.text.trim() == user.user.name &&  emailController.text.trim() == user.user.email) return showAlert(context, 'Error', 'No hay cambios para actualizar');
    if ( nameController.text.isEmpty || emailController.text.isEmpty )  return showAlert(context, 'Actualizar Usuario', 'Ingrese algun dato por favor ');
    final _userService = UserService();
    Map<String, dynamic> data = {
      'name'  : nameController.text,
      'email' : emailController.text,
      'user'  : emailController.text
    };

    if (passController.text.isEmpty && pass2Controller.text.isNotEmpty) return showAlert(context, 'Actualizar Usuario', 'Las contraseñas no coinciden');
    if ( passController.text.isNotEmpty ) {
      if ( passController.text.trim() == user.user.pass ) return showAlert(context, 'Actualizar Usuario', 'La contraseña no puede ser igual a la anterior');
      if ( passController.text.length < 6 ) return showAlert(context, 'Actualizar Usuario', 'La contraseña debe tener al menos 6 caracteres');
      if ( pass2Controller.text.isEmpty ) return showAlert(context, 'Actualizar Usuario', 'Repita la contraseña por favor');
      if ( passController.text != pass2Controller.text ) return showAlert(context, 'Actualizar Usuario', 'Las contraseñas no coinciden');
      data['pass'] = passController.text;
      if ( user.user.resetPassCode ) data['resetPassCode'] = false;
    }
    
    bool resp = await _userService.updateUser( uid: user.user.uid, data: data );
    if (!resp)  return showAlert(context, 'Actualizar Producto', 'Hubieron Problemas con la actualizacion del item');
    _cleanController();
    showAlert(context, 'Actualizar Usuario', 'El usuario se actualizo correctamente');
    Navigator.pushReplacementNamed( context, 'login' );
  }

  _cleanController(){
    nameController.text  = '';
    emailController.text = '';
    passController.text  = '';
  }
}