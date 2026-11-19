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

// TODO Actividad 4: devuelve la ruta de la imagen que corresponde a la categoría del producto
  String get imagenCategoria {
    switch (category) {
      case 'fruits':
        return 'assets/image/fruit.png';
      case 'vegetables':
        return 'assets/image/vegetables.png';
      case 'bakery':
        return 'assets/image/bakery.png';
      case 'fish':
        return 'assets/image/fish.png';
      case 'meat':
        return 'assets/image/meat.png';
      default:
      // si la categoría no tiene imagen propia, usamos la del producto
        return image;
    }
  }
}