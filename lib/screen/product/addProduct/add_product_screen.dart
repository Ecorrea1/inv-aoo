import 'package:flutter/material.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/category.service.dart';
import 'package:invapp/services/product.service.dart';
import 'package:invapp/services/ubication.service.dart';
import 'package:invapp/widgets/alert.dart';
import 'package:invapp/widgets/buttons.dart';
import 'package:invapp/widgets/custom_iput.dart';
import 'package:invapp/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {

  final nameController        = TextEditingController();
  final quantityController    = TextEditingController();
  final priceController       = TextEditingController();
  final observationController = TextEditingController();
  
  final _productService       = new ProductService();
  final _ubicationService     = new UbicationService();
  final _categoryService      = new CategoryService();
  
  String groupName            = '';
  String categoryNew          = '';
  String ubicationNew         = '';

  @override
  Widget build( BuildContext context ) {

    final authService   = Provider.of<AuthService>( context, listen : false );
    final user          = authService.user;

    groupName = ModalRoute.of(context).settings.arguments;
    _cleanControllers();

    return FutureBuilder(
      future: Future.wait([
        _ubicationService.getUbications(),
        _categoryService.getCategories()
      ]),
      builder: ( BuildContext context, AsyncSnapshot snapshot ) {

        if ( !snapshot.hasData ) return Container( child: Center( child: CircularProgressIndicator() ), color: Colors.white );
        
        List<String> pos  = [];
        List<String> cate = [];

        final ubications  = snapshot.data[0];
        final categories  = snapshot.data[1];

        final position    = ubications.data;
        final category    = categories.data;

        for ( var item in position ) { pos.add(  item.name ); }
        for ( var item in category ) { cate.add( item.name ); }

        return Scaffold(
          appBar: AppBar(
            title: Text( groupName ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only( top: 10 ),
                padding: EdgeInsets.symmetric( horizontal: 32 ),
                child: Column(
                  children: [
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
                      placeholder: 'Ingrese cantidad',
                      textController: quantityController,
                      keyboardType: TextInputType.number,
                    ),
                    CustomImput(
                      icon: Icons.attach_money_sharp,
                      labelText: 'Precio',
                      placeholder: 'Ingrese precio',
                      keyboardType: TextInputType.number,
                      textController: priceController
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownCustom( 
                        items: cate,
                        outlined: true,
                        onChange: ( option ) => categoryNew = option 
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownCustom( 
                        items: pos, 
                        outlined: true, 
                        onChange: ( option ) => ubicationNew = option 
                      ),
                    ),

                    CustomImput(
                      icon: Icons.clear_all_sharp,
                      labelText: 'Observacion',
                      placeholder: '(Optional) Ingrese comentarios',
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      textController: observationController
                    ),

                    CustomButtom(
                      title: 'Crear Producto', onPressed:() => _sendInformation( context, user.email )
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

  _sendInformation( context ,String user ) async {

    if ( nameController.text.isEmpty || quantityController.text.isEmpty || priceController.text.isEmpty ) {

      return showAlert(context, 'Agregar Producto', 'Ingrese algun dato por favor ');
      
    }

    final data = {

      'name'          : nameController.text,
      'quantity'      : int.parse( quantityController.text ),
      'price'         : int.parse( priceController.text ),
      'category'      : categoryNew,
      'group'         : groupName,
      'ubication'     : ubicationNew,
      'observations'  : observationController.text,
      'user'          : user
    
    };

    bool resp = await _productService.addNewProduct( data: data );

    if (resp) {

      print('Producto Creado');
      _cleanControllers();
      return showAlert(context, 'Agregar Producto', 'El item se agrego correctamente');
    
    } else {
      return showAlert(context, 'Agregar Producto', 'Hubieron Problemas con la creacion del item');
    }
  }
  _cleanControllers(){

    nameController.text        = '';
    quantityController.text    = '';
    priceController.text       = '';
    categoryNew                = '';
    ubicationNew               = '';
    observationController.text = '';

    print(groupName);

  }
}
