import 'package:flutter/material.dart';
import 'package:invapp/global/enviroment.global.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket _socket;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io(Enviroments.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true
    });
    this._socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
