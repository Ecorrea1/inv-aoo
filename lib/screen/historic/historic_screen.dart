import 'package:flutter/material.dart';
import 'package:invapp/models/historic/historic.model.dart';

class HistoricScreen extends StatelessWidget {

  @override
    Widget build( BuildContext context ) {

    Historic historic = ModalRoute.of( context ).settings.arguments;
    Size size         = MediaQuery.of( context ).size;
    
    return Scaffold(
      appBar: AppBar( elevation: 0.0 ),
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
      color: Theme.of( context ).primaryColor,
      child: Icon(
        Icons.history,
        size: 150,
        color: Colors.white,
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
          (historic.userName != null ) ? _historicItemData( Icons.contacts, historic.userName ) : Container(),
          (historic.action != null )   ? _historicItemData( Icons.poll, historic.action ) : Container(),
          (historic.description != null ) ? _historicItemData( Icons.poll, '${historic.description.substring(0,45)}...' ) : Container(),
          (historic.createdAt != null ) ? _historicItemData( Icons.code, historic.createdAt.toIso8601String()) : Container(),
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
}