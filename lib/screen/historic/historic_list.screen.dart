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
      iconName: _selectedOption(historic.action, true),
      title: Text( historic.userName ),
      subtitle: Text( historic.action ),
      iconColor: _selectedOption(historic.action, false),
      onTap: () => Navigator.pushNamed( context, 'historic-detail', arguments: historic )
    );
  }

  _selectedOption( String action, bool options ) {
    if (action.contains('Actualizacion') || action.contains('Actualizado')) return options ? 'FAuserEdit': Colors.green;
    if (action.contains('Eliminacion')) return options ? 'FAuserTimes' : Colors.red;
    if (action.contains('Creado')) return options ? 'FAuserPlus' : Colors.yellow;
    return options ? 'FAuser' : Colors.blue;
  }
}