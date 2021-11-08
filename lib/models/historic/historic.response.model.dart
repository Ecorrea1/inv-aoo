import 'dart:convert';
import 'package:invapp/models/historic/historic.model.dart';

HistoricResponseModel historicResponseModelFromJson( String str ) => HistoricResponseModel.fromJson( json.decode( str ) );
String historicResponseModelToJson( HistoricResponseModel data )  => json.encode( data.toJson() );

class HistoricResponseModel {
  HistoricResponseModel({
    this.ok,
    this.msg,
    this.data,
  });
  
  bool ok;
  String msg;
  List<Historic> data;
  
  factory HistoricResponseModel.fromJson( Map <String, dynamic> json ) => HistoricResponseModel(
    ok    : json['ok'],
    msg   : json['msg'],
    data  : List<Historic>.from( json["data"].map( (x) => Historic.fromJson(x) ) ),
  );

  Map <String, dynamic> toJson() => {
    "ok"  : ok,
    "msg" : msg,
    "data": List<dynamic>.from( data.map( (x) => x.toJson() ) ),
  };
}