class ProductGroup {

  String id;
  String name;
  String page;
  String icon;

  static const GROUP_SALESMEN = 'Vendedores'; 

  ProductGroup({
    this.id,
    this.name,
    this.page,
    this.icon,
  });

  factory ProductGroup.fromJson( Map<String, dynamic> json ) => ProductGroup (
    id  : json['_id'],
    name: json['name'],
    page: json['page'],
    icon: json['icon'],
  );
  
  Map<String, dynamic> toJson() => {
    '_id' : id,
    'name': name,
    'page': name,
    'icon': icon,
  };
}