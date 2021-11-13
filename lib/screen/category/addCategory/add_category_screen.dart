import 'package:flutter/material.dart';
import 'package:invapp/services/category.service.dart';
import 'package:invapp/services/product.service.dart';
import 'package:invapp/services/ubication.service.dart';
import 'package:invapp/widgets/buttons.dart';
import 'package:invapp/widgets/custom_iput.dart';
import 'package:invapp/widgets/dropdown_widget.dart';

class AddCategoryScreen extends StatelessWidget {

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
  Widget build(BuildContext context) {

    groupName = ModalRoute.of(context).settings.arguments;

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

        for ( var item in position ) { pos.add( item.name );  }
        for ( var item in category ) { cate.add( item.name ); }

        return Scaffold(
          appBar: AppBar(
            title: Text('New Prod. de ${groupName.toString()}'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    CustomImput(
                      icon: Icons.ac_unit,
                      placeholder: 'Ingrese nombre',
                      textController: nameController),
                    CustomImput(
                      icon: Icons.add_chart,
                      placeholder: 'Ingrese cantidad',
                      textController: quantityController,
                      keyboardType: TextInputType.number,
                    ),
                    CustomImput(
                      icon: Icons.clear_all_sharp,
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
                      placeholder: '(Optional) Ingrese comentarios',
                      keyboardType: TextInputType.multiline,
                      textController: observationController
                    ),

                    CustomButtom(
                      title: 'Crear Producto', onPressed: _sendInformation)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _sendInformation() async {

    final data = {
      'name'          : nameController.text,
      'quantity'      : int.parse( quantityController.text ),
      'price'         : int.parse( priceController.text ),
      'category'      : categoryNew,
      'group'         : groupName.toString(),
      'ubication'     : ubicationNew,
      'observations'  : observationController.text
    };

    final bool resp = await _productService.addNewProduct( data: data );

    if (resp) {

      print('Producto Creado');
      nameController.text        = '';
      quantityController.text    = '';
      priceController.text       = '';
      categoryNew                = '';
      ubicationNew               = '';
      observationController.text = '';
    
    } else {
      print('Problemas al crear Producto');
    }

    return print( data );
  }
}
