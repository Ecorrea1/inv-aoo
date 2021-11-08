import 'dart:convert';
import 'package:invapp/models/product/product_model.dart';

ProductResponse productFromJson( String str ) => ProductResponse.fromJson( json.decode( str ) );
String productToJson( ProductResponse data )  => json.encode( data.toJson() );

class ProductResponse {
  
  ProductResponse({
    this.ok,
    this.msg,
    this.data,
  });

  bool ok;
  String msg;
  List<Product> data;

  factory ProductResponse.fromJson( Map<String, dynamic> json ) => ProductResponse (
    ok    : json["ok"],
    msg   : json["msg"],
    data  : List<Product>.from( json["data"].map((x) => Product.fromJson( x )) ),
  );

  Map<String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": List<dynamic>.from( data.map( (x) => x.toJson() ) ),
  };
}

AddProductResponse addProductFromJson( String str ) => AddProductResponse.fromJson( json.decode( str ) );
String addProductToJson( AddProductResponse data )  => json.encode( data.toJson() );

class AddProductResponse {

  AddProductResponse({
    this.ok,
    this.msg,
    this.data,
  });
  
  bool ok;
  String msg;
  Product data;
  
  factory AddProductResponse.fromJson( Map<String, dynamic> json ) => AddProductResponse (

    ok    : json["ok"],
    msg   : json["msg"],
    data  : Product.fromJson( json["data"] ),
  
  );

  Map<String, dynamic> toJson() => {

    "ok"  : ok,
    "msg" : msg,
    "data": data.toJson(),
  
  };
  
}