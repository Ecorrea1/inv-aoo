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
  Privileges privileges;

  Role({
    this.name,
    this.menuOptions,
    this.groupOptions,
    this.privileges
  });

  factory Role.fromJson( Map<String, dynamic> json ) => Role(
    name        : json["name"],
    menuOptions : List<MenuOption>.from( json["menuOptions"].map( ( x ) => MenuOption.fromJson( x ) ) ),
    groupOptions: List<GroupOption>.from( json["groupOptions"].map( ( x ) => GroupOption.fromJson( x ) ) ),
    privileges  : Privileges.fromJson(json["privileges"])
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

class Privileges {
    Privileges({
        this.createProducts,
        this.createUsers,
        this.createGroup,
        this.createCategory,
        this.createUbications,
        this.modifyProducts,
        this.modifyUsers,
        this.modifyGroup,
        this.modifyCategory,
        this.modifyUbications,
        this.deleteProducts,
        this.deleteUsers,
        this.deleteGroup,
        this.deleteCategory,
        this.deleteUbications,
    });

    bool createProducts;
    bool createUsers;
    bool createGroup;
    bool createCategory;
    bool createUbications;
    bool modifyProducts;
    bool modifyUsers;
    bool modifyGroup;
    bool modifyCategory;
    bool modifyUbications;
    bool deleteProducts;
    bool deleteUsers;
    bool deleteGroup;
    bool deleteCategory;
    bool deleteUbications;

    factory Privileges.fromJson(Map<String, dynamic> json) => Privileges(
        createProducts: json["create-products"],
        createUsers: json["create-users"],
        createGroup: json["create-group"],
        createCategory: json["create-group"],
        createUbications: json["create-ubication"],
        modifyProducts: json["modify-products"],
        modifyUsers: json["modify-users"],
        modifyGroup: json["modify-group"],
        modifyCategory: json["modify-category"],
        modifyUbications: json["modify-ubication"],
        deleteProducts: json["delete-products"],
        deleteUsers: json["delete-users"],
        deleteGroup: json["delete-group"],
        deleteCategory: json["delete-category"],
        deleteUbications: json["delete-ubication"],
    );

    Map<String, dynamic> toJson() => {
        "create-products": createProducts,
        "create-users": createUsers,
        "create-group": createGroup,
        "create-category": createCategory,
        "create-ubication": createUbications,
        "modify-products": modifyProducts,
        "modify-users": modifyUsers,
        "modify-group": modifyGroup,
        "modify-category": modifyCategory,
        "modify-ubication": modifyUbications,
        "delete-products": deleteProducts,
        "delete-users": deleteUsers,
        "delete-gruop": deleteGroup,
        "delete-category": deleteCategory,
        "delete-ubication": deleteUbications,
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
