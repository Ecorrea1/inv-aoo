formatterPrice(int price) {
  return price == null ? '\$${0}' :'\$${price.toString()}';
}

formatterRut(String rut) {
  return rut == null ? '': rut.replaceAllMapped(new RegExp(r'(\d{1,3})(\d{3})(\d{3})(\w{1})'), (Match m) => '${m[1]}.${m[2]}-${m[3]}-${m[4]}');
}

formatterName(String name) {
  return name == null ? '' :  name.replaceAllMapped(new RegExp(r'(^\w{1})(\w.*)'), (Match m) => '${m[1].toUpperCase()}${m[2].toLowerCase()}');
}