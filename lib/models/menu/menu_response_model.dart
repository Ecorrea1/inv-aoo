import 'dart:convert';
import 'package:invapp/models/product_group/product-group.model.dart';

ProductGroupResponseModel contactGroupResponseModelFromJson( String str ) => ProductGroupResponseModel.fromJson( json.decode( str ) );
String contactGroupResponseModelToJson( ProductGroupResponseModel data )  => json.encode( data.toJson() );

class ProductGroupResponseModel {
  ProductGroupResponseModel({
    this.msg,
    this.data,
    this.ok,
  });
  
  String msg;
  List<ProductGroup> data;
  bool ok;
  
  factory ProductGroupResponseModel.fromJson( Map<String, dynamic> json ) => ProductGroupResponseModel (
    msg : json['msg'],
    data: List<ProductGroup>.from( json["data"].map( (x) => ProductGroup.fromJson(x) ) ),
    ok  : json['ok'],
  );

  Map<String, dynamic> toJson() => {
      "ok"  : ok,
      "msg" : msg,
      "data": List<dynamic>.from( data.map( (x) => x.toJson() ) ),
  };
}