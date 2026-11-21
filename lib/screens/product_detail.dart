import 'package:flutter/material.dart';
// TODO Actividad 5: widget reutilizable de la imagen con Hero
import 'package:t3_shopping_list/widgets/imagen_producto.dart';

class ProductDetail extends StatelessWidget {
  final int _id;
  final String _name;
  final String _description;
  // TODO Actividad 4: nuevos datos del producto que se muestran en el detalle
  final double _precio;
  final String _categoria;
  final String _imagen;
  final String _imagenCategoria;
  // TODO Actividad 5: tag del Hero, distinto si venimos de la lista o del carrito
  final String _tagHero;

  // TODO Actividad 4: el constructor recibe también precio, categoría, imagen e imagen de la categoría
  // TODO Actividad 5: y el tag del Hero
  const ProductDetail(this._id, this._name, this._description, this._precio,
      this._categoria, this._imagen, this._imagenCategoria, this._tagHero,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Actividad 4: comprobamos si el móvil está en horizontal,osea landscape,  o en vertical
    bool enHorizontal =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: Text('Product detail')),
      body: Container(
        // TODO Actividad 5: degradado con los colores del tema
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
        ),
        // TODO Actividad 4: ListView para poder hacer scroll si el contenido no cabe en pantalla
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            //TODO Actividad 4: Dependiendo si es horizontal o no pasamos su respectivo diseño
            enHorizontal ? _disenoHorizontal(context) : _disenoVertical(context),
          ],
        ),
      ),
    );
  }

  // TODO Actividad 4: en vertical, la imagen del producto arriba y los datos debajo
  Widget _disenoVertical(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // TODO Actividad 5: imagen a todo el ancho con Hero
        ImagenProducto(_imagen, _tagHero, double.infinity, 240.0),
        const SizedBox(height: 16.0),
        _datosProducto(context),
      ],
    );
  }

  // TODO Actividad 4: en horizontal, la imagen del producto a la izquierda y los datos a la derecha
  Widget _disenoHorizontal(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // TODO Actividad 5: imagen con Hero a la izquierda
        ImagenProducto(_imagen, _tagHero, 280.0, 220.0),
        const SizedBox(width: 24.0),
        Expanded(child: _datosProducto(context)),
      ],
    );
  }

  // TODO Actividad 4: todos los datos del producto
  // TODO Actividad 5: textos con los estilos del tema en lugar de tamaño 30
  Widget _datosProducto(BuildContext context) {
    final estilos = Theme.of(context).textTheme;
    final colores = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // TODO Actividad 5: el nombre como título principal
        Text(
          _name,
          style: estilos.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text('Id: $_id', style: estilos.bodyMedium),
        const SizedBox(height: 8.0),
        // TODO Actividad 4: precio del producto
        // TODO Actividad 5: precio destacado con el color del tema
        Text(
          'Precio: ${_precio.toStringAsFixed(2)} €',
          style: estilos.titleLarge?.copyWith(
            color: colores.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        // TODO Actividad 4: categoría con su imagen
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(_imagenCategoria,
                  width: 48.0, height: 48.0, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text('Categoría: $_categoria', style: estilos.titleMedium),
            ),
          ],
        ),
        const Divider(height: 32.0),
        Text('Description', style: estilos.titleMedium),
        const SizedBox(height: 4.0),
        Text(_description,
            style: estilos.bodyLarge, textAlign: TextAlign.justify),
      ],
    );
  }
}