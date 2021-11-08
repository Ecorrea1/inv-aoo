
class Votos {
  String id;
  String name;
  int price;
  int quantity;

  Votos({
    this.id,
    this.name,
    this.price,
    this.quantity
  });

  factory Votos.fromMap( Map<String, dynamic> obj ) => Votos(
    id: obj.containsKey('id') ?  obj['id'] : 'no-id',
    name: obj.containsKey('name') ?  obj['name'] : 'no-name', 
    price: obj.containsKey('price') ? obj['price'] : 'no-price',
    quantity: obj.containsKey('quantity')? obj['quantity'] : 'no-quantity'
  );
}