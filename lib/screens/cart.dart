import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';
import 'package:t3_shopping_list/providers/products_data.dart';

// TODO Actividad 1: nueva pantalla que muestra solo los productos seleccionados
class CartScreen extends StatefulWidget {
  final ProductsData productsData;

  const CartScreen(this.productsData, {super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> _cart;

  @override
  void initState() {
    super.initState();
    _cart = widget.productsData.getSelectedProducts();
  }

  // TODO Actividad 1: cambia la cantidad siempre minimo uno y actualiza el importe total
  void _updateQuantity(Product product, int change) {
    setState(() {
      if (product.quantity + change >= 1) {
        product.quantity += change;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping Cart'),
        // TODO Actividad 1: importe total de la compra en la AppBar
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                '${widget.productsData.getTotal().toStringAsFixed(2)} €',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _cart.length,
        itemBuilder: (context, index) => _cartItem(_cart[index]),
      ),
    );
  }

  Widget _cartItem(Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Image.asset(
          product.image,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.contain,
        ),
        title: Text(product.name),
        subtitle: Text('${product.price} €'),
        // TODO Actividad 1: botones - y + para indicar las unidades a comprar
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              color: Colors.red,
              onPressed: () => _updateQuantity(product, -1),
            ),
            Text(
              '${product.quantity}',
              style: const TextStyle(fontSize: 20.0, color: Colors.indigo),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.green,
              onPressed: () => _updateQuantity(product, 1),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}