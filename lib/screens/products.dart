import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';
import 'package:t3_shopping_list/providers/products_data.dart';
import 'package:t3_shopping_list/screens/product_detail.dart';

// TODO Actividad 5: widget reutilizable de la imagen con Hero
import 'package:t3_shopping_list/widgets/imagen_producto.dart';

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

  // TODO Actividad 2: campo por el que está ordenada la lista y sentido del orden
  OrderBy _ordenActual = OrderBy.name;
  bool _ascendente = true;

  // TODO Actividad 2: guardamos la carga del json para no repetirla cada vez que se reordena la lista
  Future<String>? _futuroJson;

  // TODO Actividad 2: didChangeDependencies se llama justo después de initState y ya podemos usar context
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_futuroJson == null) {
      _futuroJson = ProductsData.loadJson(context, 'assets/json/products.json');
    }
  }

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
        // TODO Actividad 2: usamos el json ya guardado en lugar de cargarlo en cada build
        future: _futuroJson,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            //TODO actividad 1: solo creamoslos productos la primera vez para no perder sus selcción
            if (_productsData == null) {
              _productsData = ProductsData.fromJson(snapshot.data!);
            }
            // TODO Actividad 2: la barra para ordenar arriba y la lista ocupando el resto de la pantalla
            return Column(
              children: <Widget>[
                _barraOrdenar(),
                Expanded(
                  child: _ProductsListView(_productsData!, _ordenActual),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // TODO Actividad 2: cabecera con lista horizontal con scroll que tiene un botón por campo
  Widget _barraOrdenar() {
    return Container(
      height: 60.0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        children: <Widget>[
          _botonOrdenar('id', OrderBy.id),
          _botonOrdenar('name', OrderBy.name),
          _botonOrdenar('price', OrderBy.price),
          _botonOrdenar('category', OrderBy.category),
          _botonOrdenar('iva', OrderBy.iva),
          _botonOrdenar('descuento', OrderBy.descuento),
          _botonOrdenar('calorias', OrderBy.calorias),
        ],
      ),
    );
  }

  // TODO Actividad 2: botón de un campo, verde si es el campo activo y con una flecha que indica el sentido
  Widget _botonOrdenar(String nombreCampo, OrderBy campo) {
    final colores = Theme.of(context).colorScheme;
    bool activo = _ordenActual == campo;

    String flecha = '';
    if (activo) {
      flecha = _ascendente ? ' ↑' : ' ↓';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: activo ? colores.primary : colores.surface,
          foregroundColor: activo ? colores.onPrimary : colores.onSurface,
        ),
        onPressed: () => _ordenarPor(campo),
        child: Text('$nombreCampo$flecha'),
      ),
    );
  }

  // TODO Actividad 2: reordena la lista y actualiza la interfaz. Si se pulsa el campo activo, se invierte el sentido
  void _ordenarPor(OrderBy campo) {
    setState(() {
      if (_ordenActual == campo) {
        _ascendente = !_ascendente;
      } else {
        _ordenActual = campo;
        _ascendente = true;
      }
      _productsData!.ordenar(_ordenActual, _ascendente);
    });
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

  // TODO Actividad 2: campo por el que se ordena, para mostrar su valor en cada fila
  final OrderBy _orden;

  _ProductsListView(this._productsData, this._orden);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // TODO Actividad 5: margen arriba y abajo para que la lista no quede pegada a la AppBar
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: _productsData.getSize(),
      itemBuilder: (context, index) =>
          _listItem(context, _productsData.getProduct(index)),
    );
  }

  // TODO Actividad 2: texto con el valor del campo de orden. Vacío si es name o price, que ya se ven en la fila
  String _datoOrden(Product product) {
    switch (_orden) {
      case OrderBy.id:
        return 'Id: ${product.id}';
      case OrderBy.category:
        return 'Categoría: ${product.category}';
      case OrderBy.iva:
        return 'IVA: ${product.iva} %';
      case OrderBy.descuento:
        return 'Descuento: ${product.descuento} %';
      case OrderBy.calorias:
        return '${product.calorias} kcal / 100 g';
      default:
        return '';
    }
  }

  Widget _listItem(BuildContext context, Product product) {
    // TODO Actividad 5: tag único de la animación Hero para las imágenes de la lista
    String tagHero = 'lista_${product.id}';
    // TODO Actividad 2: precio y, debajo, el dato del campo por el que se ordena
    Text textoPrecio = Text(
      '${product.price.toStringAsFixed(2)} €',
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    );
    String datoOrden = _datoOrden(product);

    // TODO Actividad 5: cada producto en un Card en lugar de un borde fijo
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                // TODO Actividad 4: pasamos también precio, categoría, imagen e imagen de la categoría
                // TODO Actividad 5: y el tag del Hero para que la imagen vuele hasta el detalle
                // TODO Actividad 2: y los campos nuevos iva, descuento y calorias
                ProductDetail(
                  product.id,
                  product.name,
                  product.description,
                  product.price,
                  product.category,
                  product.image,
                  product.imagenCategoria,
                  tagHero,
                  product.iva,
                  product.descuento,
                  product.calorias,
                ),
          ),
        ),
        // TODO Actividad 5: imagen redondeada con Hero
        leading: ImagenProducto(product.image, tagHero, 80.0, 80.0),
        //TODO Actividad 1: he cambiado el icono shoppping bar para que ahora sea un widget Stateful para poder
        //añadir y quitar del carrito
        trailing: _ShoppingBagIcon(product),
        // TODO Actividad 5: nombre en negrita y precio con dos decimales y el color del tema
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        //TODO Actividad 2: Si está vacio el texto del precio y si no la info de ordcen
        subtitle: datoOrden.isEmpty
            ? textoPrecio
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[textoPrecio, Text(datoOrden)],
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
      // TODO Actividad 5: el Padding agranda la zona que se puede pulsar alrededor del icono
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.shopping_bag,
          size: 28.0,
          // TODO Actividad 5: color del tema cuando está seleccionado
          color: _selected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
      ),
    );
  }
}
