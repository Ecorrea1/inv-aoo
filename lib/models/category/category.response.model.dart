import 'dart:convert';
import 'package:invapp/models/category/category.model.dart';

CategoryResponseModel categoryResponseModelFromJson( String str ) => CategoryResponseModel.fromJson( json.decode( str ) );
String categoryResponseModelToJson( CategoryResponseModel data )  => json.encode( data.toJson() );

class CategoryResponseModel {
  CategoryResponseModel({
    this.ok,
    this.msg,
    this.data,
  });
  
  bool ok;
  String msg;
  List<Category> data;
  
  factory CategoryResponseModel.fromJson( Map <String, dynamic> json ) => CategoryResponseModel(
    ok    : json['ok'],
    msg   : json['msg'],
    data  : List<Category>.from( json["data"].map( (x) => Category.fromJson(x) ) ),
  );

  Map <String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": List<dynamic>.from( data.map( (x) => x.toJson() ) ),
  };
}

AddCategoryResponseModel addCategoryResponseModelFromJson( String str ) => AddCategoryResponseModel.fromJson( json.decode( str ) );
String addCategoryResponseModelToJson( AddCategoryResponseModel data )  => json.encode( data.toJson() );

class AddCategoryResponseModel {
  AddCategoryResponseModel({
    this.ok,
    this.msg,
    this.data,
  });
  
  bool ok;
  String msg;
  Category data;
  
  factory AddCategoryResponseModel.fromJson( Map <String, dynamic> json ) => AddCategoryResponseModel(
    ok    : json['ok'],
    msg   : json['msg'],
    data  : Category.fromJson( json["data"] ),
  );

  Map <String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": data.toJson(),
  };
}