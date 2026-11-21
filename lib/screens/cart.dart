import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';
import 'package:t3_shopping_list/providers/products_data.dart';
// TODO Actividad 4: import de la pantalla de detalle
import 'package:t3_shopping_list/screens/product_detail.dart';
// TODO Actividad 5: widget reutilizable de la imagen con Hero
import 'package:t3_shopping_list/widgets/imagen_producto.dart';

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
    // TODO Actividad 5: el total se calcula una vez y se usa en la AppBar y en la barra inferior
    String total = '${widget.productsData.getTotal().toStringAsFixed(2)} €';

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping Cart'),
        // TODO Actividad 1: importe total de la compra en la AppBar
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                total,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _cart.length,
        itemBuilder: (context, index) => _cartItem(_cart[index]),
      ),
      // TODO Actividad 5: barra inferior fija con el total de la compra bien visible
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        // TODO Actividad 5: SafeArea dentro del color para no tapar la cámara ni la barra de gestos
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total:', style: Theme.of(context).textTheme.titleLarge),
                Text(
                  total,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cartItem(Product product) {
    // TODO Actividad 5: tag distinto al de la lista para que las imágenes no vuelen al abrir el carrito
    String tagHero = 'carrito_${product.id}';

    // TODO Actividad 5: cada producto en un Card, igual que en la lista
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        // TODO Actividad 4: al pulsar un producto del carrito se abre su detalle para ello le ponemos onTap
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product.id, product.name,
                product.description, product.price, product.category,
                product.image, product.imagenCategoria, tagHero
                // TODO Actividad 2: campos nuevos iva, descuento y calorias
                ,product.iva, product.descuento, product.calorias),
          ),
        ),
        // TODO Actividad 5: imagen redondeada con Hero
        leading: ImagenProducto(product.image, tagHero, 64.0, 64.0),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${product.price.toStringAsFixed(2)} €',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        // TODO Actividad 1: botones - y + para indicar las unidades a comprar
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              // TODO Actividad 5: colores del tema en los botones
              color: Theme.of(context).colorScheme.error,
              onPressed: () => _updateQuantity(product, -1),
            ),
            Text(
              '${product.quantity}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => _updateQuantity(product, 1),
            ),
          ],
        ),
      ),
    );
  }
}