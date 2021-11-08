class Product {

  Product({
    this.quantity,
    this.price,
    this.ubication,
    this.active,
    this.id,
    this.name,
    this.category,
    this.group,
    this.observations,
    this.img
  });

  int quantity;
  int price;
  String ubication;
  bool active;
  String id;
  String name;
  String category;
  String group;
  String observations;
  String img;

  factory Product.fromJson( Map <String, dynamic> json ) => Product (

    quantity     : json["quantity"],
    price        : json["price"],
    ubication    : json["ubication"],
    active       : json["active"],
    id           : json["uid"],
    name         : json["name"],
    category     : json["category"],
    group        : json["group"]        == null ? null : json["group"],
    observations : json["observations"] == null ? null : json["observations"],
    img          : json["img"]          == null ? null : json["img"],
  
  );

  Map <String, dynamic> toJson() => {

    "quantity"     : quantity,
    "price"        : price,
    "ubication"    : ubication,
    "active"       : active,
    "uid"          : id,
    "name"         : name,
    "category"     : category,
    "group"        : group        == null ? null : group,
    "observations" : observations == null ? null : observations,
    "img"          : img          == null ? null : img,
  
  };
}