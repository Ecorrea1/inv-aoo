import 'dart:convert';
import 'package:invapp/models/user/user.model.dart';

LoginResponse loginResponseFromJson( String str ) => LoginResponse.fromJson( json.decode( str ) );
String loginResponseToJson( LoginResponse data )  => json.encode( data.toJson() );

class LoginResponse {
  LoginResponse({
    this.ok,
    this.msg,
    this.data,
    this.token,
  });

  bool ok;
  String msg;
  User data;
  String token;
  
  factory LoginResponse.fromJson( Map<String, dynamic> json ) => LoginResponse (
    ok    : json["ok"],
    msg   : json["msg"],
    data  : User.fromJson( json["data"] ),
    token : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "ok"    : ok,
    "msg"   : msg,
    "data"  : data.toJson(),
    "token" : token,
  };
}

UserResponse userResponseFromJson( String str ) => UserResponse.fromJson( json.decode( str ) );
String userResponseToJson( UserResponse data )  => json.encode( data.toJson() );

class UserResponse {
  UserResponse({
    this.ok,
    this.msg,
    this.data,
  });

  bool ok;
  String msg;
  List<User> data;
  
  factory UserResponse.fromJson( Map<String, dynamic> json ) => UserResponse (
    ok    : json["ok"],
    msg   : json["msg"],
    data  : List<User>.from( json["data"].map((x) => User.fromJson( x )) )
  );

  Map<String, dynamic> toJson() => {
    "ok"    : ok,
    "msg"   : msg,
    "data"  : List<dynamic>.from( data.map( (x) => x.toJson() ) )
  };
}
