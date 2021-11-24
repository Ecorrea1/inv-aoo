import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/product.service.dart';
import 'package:invapp/widgets/alert.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final _productSVC = new ProductService();
  final quantityController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    User user = authService.user;
    Product product = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(actions: [
        (user.role.privileges.deleteProducts) 
          ? IconButton( icon: Icon(Icons.delete, color: Colors.white), onPressed:() { _deleteInfo(context, product, user); } )
          : Container()
        ,
        (user.role.privileges.modifyProducts) 
          ? IconButton(icon: Icon(Icons.update_outlined, color: Colors.white), onPressed: () {_updateProduct(context, product, user);}) 
          : Container(),
        ], elevation: 0.0
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _productHeader(context, size, product),
            _productListData(size, product)
          ],
        ),
      ),
      floatingActionButton: newMethod(user, context, product),
    );
  }

  FloatingActionButton newMethod(User user, BuildContext context, Product product) {
    if(!user.role.privileges.modifyProducts) return null;

    return FloatingActionButton(
        child: Icon(Icons.edit),
        elevation: 1,
        onPressed: () => Navigator.pushNamed(context, 'update-product', arguments: product)
    );
  }

  Widget _productHeader(context, size, product) {
    return Container(
        width: size.width,
        height: size.height * 0.25,
        color: Theme.of(context).primaryColor,
        child: Icon(
          Icons.person,
          size: 150,
          color: Colors.white,
        ));
  }

  _productListData(size, Product product) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.63,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _productItemData(title: 'Nombre', data: product.name),
          _productItemData(title: 'Categoria', data: product.category),
          _productItemData(
              title: 'Cantidad', data: product.quantity.toString()),
          _productItemData(title: 'Ubicacion', data: product.ubication),
          _productItemData(title: 'Grupo', data: product.group),
          _productItemData(title: 'Precio', data: product.price.toString()),
          _productItemData(title: 'Observacion', data: product.observations),
          _productItemData(
              title: 'Activo',
              data: product.active.toString(),
              color: (product.active) ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Widget _productItemData(
      {@required String data, @required title, Color color}) {
    //
    if (data == null || data.isEmpty) return Container();
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: 15,
        //     fontWeight: FontWeight.bold
        //   ),
        // ),
        // SizedBox( height: 5 ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('$title :',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text(
                data,
                style: TextStyle(
                    fontSize: 15.0,
                    color: (color == null) ? Colors.black : color),
              ),
            ]),
        Divider(height: 20),
      ],
    );
  }

  _updateProduct(context, Product product, User user) async {
    if (user.role.privileges.modifyProducts) return null;

    if (Platform.isAndroid) {
      // Android
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Prestamo de producto:'),
            content: Column(
              children: [
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                      // labelText: labelText,
                      // alignLabelWithHint: true,
                      // prefixText: 'Hola Mundo',
                      // prefixIcon: Icon( icon ),
                      // focusedBorder: InputBorder.none,
                      // border: InputBorder.none,
                      hintText: 'Ingresa cantidad'),
                ),
                SizedBox(height: 3),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      // labelText: labelText,
                      // alignLabelWithHint: true,
                      // prefixText: 'Hola Mundo',
                      // prefixIcon: Icon( icon ),
                      // focusedBorder: InputBorder.none,
                      // border: InputBorder.none,
                      hintText: 'Ingresa '),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text('Prestar'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => _updateInfo(context, product, user))
            ],
          );
        },
      );
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Prestamo de producto:'),
            content: Column(
              children: [
                CupertinoTextField(
                  placeholder: 'Ingresa cantidad',
                  controller: quantityController,
                ),
                SizedBox(height: 3),
                CupertinoTextField(
                  placeholder: 'Ingresa nombre  prestado',
                  controller: nameController,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Prestar'),
                  onPressed: () => _updateInfo(_, product, user)),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.pop(_))
            ],
          );
        });
  }

  _updateInfo(context, Product product, User user) async {
    if (quantityController.text.isEmpty || nameController.text.isEmpty)
      return showAlert(
          context, 'Prestar Producto', 'Ingrese algun dato por favor ');

    String obs =
        '${user.name} presto este item a ${nameController.text} ${quantityController.text} de ${product.quantity}  del grupo: ${product.group}, categoria: ${product.category} /  Datos de Observacion :  ${product.observations} ';
    int cant = product.quantity - int.parse(quantityController.text);

    final data = {
      'quantity': (cant == 0) ? 0 : cant,
      'group': 'Prestamos',
      'category': 'Prestamo',
      'observations': obs,
      'user': user.email
    };

    bool resp = await _productSVC.updateProduct(uid: product.id, data: data);

    if (resp) {
      return showAlert(
          context, 'Actualizar Producto', 'El item se actualizo correctamente');
    } else {
      return showAlert(context, 'Actualizar Producto',
          'Hubieron Problemas con la actualizacion del item');
    }
  }

   _deleteInfo(context, Product product, User user) async {
    if (user.role.privileges.createUsers) return null;
    final delete = await _productSVC.deleteProduct(uid: product.id, user: user.email);

    if (delete) {
      bool resp = await showAlert(
          context, 'Eliminacion de producto', 'Eliminacion exitosa');
      print(resp);
    } else {
      showAlert(context, 'Eliminacion de producto', 'Tuvimos un problema');
    }
    // Navigator.pop(context);
  }
}
