class Historic {

  String id;
  String userName;
  String action;
  DateTime createdAt;


  Historic({
    this.id,
    this.userName,
    this.action,
    this.createdAt
  });

  factory Historic.fromJson( Map<String, dynamic> json ) => Historic (
    id        : json['uid'],
    userName  : json['userName'],
    action    : json['action'],
    createdAt : DateTime.parse(json['createdAt'])
  );
  
  Map <String, dynamic> toJson() => {
    'uid'       : id,
    'userName'  : userName,
    'action'    : action,
    'createdAt' : createdAt..toIso8601String()
  };
}