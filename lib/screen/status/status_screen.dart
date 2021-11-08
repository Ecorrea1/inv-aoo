import 'package:flutter/material.dart';
import 'package:invapp/services/socket_service.dart';
import 'package:provider/provider.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build( BuildContext context ) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Hola Mundo'),),
      body: Center(child: Text('Status : ${ socketService.serverStatus }')),
      floatingActionButton: FloatingActionButton(
       child: Icon( Icons.message ),
       onPressed: (){
        socketService.emit( 'emitir-mensaje', { 
          'nombre': 'Flutter', 
          'mensaje':'Hola desde Flutter' 
        });
       }
      ),
    );
  }
}