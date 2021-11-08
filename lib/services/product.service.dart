import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invapp/global/enviroment.global.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/models/product/product_model.dart';
import 'package:invapp/models/product/product_response_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductService {
  final _productController = BehaviorSubject<List<Product>>();
  Stream<List<Product>> get productStream => _productController.stream;
  Function(List<Product>) get changeProduct => _productController.sink.add;
  List<Product> get products => _productController.value;
  List<Product> _allProduct = [];

  Future<ProductResponse> getProductList({ String name, String group, String category, String ubication, bool active }) async {
    try {
      String query = '';
      query += name != null ? 'name=$name&' : '';
      query += group != null ? 'group=$group&' : '';
      query += category != null ? 'category=$category&' : '';
      query += ubication != null ? 'ubication=$ubication&' : '';
      query += active != null ? 'active=$active&' : '';

      if(group == 'Todos') query = '';

      final resp = await http.get(
          Uri.parse('${Enviroments.apiUrl}/product/products?$query'),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        final productResponse =
            ProductResponse.fromJson(json.decode(resp.body));
        if (productResponse.ok) {
          this._allProduct = productResponse.data;
          changeProduct(_allProduct);
        }
        return productResponse;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> addNewProduct({ final data }) async {
    // name, img, category, quantity, price, ubication, observations, user
    try {
      final resp = await http.post(
          Uri.parse('${Enviroments.apiUrl}/product/new'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 201) {
        final productResponse = addProductFromJson(resp.body);

        if (productResponse.ok) {
          print(productResponse.msg);
          this._allProduct.add(productResponse.data);
          changeProduct(_allProduct);
        }
        print(productResponse.msg);
        return true;
      }
      print(resp.body);
      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateProduct({ @required String uid, final data }) async {
    try {
      final resp = await http.put(
          Uri.parse('${Enviroments.apiUrl}/product/$uid'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        final productResponse = addProductFromJson(resp.body);

        if (productResponse.ok) {
          print(productResponse.msg);
          print(productResponse.data.id);
        }
        return true;
      }
      print(resp.body);
      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteProduct({ @required String uid, String user }) async {
    try {
      final resp = await http.post(
          Uri.parse('${Enviroments.apiUrl}/product/$uid'),
          body: jsonEncode({'user': user}),
          headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200) {
        final respBody = jsonDecode(resp.body);
        print(respBody['msg']);
        print(respBody['data']);
        return true;
      }

      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void applyFilter( String filter ) {
    changeProduct(this
        ._allProduct
        .where((products) =>
            products.category.toUpperCase().contains(filter.toUpperCase()) ||
            products.price.toString().contains(filter) ||
            products.quantity.toString().contains(filter) ||
            // products.ubication.toUpperCase().contains(filter.toUpperCase()) ||
            // products.observations.toUpperCase().contains(filter.toUpperCase()) ||
            products.name.toUpperCase().contains(filter.toUpperCase()))
        .toList());
  }

  void cleanFilter() {
    this.changeProduct(this._allProduct);
  }

  dispose() {
    _productController?.close();
  }
}
