class Category {

  String id;
  String name;
  String icon;
  bool   active;

  Category({
    this.id,
    this.name,
    this.icon,
    this.active
  });

  factory Category.fromJson( Map<String, dynamic> json ) => Category (
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