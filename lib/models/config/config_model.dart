import 'dart:convert';

Config configFromJson( String str ) => Config.fromJson( json.decode( str ) );
String configToJson( Config data )  => json.encode( data.toJson() );

class Config {

  String androidVersion;
  String iosVersion;
  String playStoreUrl;
  String appStoreUrl;
  int    autoLoginDays;
  bool   inMaintenance;

  Config({

    this.androidVersion,
    this.iosVersion,
    this.playStoreUrl,
    this.appStoreUrl,
    this.autoLoginDays,
    this.inMaintenance
  
  });

  factory Config.fromJson( Map<String, dynamic> json ) => Config (

    androidVersion : json["androidVersion"],
    iosVersion     : json["iosVersion"],
    playStoreUrl   : json["playStoreUrl"],
    appStoreUrl    : json["appStoreUrl"],
    autoLoginDays  : json["autoLoginDays"],
    inMaintenance  : json["inMaintenance"]
  
  );

  Map<String, dynamic> toJson() => {

    "androidVersion": androidVersion,
    "iosVersion"    : iosVersion,
    "playStoreUrl"  : playStoreUrl,
    "appStoreUrl"   : appStoreUrl,
    "autoLoginDays" : autoLoginDays,
    "inMaintenance" : inMaintenance
  
  };

   int versionActualStore(String platform) => (platform == 'android') ?  
   int.parse(this.androidVersion.trim().replaceAll(".", "")) :  
   int.parse(this.iosVersion.trim().replaceAll(".", ""));
  
}
