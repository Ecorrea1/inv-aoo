import 'package:flutter/material.dart';
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/category.service.dart';
import 'package:invapp/services/product.service.dart';
import 'package:invapp/services/ubication.service.dart';
import 'package:invapp/widgets/alert.dart';
import 'package:invapp/widgets/buttons.dart';
import 'package:invapp/widgets/custom_iput.dart';
import 'package:invapp/widgets/dropdown_widget.dart';
import 'package:invapp/widgets/switchs_widget.dart';
import 'package:provider/provider.dart';

class UpdateProductScreen extends StatelessWidget {

  final nameController        = TextEditingController();
  final quantityController    = TextEditingController();
  final priceController       = TextEditingController();
  final observationController = TextEditingController();
  final _productService       = new ProductService();
  final _ubicationService     = new UbicationService();
  final _categoryService      = new CategoryService();
  String categoryNew          = '';
  String ubicationNew         = '';
  bool   update               = false;
  bool   turn;

  @override
  Widget build( BuildContext context ) {
    final authService   = Provider.of<AuthService>( context, listen : false );
    final user          = authService.user;
    Product  product    = ModalRoute.of(context).settings.arguments;
    
    _addInfoController(
      name       : product.name,
      quantity   : product.quantity,
      price      : product.price,
      ubication  : product.ubication,
      category   : product.category,
      observation: product.observations,
      active     : product.active
    );

    return FutureBuilder(
      future: Future.wait([
        _ubicationService.getUbications(),
        _categoryService.getCategories()
      ]),
      builder: ( BuildContext context, AsyncSnapshot snapshot ) {

        if ( !snapshot.hasData ) return Container( child: Center( child: CircularProgressIndicator() ), color: Colors.white );
        
        List<String> pos    = [];
        List<String> cate   = [];
        final ubications  = snapshot.data[0];
        final categories  = snapshot.data[1];
        final position    = ubications.data;
        final category    = categories.data;
        for ( var item in position ) { pos.add( item.name );  }
        for ( var item in category ) { cate.add( item.name ); }
        int defaultPosition = pos.indexOf(product.ubication) != -1 ? pos.indexOf(product.ubication) : 0;
        int defaultCategory = cate.indexOf(product.category) != -1 ? cate.indexOf(product.category) : 0;

        return Scaffold(
          appBar: AppBar(
            title: Text( product.name.toString() ),
            elevation: 0.0 
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only( top: 10 ),
                padding: EdgeInsets.symmetric( horizontal: 15 ),
                child: Column(
                  children: [
                    SwitchCustom( 
                      title: 'Activo', 
                      item: turn,
                      onChange: ( option ) => turn = option
                    ),
                    CustomImput(
                      icon: Icons.data_usage_rounded,
                      labelText: 'Nombre',
                      placeholder: 'Ingrese nombre',
                      textCapitalization: TextCapitalization.sentences,
                      textController: nameController 
                    ),
                    CustomImput(
                      icon: Icons.add_shopping_cart,
                      labelText: 'Cantidad',
                      placeholder: 'Ingrese Cantidad',
                      textController: quantityController,
                      keyboardType: TextInputType.number,
                    ),
                    CustomImput(
                      icon: Icons.attach_money_sharp,
                      labelText: 'Precio',
                      placeholder: 'Ingrese Precio',
                      keyboardType: TextInputType.number,
                      textController: priceController
                    ),
                    Text('Categorias'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownCustom( 
                        defaultItem: defaultCategory,
                        items: cate,
                        outlined: true,
                        center: true,
                        onChange: ( option ) => categoryNew = option 
                      ),
                    ),
                    Text('Ubicaciones'),
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownCustom(
                        defaultItem: defaultPosition,
                        items: pos, 
                        outlined: true,
                        center: true,
                        onChange: ( option ) => ubicationNew = option 
                      ),
                    ),
                    CustomImput(
                      icon: Icons.clear_all_sharp,
                      labelText: 'Observaciones',
                      placeholder: '(Opcional) - Ingrese Observacion',
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: ( observationController.value.text.length <= 37 ) ? 1 : 3,
                      textController: observationController
                    ),
                    CustomButtom( 
                      title: 'Actualizar Producto', 
                      onPressed: () => _updateInformation( context, user.email, product )
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }



  _updateInformation( context , String user, Product product ) async {
    if ( nameController.text.isEmpty || quantityController.text.isEmpty || priceController.text.isEmpty ) return showAlert(context, 'Agregar Producto', 'Ingrese algun dato por favor ');
    final data = {
      'name'          : nameController.text,
      'quantity'      : int.parse( quantityController.text ),
      'price'         : int.parse( priceController.text ),
      'group'         : ( categoryNew == 'Prestamo' ) ? 'Prestamos' : product.group,
      'category'      : categoryNew,
      'ubication'     : ubicationNew,
      'observations'  : observationController.text,
      'active'        : turn,
      'user'          : user
    };

    bool resp = await _productService.updateProduct( uid: product.id, data: data );

    if (resp) {
      _cleanController();
      return showAlert(context, 'Actualizar Producto', 'El item se actualizo correctamente');
    } else {
      return showAlert(context, 'Actualizar Producto', 'Hubieron Problemas con la actualizacion del item');
    }
  }

  _addInfoController({ name, quantity, price, category, ubication, observation, active}) async {
    nameController.text        = name;
    quantityController.text    = quantity.toString();
    priceController.text       = price.toString();
    categoryNew                = category;
    ubicationNew               = ubication;
    observationController.text = observation;
    turn                       = active;
  }

  _cleanController() {
    nameController.text        = '';
    quantityController.text    = '';
    priceController.text       = '';
    categoryNew                = 'Seleccione Categoria';
    ubicationNew               = 'Seleccione Ubicacion';
    observationController.text = '';
  }
}
