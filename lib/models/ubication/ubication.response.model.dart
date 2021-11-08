import 'dart:convert';
import 'package:invapp/models/ubication/ubication.model.dart';

UbicationResponseModel ubicationResponseModelFromJson( String str ) => UbicationResponseModel.fromJson( json.decode( str ) );
String ubicationResponseModelToJson( UbicationResponseModel data )  => json.encode( data.toJson() );

class UbicationResponseModel {
  UbicationResponseModel({
    this.msg,
    this.data,
    this.ok,
  });
  
  String msg;
  List<Ubication> data;
  bool ok;
  
  factory UbicationResponseModel.fromJson( Map <String, dynamic> json ) => UbicationResponseModel(
    msg   : json['msg'],
    ok    : json['ok'],
    data  : List<Ubication>.from( json["data"].map( (x) => Ubication.fromJson(x) ) ),
  );

  Map <String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": List<dynamic>.from( data.map( (x) => x.toJson() ) ),
  };
}

AddUbicationResponseModel addUbicationResponseModelFromJson( String str ) => AddUbicationResponseModel.fromJson( json.decode( str ) );
String addUbicationResponseModelToJson( AddUbicationResponseModel data )  => json.encode( data.toJson() );

class AddUbicationResponseModel {
  AddUbicationResponseModel({
    this.ok,
    this.msg,
    this.data,
  });
  
  String msg;
  Ubication data;
  bool ok;
  
  factory AddUbicationResponseModel.fromJson( Map <String, dynamic> json ) => AddUbicationResponseModel(
    ok    : json['ok'],
    msg   : json['msg'],
    data  : Ubication.fromJson( json["data"] ),
  );

  Map <String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": data.toJson(),
  };
}