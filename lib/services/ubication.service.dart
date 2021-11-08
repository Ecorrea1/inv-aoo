import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/ubication/ubication.model.dart';
import 'package:invapp/models/ubication/ubication.response.model.dart';
import 'package:rxdart/rxdart.dart';

class UbicationService {
  final _ubicationController = BehaviorSubject<List<Ubication>>();
  Stream<List<Ubication>> get ubicationStream => _ubicationController.stream;
  Function(List<Ubication>) get changeUbications =>
      _ubicationController.sink.add;
  List<Ubication> get ubications => _ubicationController.value;
  List<Ubication> _allubications = [];

  Future<UbicationResponseModel> getUbications() async {
    try {
      final response = await http.get(Uri.parse('${Enviroments.apiUrl}/ubication/'),
          headers: {'Content-Type': 'application/json'});
      if (response != null) {
        final ubicationResponse =
            UbicationResponseModel.fromJson(json.decode(response.body));
        if (ubicationResponse.ok) {
          this._allubications = ubicationResponse.data;
          this.changeUbications(this._allubications);
        }
        return ubicationResponse;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> addNewUbication(
      {@required String name, String icon, String userName}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/ubication/new'),
          body: jsonEncode({'name': name, 'icon': icon, 'user': userName}),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 201) {
        final ubicationResponse = addUbicationResponseModelFromJson(resp.body);

        if (ubicationResponse.ok) {
          this._allubications.add(ubicationResponse.data);
          this.changeUbications(this._allubications);
        }

        return true;
      }

      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateUbication({@required String uid, final data}) async {
    try {
      final resp = await http.put(Uri.parse('${Enviroments.apiUrl}/ubication/$uid'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        final ubicationResponse = addUbicationResponseModelFromJson(resp.body);

        if (ubicationResponse.ok) {
          print(ubicationResponse.msg);
          print(ubicationResponse.data);
        }

        return true;
      }
      final respBody = jsonDecode(resp.body);
      print('Muestra :${respBody['msg']}');
      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteUbication({@required String uid, String userName}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/ubication/$uid'),
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
    changeUbications(this
        ._allubications
        .where((ubications) => ubications.name.contains(filter.toLowerCase()))
        .toList());
  }

  void cleanFilter() {
    this.changeUbications(this._allubications);
  }

  dispose() {
    _ubicationController?.close();
  }
}
