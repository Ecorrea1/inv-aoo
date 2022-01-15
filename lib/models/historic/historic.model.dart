class Historic {

  String id;
  String userName;
  String action;
  String description;
  DateTime createdAt;


  Historic({
    this.id,
    this.userName,
    this.action,
    this.description,
    this.createdAt
  });

  factory Historic.fromJson( Map<String, dynamic> json ) => Historic (
    id        : json['uid'],
    userName  : json['userName'],
    action    : json['action'],
    description    : json['description'],
    createdAt : DateTime.parse(json['createdAt'])
  );
  
  Map <String, dynamic> toJson() => {
    'uid'       : id,
    'userName'  : userName,
    'action'    : action,
    'description'    : description,
    'createdAt' : createdAt..toIso8601String()
  };
}