import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/product_group/product-group.model.dart';
import 'package:invapp/models/product_group/product_group_response.dart';
import 'package:rxdart/rxdart.dart';

class ProductGroupService {
  final _productGroupController = BehaviorSubject<List<ProductGroup>>();
  Stream<List<ProductGroup>> get productGroupStream =>
      _productGroupController.stream;
  Function(List<ProductGroup>) get changeGroup =>
      _productGroupController.sink.add;
  List<ProductGroup> get productsGroup => _productGroupController.value;
  List<ProductGroup> _allProductGroups = [];

  //Future<ProductGroupResponseModel> getContactGroup({@required String token}) async {
  Future<ProductGroupResponseModel> getContactGroup() async {
    try {
      final response = await http.get(Uri.parse('${Enviroments.apiUrl}/group/menu'), headers: {'Content-Type': 'application/json'});
      //final response = await http.get(url, headers: {'token': token});
      if (response == null) return null;
      final groupResponse = ProductGroupResponseModel.fromJson(json.decode(response.body));
      if (groupResponse.ok == false) return groupResponse;
      this._allProductGroups = groupResponse.data;
      this.changeGroup(this._allProductGroups);
      return groupResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> addNewProductGroup({@required String name, String icon, String userName}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/group/new'), body: jsonEncode({'name': name, 'icon': icon, 'user': userName}), headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 201) return false;
      final groupResponse = addproductGroupResponseModelFromJson(resp.body);
      if (groupResponse.ok == false) return false;
      this._allProductGroups.add(groupResponse.data);
      this.changeGroup(this._allProductGroups);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateProductGroup({String uid, final data}) async {
    try {
      final resp = await http.put(Uri.parse('${Enviroments.apiUrl}/group/$uid'), body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return false;
      final groupResponse = addproductGroupResponseModelFromJson(resp.body);
      if (groupResponse.ok == false) return false;
      this._allProductGroups.add(groupResponse.data);
      this.changeGroup(this._allProductGroups);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteProductGroup({@required String uid, String email}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/group/$uid'), body: jsonEncode({'user': email}), headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return false;
      final groupResponse = addproductGroupResponseModelFromJson(resp.body);
      if (groupResponse.ok == false) return false;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void applyFilter(String filter) {
    changeGroup(this._allProductGroups.where((productsGroup) => productsGroup.name.contains(filter.toLowerCase())).toList());
  }

  void cleanFilter() {
    this.changeGroup(this._allProductGroups);
  }

  dispose() {
    _productGroupController?.close();
  }
}
