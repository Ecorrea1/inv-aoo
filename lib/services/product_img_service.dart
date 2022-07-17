import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invapp/global/enviroment.global.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/models/product/product_response_model.dart';
import 'package:rxdart/rxdart.dart';

class ImageService {
  final _productController = BehaviorSubject<List<Product>>();
  Stream<List<Product>> get productStream => _productController.stream;
  Function(List<Product>) get changeProduct => _productController.sink.add;
  List<Product> get products => _productController.value;
  List<Product> _allProduct = [];

  Future<ProductResponse> getProductImg(
      {String name,
      String group,
      String category,
      String ubication,
      bool active}) async {
    try {
      String query = '';
      query += name != null ? 'name=$name&' : '';
      query += group != null ? 'group=$group&' : '';
      query += category != null ? 'category=$category&' : '';
      query += ubication != null ? 'ubication=$ubication&' : '';
      query += active != null ? 'active=$active&' : '';

      if (group == 'Todos') query = '';
      final resp = await http.get(
          Uri.parse('${Enviroments.apiUrl}/product/products?$query'),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return null;
      final productResponse = ProductResponse.fromJson(json.decode(resp.body));
      if (productResponse.ok == false) return productResponse;
      this._allProduct = productResponse.data;
      changeProduct(_allProduct);
      return productResponse;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> addNewProductImage({final data}) async {
    try {
      final resp = await http.post(
          Uri.parse('${Enviroments.apiUrl}/cloudinary/new'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return false;
      final productResponse = addProductFromJson(resp.body);
      if (productResponse.ok == false) {
        print(productResponse.msg);
        return false;
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateProductImg({@required String uid, final data}) async {
    try {
      final resp = await http.put(
          Uri.parse('${Enviroments.apiUrl}/product/$uid'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return false;
      final productResponse = addProductFromJson(resp.body);
      if (productResponse.ok == false) return false;
      this._allProduct.add(productResponse.data);
      changeProduct(_allProduct);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteProductImg({@required String uid, String user}) async {
    try {
      final resp = await http.post(
          Uri.parse('${Enviroments.apiUrl}/product/$uid'),
          body: jsonEncode({'user': user}),
          headers: {'Content-Type': 'application/json'});
      return resp.statusCode == 200 ? true : false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void cleanFilter() {
    this.changeProduct(this._allProduct);
  }

  dispose() {
    _productController?.close();
  }
}
