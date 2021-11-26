import 'package:flutter/material.dart';
import 'package:invapp/models/category/category.model.dart';
import 'package:invapp/services/auth_service.dart';
import 'package:invapp/services/category.service.dart';
import 'package:invapp/utils/icons_string_util.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {

  final _categorySVC = new CategoryService();

  @override
    Widget build( BuildContext context ) {
    
    final authService   = Provider.of<AuthService>( context, listen : false );
    final user          = authService.user;
    Category category = ModalRoute.of( context ).settings.arguments;
    Size size         = MediaQuery.of( context ).size;
    
    return Scaffold(
      appBar: AppBar(
        actions: [ 
          !!user.role.privileges.deleteCategory
          ? IconButton( icon: Icon(Icons.delete, color: Colors.white), onPressed: () { _deleteInfo( context, category, user.email ); } )
          : Container()
        ], 
        elevation: 0.0 
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _categoryHeader( context, size, category ), 
            _categoryListData( size, category )
          ],
        ),
      ),
      floatingActionButton: 
      user.role.privileges.modifyCategory
      ?FloatingActionButton(
        child: Icon( Icons.edit ),
        elevation: 1,
        onPressed: () => Navigator.pushNamed( context, 'update-category', arguments: category )
      )
      : Container(),
      
    );
  }

  Widget _categoryHeader( context, size, Category category ) {
    return Container(
      width: size.width,
      height: size.height * 0.25,
      color: Theme.of( context ).primaryColor,
      child: Icon(
        getIcon( category.icon ),
        size: 150,
        color: Colors.white,
      )
    );
  }

  _categoryListData( size, Category category ) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _categoryItemData( title: 'Nombre',data: category.name ),        
          _categoryItemData( title: 'Icono',data: category.icon ),           
          _categoryItemData( title: 'Activo',data: category.active.toString(), color: ( category.active ) ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Widget _categoryItemData( { @required String data , @required title, Color color } ) {
    
    if( data.isEmpty ) return Container();
    return Column(
      children: [
        Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text( 
              '$title :',
              style: TextStyle( 
                fontSize: 15,
                fontWeight: FontWeight.bold
              )          
            ),
            SizedBox( width: 10 ),
            Text( 
              data, 
              style: TextStyle( 
                fontSize: 15.0,
                color: (color == null ) ? Colors.black : color
              ),
            ),
          ]
        ),
        Divider(height: 20,),
      ],
    );
  }

  _deleteInfo( context, Category category, String user ) async {

    final delete = await _categorySVC.deleteCategory( uid: category.id, user: user );
    print( 'Esto es el :  $delete' );
    if ( delete ) {
      print('Eliminacion de ubicacion sin problemas');
    } else {
      print('Tuvo algunos problemas');
    }
    Navigator.pop(context);
  }
}