import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';
import 'package:t3_shopping_list/providers/products_data.dart';
import 'package:t3_shopping_list/screens/product_detail.dart';

//TODO Actividad 1: import de la pantalla del carrito
import 'package:t3_shopping_list/screens/cart.dart';

//TODO Actividad1: cambio ProductsScreen  a StatefulWidget para guardar los estados de los productos
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  //TODO Actividad 1: productos guardados en el estado con ? porque será null hasta que cargue el json
  ProductsData? _productsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Products'),
        //TODO Actividad 1: Añadido icono del carrito a la appbar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _openCart,
          ),
        ],
      ),
      body: FutureBuilder(
        future: ProductsData.loadJson(context, 'assets/json/products.json'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            //TODO actividad 1: solo creamoslos productos la primera vez para no perder sus selcción
            if (_productsData == null) {
              _productsData = ProductsData.fromJson(snapshot.data!);
            }
            return _ProductsListView(_productsData!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // TODO Actividad 1: abre el carrito o un AlertDialog si está vacío
  void _openCart() {
    if (_productsData == null || _productsData!.getSelectedProducts().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('My shopping cart'),
            content: const Text('Your shopping cart is empty'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartScreen(_productsData!)),
      );
    }
  }
}

class _ProductsListView extends StatelessWidget {
  final ProductsData _productsData;

  _ProductsListView(this._productsData);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _productsData.getSize(),
      itemBuilder: (context, index) =>
          _listItem(context, _productsData.getProduct(index)),
    );
  }

  Widget _listItem(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            // TODO Actividad 4: pasamos también precio, categoría, imagen e imagen de la categoría
            ProductDetail(product.id, product.name, product.description,
                product.price, product.category, product.image,
                product.imagenCategoria),
          ),
        ),
        leading: Image.asset(
          product.image,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
        //TODO Actividad 1: he cambiado el icono shoppping bar para que ahora sea un widget Stateful para poder
        //añadir y quitar del carrito
        trailing: _ShoppingBagIcon(product),
        title: Text(product.name),
        subtitle: Text('${product.price}'),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
//TODO Actividad 1: el icono shopping bar convertido en widget con estado propio
class _ShoppingBagIcon extends StatefulWidget {
  final Product product;

  const _ShoppingBagIcon(this.product);

  @override
  State<_ShoppingBagIcon> createState() => _ShoppingBagIconState();
}

class _ShoppingBagIconState extends State<_ShoppingBagIcon> {
  late bool _selected;
  @override
  void initState() {
    super.initState();
    _selected = widget.product.selected;
  }

  // TODO Actividad 1: si el widget se reutiliza con otro producto actualizamos su estado
  @override
  void didUpdateWidget(_ShoppingBagIcon viejoWidget) {
    super.didUpdateWidget(viejoWidget);
    if (widget.product != viejoWidget.product) {
      _selected = widget.product.selected;
    }
  }

  //TODO Actividad 1; selecciona o quita el producto
void _toggleSelected() {
    setState(() {
      _selected = !_selected;
      widget.product.selected = _selected;
      if (!_selected) {
        widget.product.quantity = 1;
      }
    });
}

@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelected,
      child: Icon(
        Icons.shopping_bag,
        color: _selected ? Colors.green : Colors.grey,
      ),
    );
  }
}
