import 'package:flutter/material.dart';
import 'package:invapp/models/historic/historic.model.dart';
import 'package:invapp/utils/icons_string_util.dart';

class HistoricScreen extends StatelessWidget {

  @override
    Widget build( BuildContext context ) {

    Historic historic = ModalRoute.of( context ).settings.arguments;
    Size size         = MediaQuery.of( context ).size;
    
    return Scaffold(
      appBar: AppBar( elevation: 0.0, backgroundColor: _selectedOption(historic.action, false), ),
      body: Container(
        child: Column(
          children: <Widget>[
            _historicHeader( context, size, historic ), 
            _historicListData( size, historic )
          ],
        ),
      )
    );
  }

  Widget _historicHeader( context, size, Historic historic ) {
    return Container(
      width: size.width,
      height: size.height * 0.25,
      color: _selectedOption(historic.action, false),
      child: Icon(
         getIcon( _selectedOption(historic.action, true) ),
        size: 150,
        color:Colors.white,
      )
    );
  }

  _historicListData( size, Historic historic ) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          ( historic.userName != null ) ? _historicItemData( Icons.contact_mail, historic.userName ) : Container(),
          ( historic.action != null )   ? _historicItemData( Icons.history, historic.action ) : Container(),
          ( historic.createdAt != null ) ? _historicItemData( Icons.date_range,  historic.createdAt.toString().substring(0, 19) ) : Container(),
          ( historic.description != null ) ? _messegeHistoric( Icons.poll, historic.description, size ): Container(),
        ],
      ),
    );
  }

  Widget _historicItemData( IconData icono, String data ) {
    return Column(
      children: [
        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Icon( icono, size: 25.0 ),
          Text( data, style: TextStyle( fontSize: 15.0 )),
        ]),
        Divider(),
      ],
    );
  }

  Widget _messegeHistoric(IconData icono, String messege, Size size ) {
    return Column(
      children: [
        Text('Descripción:', style: TextStyle( fontSize: 15.0, height: size.height * 0.002 )),
        Container(
          padding: EdgeInsets.only( top: 5.0 ),
          width: size.width,
          child: Text(
            messege,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          )
        ),
      ],
    );
  }

   _selectedOption( String action, bool options ) {
    if (action.contains('Actualizacion') || action.contains('Actualizado')) return options ? 'FAuserEdit': Colors.green;
    if (action.contains('Eliminacion')) return options ? 'FAuserTimes' : Colors.red;
    if (action.contains('Creado')) return options ? 'FAuserPlus' : Colors.yellow;
    return options ? 'FAuser' : Colors.blue;
  }
}