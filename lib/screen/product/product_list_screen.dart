import 'package:flutter/material.dart';
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/services/product.service.dart';
import 'package:invapp/utils/formatters/uppercase_text_formatter.dart';

class ProductListScreen extends StatelessWidget {
  final _productService       = new ProductService();
  final _nameFilterController = new TextEditingController();
  
  @override
  void dispose() {
    //super.dispose();
    this._nameFilterController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    List<String> dataGroup = ModalRoute.of( context ).settings.arguments;
   _productService.getProductList( group: dataGroup[0].toString() );

    return Scaffold(
      appBar: AppBar(
        title:TextField(
          controller: _nameFilterController,
          inputFormatters: [ UpperCaseTextFormatter() ],
          style: TextStyle( color: Colors.white ),
          decoration: InputDecoration( hintText: 'Busqueda de Inventario', hintStyle: TextStyle( color: Colors.white )),
          onChanged: ( filter ) => this._productService.applyFilter( filter )
        ),
        actions: [ IconButton( icon: Icon (Icons.refresh , color: Colors.white ), onPressed:(){ _refreshList( dataGroup[0].toString() ); }) ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: _productList( context, _productService ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        elevation: 1,
        onPressed:() => Navigator.pushNamed( context, 'add-product', arguments: dataGroup[0].toString() )
      ),
    );
  }

  _refreshList( data ) async {

    final refresh = await _productService.getProductList( group: data );

    ( refresh.ok ) ? print('Refresco correcto') : print('Hubo algun problema al recargar');

  }
}

  Widget _productList( BuildContext context, ProductService service ) {

    return StreamBuilder<List<Product>> (
      
      stream: service.productStream,
      builder: ( BuildContext context, AsyncSnapshot<List<Product>> snapshot ) {

        if ( !snapshot.hasData )      return Center( child: CircularProgressIndicator() );
        if ( snapshot.data.isEmpty )  return Center( child: Text( 'No hay coincidencias', style: TextStyle( fontSize: 20 ),));
        
        List<Product> listStream  = snapshot.data;
        List<Widget>  listProduct = [];
        
        for ( final product in listStream ) { listProduct.add( _product( context, product )); }

        return Wrap( alignment: WrapAlignment.start, children: listProduct );

      }
    );
  }

  Widget  _product( BuildContext context, Product product ) {

    return ListTile(

      leading: CircleAvatar(
        child: Text( product.category.substring( 0, 2 ) ),
        backgroundColor: Colors.blue[100],
      ),
      tileColor: ( product.active ) ? Colors.white : Colors.grey,
      title:    Text( product.name ),
      subtitle: Text( product.category ),
      trailing: Text( product.quantity.toString(), style: TextStyle( fontSize: 20 ) ),
      onTap: () => Navigator.pushNamed( context, 'product-detail', arguments: product )
    );
  }