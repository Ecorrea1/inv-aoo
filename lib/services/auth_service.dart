import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/login/login_response.model.dart';
import 'package:invapp/models/user/user.model.dart';
//import 'package:socket_io_client/socket_io_client.dart' as IO;

class AuthService with ChangeNotifier {
  User user;
  bool _authentify = false;
  final _storage = new FlutterSecureStorage();
  bool get authentify => this._authentify;

  set authentify(bool valor) {
    this._authentify = valor;
    notifyListeners();
  }

  //Getters del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  //Getters del token de forma estatica
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    //final data = { 'email': email,  'pass' : password };
    this.authentify = true;
    final resp = await http.post(  Uri.parse('${Enviroments.apiUrl}/login'),
        body: jsonEncode({'email': email, 'pass': password}),
        headers: {'Content-Type': 'application/json'});
    print(resp.body);
    this.authentify = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.data;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(
      {String name, String email, String pass, String user = 'App'}) async {
    this.authentify = true;
    final resp = await http.post( Uri.parse('${Enviroments.apiUrl}/login/new'),
        body: jsonEncode(
            {'name': name, 'email': email, 'pass': pass, 'user': user}),
        headers: {'Content-Type': 'application/json'});
    this.authentify = false;
    if (resp.statusCode == 201) {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http.get( Uri.parse('${Enviroments.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.data;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
