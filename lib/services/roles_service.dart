import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/user/user.model.dart';
import 'package:rxdart/rxdart.dart';

class RoleService {
  final _rolesController = BehaviorSubject<List<Role>>();
  Stream<List<Role>> get roleStream => _rolesController.stream;
  Function(List<Role>) get changeRoles => _rolesController.sink.add;
  List<Role> get roles => _rolesController.value;
  List<Role> _allRoles = [];

  // Future<Role> getRoles() async {
  //   try {

  //     final response = await http.get( '${ Enviroments.apiUrl }/role/', headers: { 'Content-Type':'application/json' } );
  //       if (response != null) {
  //         final data = Role.fromJson( json.decode( response.body ) );
  //         if ( data.statusCode == 200 ) {
  //           this._allRoles = data.toJson() as List<Role>;
  //           this.changeRoles( this._allRoles );
  //         }
  //         return data;
  //       }
  //     return null;

  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }

  // Future <bool> addNewRole( { @required String name, String icon, String userName }  ) async {

  //   try{

  //     final resp = await http.post( '${ Enviroments.apiUrl }/role/new', body: jsonEncode( { 'name': name, 'icon': icon, 'user' : userName }), headers: { 'Content-Type':'application/json' });
  //       if( resp.statusCode == 201 ) {
  //         final data = addRoleResponseModelFromJson( resp.body );

  //           if ( data.ok ) {
  //             this._allRoles.add( RoleResponse.data );
  //             this.changeRoles( this._allRoles );
  //           }

  //         return true;
  //       }

  //     return false;

  //   } catch( error ){

  //     print( error );
  //     return false;

  //   }
  // }

  Future<bool> updateRole({@required String uid, final data}) async {
    try {
      final resp = await http.put(Uri.parse('${Enviroments.apiUrl}/role/$uid'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200) {
        print('Rol borrada');
        return true;
      }

      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteRole({@required String uid, String userName}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/role/$uid'),
          body: jsonEncode({'user': userName}),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body);
        print(respBody['msg']);
        return true;
      }

      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void applyFilter(String filter) {
    changeRoles(this
        ._allRoles
        .where((roles) => roles.name.contains(filter.toLowerCase()))
        .toList());
  }

  void cleanFilter() {
    this.changeRoles(this._allRoles);
  }

  dispose() {
    _rolesController?.close();
  }
}
