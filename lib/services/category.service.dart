import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:invapp/global/enviroment.global.dart';
import 'package:invapp/models/category/category.model.dart';
import 'package:invapp/models/category/category.response.model.dart';
import 'package:rxdart/rxdart.dart';

class CategoryService {
  final _categoryController = BehaviorSubject<List<Category>>();
  Stream<List<Category>> get categoryStream => _categoryController.stream;
  Function(List<Category>) get changeCategories => _categoryController.sink.add;
  List<Category> get categories => _categoryController.value;
  List<Category> _allCategories = [];

  Future<CategoryResponseModel> getCategories() async {
    try {
      final response = await http.get(Uri.parse('${Enviroments.apiUrl}/category/'), headers: {'Content-Type': 'application/json'});
      if (response == null) return null;
        final categoryResponse = CategoryResponseModel.fromJson(json.decode(response.body));
        if (categoryResponse.ok == false) return categoryResponse;
        this._allCategories = categoryResponse.data;
        this.changeCategories(this._allCategories);
        return categoryResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> addNewCategory({@required String name, String icon, String userName}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/category/new'), body: jsonEncode({'name': name, 'icon': icon, 'user': userName}), headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 201)  return false;
      final categoryResponse = addCategoryResponseModelFromJson(resp.body);
      if (categoryResponse.ok == false) return false;
      this._allCategories.add(categoryResponse.data);
      this.changeCategories(this._allCategories);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> updateCategory({@required String uid, final data}) async {
    try {
      final resp = await http.put(Uri.parse('${Enviroments.apiUrl}/category/$uid'), body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
      if (resp.statusCode != 200) return false;
      final categoryResponse = addCategoryResponseModelFromJson(resp.body);
      if (categoryResponse.ok == false) return false;
      this._allCategories.add(categoryResponse.data);
      this.changeCategories(this._allCategories);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteCategory(
      {@required String uid, @required String user}) async {
    try {
      final resp = await http.post(Uri.parse('${Enviroments.apiUrl}/category/$uid'), body: jsonEncode({"user": user}), headers: {'Content-Type': 'application/json'});
      return resp.statusCode == 200 ? true : false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void applyFilter(String filter) {
    changeCategories(this._allCategories.where((categories) => categories.name.toUpperCase().contains(filter.toUpperCase())).toList());
  }

  void cleanFilter() {
    this.changeCategories(this._allCategories);
  }

  dispose() {
    _categoryController?.close();
  }
}
