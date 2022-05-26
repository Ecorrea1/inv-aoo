import 'package:flutter/material.dart';
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/product.service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final _productService = new ProductService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;
    _productService.getProductList(group: 'Todos');
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${user.name}'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            totalProducts(context, _productService),
            Container(
              padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.02),
              child: Column(
                children: [
                 _userData(data: user.role.name, title: 'Rol'),
                 _userData(data: user.email, title: 'Email'),
                 _userData(data: user.role.menuOptions.length.toString(), title: 'Cantidad de menus Asignados'),
                 _userData(data: user.role.groupOptions.length.toString(), title: 'Cantidad de grupos Asignados'),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () =>  Navigator.pushNamed( context, 'user-update' )
      ),
    );
  }

  Widget totalProducts(BuildContext context, ProductService service) {
    return StreamBuilder<List<Product>>(
        stream: service.productStream,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          if (snapshot.data.isEmpty) return Center( child: Text('No hay Datos', style: TextStyle(fontSize: 20),));
          final data = snapshot.data;
          int gift = data.where((p) => p.group == 'Prestamos').length;
          int deleted = data.where((p) => p.group == 'Eliminados').length;
          int actives = data.where((p) => p.group != 'Eliminados' && p.group != 'Prestamos' ).length;
          int total = data.length;
          return Container(
              child: Column(
            children: [
              Text('Productos:', style: TextStyle(fontSize: 20)),
              _containerDetails(context,'Totales', total.toString()),
              _containerDetails(context,'Disponibles', actives.toString()),
              _containerDetails(context,'Prestados', gift.toString()),
              _containerDetails(context,'Eliminados', deleted.toString()),
            ],
          ));
        });
  }

  Container _containerDetails(BuildContext context,String title, String data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.10,
      color:  _selectedColor(title),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(data, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white)),
        ],
      ),
    );
  }

    Widget _userData({@required String data, @required title}) {
    if ( data == null || data.isEmpty) return Container();
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('$title :', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Text(data, style: TextStyle( fontSize: 15.0, color: Colors.black),),
            ]),
        Divider(height: 20),
      ],
    );
  }

  _selectedColor(String action) {
    switch (action) {
      case 'Disponibles':
        return Colors.purple;
      case 'Eliminados':
        return Colors.red;
      case 'Prestados':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
