import 'package:flutter/material.dart';
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/product.service.dart';
import 'package:invapp/utils/formatters/formatterText.dart';
import 'package:invapp/utils/formatters/uppercase_text_formatter.dart';
import 'package:invapp/widgets/list_tile_widget.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  final _productService = new ProductService();
  final _nameFilterController = new TextEditingController();

  @override
  void dispose() {
    //super.dispose();
    this._nameFilterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;
    List<String> dataGroup = ModalRoute.of(context).settings.arguments;
    _productService.getProductList(group: dataGroup[0].toString());

    return Scaffold(
      appBar: AppBar(
        title: TextField(
            controller: _nameFilterController,
            inputFormatters: [UpperCaseTextFormatter()],
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Busqueda de Inventario',
                hintStyle: TextStyle(color: Colors.white)),
            onChanged: (filter) => this._productService.applyFilter(filter)),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                _refreshList(dataGroup[0].toString());
              })
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: _productList(context, _productService),
      ),
      floatingActionButton: addProduct(dataGroup, context, user),
    );
  }

  FloatingActionButton addProduct(List<String> dataGroup, BuildContext context, User user) {
    if (dataGroup[0].toString() == 'Prestamos') return null;
    if (dataGroup[0].toString() == 'Eliminados') return null;
    if (!user.role.privileges.createProducts) return null;

    return FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: () => Navigator.pushNamed(context, 'add-product',arguments: dataGroup[0].toString()));
  }

  _refreshList(data) async {
    final refresh = await _productService.getProductList(group: data);

    (refresh.ok)
      ? print('Refresco correcto')
      : print('Hubo algun problema al recargar');
  }
}

Widget _productList(BuildContext context, ProductService service) {
  return StreamBuilder<List<Product>>(
      stream: service.productStream,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        if (snapshot.data.isEmpty) return Center( child: Text('No hay coincidencias', style: TextStyle(fontSize: 20),));

        List<Product> listStream = snapshot.data;
        List<Widget> listProduct = [];

        for (final product in listStream)  listProduct.add(_product(context, product));
        return Wrap(alignment: WrapAlignment.start, children: listProduct);
      });
}

Widget _product(BuildContext context, Product product) {
  return ListTileCustom(
      leading: CircleAvatar(
        child: Text(product.quantity.toString()),
        backgroundColor: _selectedColor(product.quantity),
      ),
      backgroundColor: (product.active) ? Colors.white : Colors.red,
      title: Text( product.name),
      subtitle: Text( product.category),
      trailing: Text( formatterPrice(product.price), style: TextStyle(fontSize: 20)),
      onTap: () => Navigator.pushNamed(context, 'product-detail', arguments: product)
    );
}

_selectedColor( int action ) {
  switch ( action ) {
    case 0: return Colors.red;
    case 1: return Colors.yellow;
    default: return Colors.blue;
  }
}
