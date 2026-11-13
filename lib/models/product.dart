class Product {
  int id;
  String name;
  double price;
  String category;
  String image;
  String description;
  // TODO Actividad 1: atributos para el carrito
  bool selected = false;
  int quantity = 1;

  Product(this.id, this.name, this.price, this.category, this.image,
      this.description);

  factory Product.fromMap(Map<String, dynamic> map) => Product(
      map['id'], map['name'], map['price'],
      map['category'], map['image'], map['description']);

}