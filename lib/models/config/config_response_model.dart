import 'dart:convert';
import 'package:invapp/models/config/config_model.dart';
import 'package:invapp/models/product/product_model.dart';

ConfigResponse productFromJson( String str ) => ConfigResponse.fromJson( json.decode( str ) );
String productToJson( ConfigResponse data )  => json.encode( data.toJson() );

class ConfigResponse {
  
  ConfigResponse({
    this.ok,
    this.msg,
    this.data,
  });

  bool ok;
  String msg;
  Config data;

  factory ConfigResponse.fromJson( Map<String, dynamic> json ) => ConfigResponse (
    ok    : json["ok"],
    msg   : json["msg"],
    data  : Config.fromJson( json["data"] ),
  );

  Map<String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": data.toJson(),
  };
}