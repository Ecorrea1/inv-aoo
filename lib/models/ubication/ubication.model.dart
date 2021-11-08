class Ubication {

  String id;
  String name;
  String icon;
  bool   active;

  Ubication({
    this.id,
    this.name,
    this.icon,
    this.active
  });

  factory Ubication.fromJson( Map<String, dynamic> json ) => Ubication (
    id    : json['uid'],
    name  : json['name'],
    icon  : json['icon'],
    active: json['active']
  );
  
  Map <String, dynamic> toJson() => {
    'uid'   : id,
    'name'  : name,
    'icon'  : icon,
    'active': active
  };
}