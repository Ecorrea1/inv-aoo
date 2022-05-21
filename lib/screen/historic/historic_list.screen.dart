import 'package:flutter/material.dart';
import 'package:invapp/models/historic/historic.model.dart';
import 'package:invapp/services/historic_service.dart';
import 'package:invapp/widgets/list_tile_widget.dart';

class HistoricListScreen extends StatelessWidget {
  final _historicSvc = new HistoricService();
  @override
  Widget build(BuildContext context) {
    _historicSvc.getHistorics();
    return Scaffold(
      appBar: AppBar( title: Text( 'Historial' ) ),
      body: SingleChildScrollView(
        child: listHistorial()
      ),      
    );
  }
   StreamBuilder<List<Historic>> listHistorial() {
    return StreamBuilder<List<Historic>>(
      stream: _historicSvc.historicStream,
      builder: ( BuildContext context, AsyncSnapshot<List<Historic>> snapshot ) {
        if ( !snapshot.hasData && snapshot.data == null ) return Center( child: CircularProgressIndicator() );
        List listStream = snapshot.data;
        List<Widget> listHistoric  = [];
        for ( final data in listStream ) { listHistoric.add( _groupTile( context, data) ); }
        return Wrap( alignment: WrapAlignment.start, children: listHistoric );
      
      }
    );
  }

  _groupTile( context, Historic historic ) {
    return ListTileCustom(
      iconName: 'FAandroid',
      title: Text( historic.userName ),
      subtitle: Text( historic.action ),
      iconColor: _selectedColor(historic.action),
      onTap: () => Navigator.pushNamed( context, 'historic-detail', arguments: historic )
    );
  }

  _selectedColor( String action ) {
    switch ( action ) {
      case 'Eliminacion de Usuario': return Colors.red;
      case 'Actualizacion de Usuario': return Colors.green;
      case 'Creado Nuevo Usuario': return Colors.blue;
      default: return Colors.white;
    }
  }
}