import 'dart:convert';
import 'package:invapp/models/product_group/product-group.model.dart';

ProductGroupResponseModel productGroupResponseModelFromJson( String str ) => ProductGroupResponseModel.fromJson( json.decode( str ) );
String productGroupResponseModelToJson( ProductGroupResponseModel data )  => json.encode( data.toJson() );

class ProductGroupResponseModel {
  ProductGroupResponseModel({
    this.msg,
    this.data,
    this.ok,
  });
  
  String msg;
  List<ProductGroup> data;
  bool ok;
  
  factory ProductGroupResponseModel.fromJson( Map <String, dynamic> json ) => ProductGroupResponseModel(
    msg   : json['msg'],
    data  : List<ProductGroup>.from( json["data"].map( (x) => ProductGroup.fromJson(x) ) ),
    ok    : json['ok'],
  );

  Map <String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": List<dynamic>.from( data.map( (x) => x.toJson() ) ),
  };
}

AddProductGroupResponseModel addproductGroupResponseModelFromJson( String str ) => AddProductGroupResponseModel.fromJson( json.decode( str ) );
String addproductGroupResponseModelToJson( AddProductGroupResponseModel data )  => json.encode( data.toJson() );

class AddProductGroupResponseModel {
  AddProductGroupResponseModel({
    this.msg,
    this.data,
    this.ok,
  });
  
  String msg;
  ProductGroup data;
  bool ok;
  
  factory AddProductGroupResponseModel.fromJson( Map <String, dynamic> json ) => AddProductGroupResponseModel(
    msg   : json['msg'],
    data  : ProductGroup.fromJson( json["data"] ),
    ok    : json['ok'],
  );

  Map <String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": data.toJson(),
  };
}