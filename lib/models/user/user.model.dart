import 'dart:convert';

User userFromJson( String str ) => User.fromJson( json.decode( str ) );
String userToJson( User data )  => json.encode( data.toJson() );

class User {
  User({
    this.online,
    this.pushNotificationsTopics,
    this.role,
    this.active,
    this.name,
    this.email,
    this.pass,
    this.devices,
    this.createdAt,
    this.uid,
  });

  bool online;
  List<dynamic> pushNotificationsTopics;
  Role role;
  bool active;
  String name;
  String email;
  String pass;
  List<dynamic> devices;
  DateTime createdAt;
  String uid;

  factory User.fromJson( Map<String, dynamic> json ) => User (
    online    : json["online"],
    pushNotificationsTopics : List<dynamic>.from( json["pushNotificationsTopics"].map(( x ) => x ) ),
    role      : Role.fromJson( json["role"] ),
    active    : json["active"],
    name      : json["name"],
    email     : json["email"],
    pass      : json["pass"],
    devices   : List<dynamic>.from( json["devices"].map( ( x ) => x ) ),
    createdAt : DateTime.parse( json["createdAt"] ),
    uid       : json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "online"   : online,
    "pushNotificationsTopics": List<dynamic>.from( pushNotificationsTopics.map( ( x ) => x ) ) ,
    'role'     : role.toJson(),
    "active"   : active,
    "name"     : name,
    "email"    : email,
    "pass"     : pass,
    "devices"  : List<dynamic>.from( devices.map(( x ) => x) ),
    "createdAt": createdAt.toIso8601String(),
    "uid"      : uid,
  };
}

class Role {

  String name;
  List<MenuOption>  menuOptions;
  List<GroupOption> groupOptions;

  Role({
    this.name,
    this.menuOptions,
    this.groupOptions
  });

  factory Role.fromJson( Map<String, dynamic> json ) => Role(
    name        : json["name"],
    menuOptions : List<MenuOption>.from( json["menuOptions"].map( ( x ) => MenuOption.fromJson( x ) ) ),
    groupOptions: List<GroupOption>.from( json["groupOptions"].map( ( x ) => GroupOption.fromJson( x ) ) ),
  );

  Map<String, dynamic> toJson() => {
    "name"        : name,
    "menuOptions" : List<dynamic>.from( menuOptions.map( ( x ) => x.toJson() ) ),
    "groupOptions": List<dynamic>.from( groupOptions.map( ( x ) => x.toJson() ) ),
  };
}


class MenuOption {

  String name;
  String page;
  String icon;

  MenuOption({
    this.name,
    this.page,
    this.icon
  });

  factory MenuOption.fromJson( Map <String, dynamic> json ) => MenuOption(
    name: json["name"],
    page: json["page"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "page": page,
    "icon": icon,
  };
}

class GroupOption {

  String name;
  String icon;

  GroupOption({
    this.name,
    this.icon
  });

  factory GroupOption.fromJson( Map <String, dynamic> json ) => GroupOption(
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
  };
}

class Device {

  Device({
    this.id,
    this.deviceId,
    this.platform,
  });

  String id;
  String deviceId;
  String platform;

  factory Device.fromJson( Map <String, dynamic> json ) => Device(
    id      : json["_id"],
    deviceId: json["deviceId"],
    platform: json["platform"],
  );
  
  Map <String, dynamic> toJson() => {
    "_id"     : id,
    "deviceId": deviceId,
    "platform": platform,
  };
}
