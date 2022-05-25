import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/login/login_response.model.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:rxdart/rxdart.dart';

class UserService {
  final _userController = BehaviorSubject<List<User>>();
  Stream<List<User>> get userStream => _userController.stream;
  Function(List<User>) get changeUsers => _userController.sink.add;
  List<User> get user => _userController.value;
  List<User> _allUsers = [];

  Future<UserResponse> getUsers() async {
    try {
      final response = await http.get(Uri.parse('${Enviroments.apiUrl}/login/users'), headers: {'Content-Type': 'application/json'});
      if (response.statusCode != 200) return null;
      final userResp = UserResponse.fromJson(json.decode(response.body));
      if (userResp.ok == false) return userResp;
      this._allUsers = userResp.data;
      this.changeUsers(this._allUsers);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future <bool>updateUser({@required String uid, final data}) async {
    try {
      final resp = await http.put(Uri.parse('${Enviroments.apiUrl}/login/$uid'), body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
      return resp.statusCode == 200 ? true : false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteUser({@required String uid, String user}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/login/$uid'), body: jsonEncode({'user': user}), headers: {'Content-Type': 'application/json'});
      return resp.statusCode == 200 ? true : false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void applyFilter(String filter) {
    changeUsers(this._allUsers.where((usr) => usr.name.contains(filter.toLowerCase())).toList());
  }

  void cleanFilter() {
    this.changeUsers(this._allUsers);
  }

  dispose() {
    _userController?.close();
  }
}
