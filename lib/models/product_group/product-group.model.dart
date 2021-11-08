class ProductGroup {

  String id;
  String name;
  String icon;

  // static const GROUP_SALESMEN = 'Vendedores'; 

  ProductGroup({
    this.id,
    this.name,
    this.icon,
  });

  factory ProductGroup.fromJson( Map<String, dynamic> json ) => ProductGroup (
    id  : json['uid'],
    name: json['name'],
    icon: json['icon'],
  );
  
  Map <String, dynamic> toJson() => {
    'uid' : id,
    'name': name,
    'icon': icon,
  };
}