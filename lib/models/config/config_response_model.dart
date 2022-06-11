// To parse this JSON data, do
//
//     final configResponse = configResponseFromJson(jsonString);
import 'package:invapp/models/config/config_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ConfigResponse configResponseFromJson(String str) => ConfigResponse.fromJson(json.decode(str));
String configResponseToJson(ConfigResponse data) => json.encode(data.toJson());

class ConfigResponse {
  ConfigResponse({
      @required this.ok,
      @required this.msg,
      @required this.data,
  });
  final bool ok;
  final String msg;
  final List<Config> data;
  factory ConfigResponse.fromJson(Map<String, dynamic> json) => ConfigResponse(
      ok: json["ok"] == null ? null : json["ok"],
      msg: json["msg"] == null ? null : json["msg"],
      data: json["data"] == null ? null : List<Config>.from(json["data"].map((x) => Config.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
      "ok": ok == null ? null : ok,
      "msg": msg == null ? null : msg,
      "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}