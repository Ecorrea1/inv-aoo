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

  @override
  Widget build( BuildContext context ) {
    final authService   = Provider.of<AuthService>( context );
     _addInfoController(

      name : authService.user.name,
      email: authService.user.email,
      pass : authService.user.pass,
    );
    
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
            placeholder: 'Contraseña - OPCIONAL',
            textController: passController,
            // isPass: true,
          ),
          CustomButtom(
            title: 'Actualizar Cuenta', 
            onPressed:() => _updatedUser(context, authService),
          ),
        ],
      ),
    );
  }

    _addInfoController({ name, email, pass}) async {

    nameController.text        = name;
    emailController.text       = email;
    passController.text        = pass;

  }

  _updatedUser(context, AuthService user) async {
    if ( nameController.text.isEmpty || emailController.text.isEmpty )  return showAlert(context, 'Actualizar Usuario', 'Ingrese algun dato por favor ');
    
    final _userService = UserService();

    final data = {
      'name'  : nameController.text,
      'email' : emailController.text,
      'user'  : emailController.text
    };

    if ( passController.text.isNotEmpty ) data['pass'] = passController.text;

    bool resp = await _userService.updateUser( uid: user.user.uid, data: data );

    if (resp) {

      _cleanController();
      showAlert(context, 'Actualizar Producto', 'El item se actualizo correctamente');
      Navigator.pushReplacementNamed( context, 'login' );
    } else {
      return showAlert(context, 'Actualizar Producto', 'Hubieron Problemas con la actualizacion del item');
    }
  }
  _cleanController(){
    nameController.text        = '';
    emailController.text       = '';
    passController.text        = '';
  }
}