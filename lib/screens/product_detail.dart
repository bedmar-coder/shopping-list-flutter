import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final int _id;
  final String _name;
  final String _description;
  // TODO Actividad 4: nuevos datos del producto que se muestran en el detalle
  final double _precio;
  final String _categoria;
  final String _imagen;
  final String _imagenCategoria;

  final _myTextStyle1 = const TextStyle(color: Colors.blue, fontSize: 30.0);
  final _myTextStyle2 = const TextStyle(color: Colors.indigo, fontSize: 30.0);
  final _myTextStyle3 = const TextStyle(color: Colors.indigo, fontSize: 25.0);

  // TODO Actividad 4: el constructor recibe también precio, categoría, imagen e imagen de la categoría
  const ProductDetail(this._id, this._name, this._description, this._precio,
      this._categoria, this._imagen, this._imagenCategoria,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.grey.shade100, Colors.green.shade100])
        ),
        padding: const EdgeInsets.all(12.0),
        // TODO Actividad 4: ListView para poder hacer scroll si el contenido no cabe en pantalla
        child: ListView(
          children: <Widget>[
            //TODO Actividad 4: Dependiendo si es horizontal o no pasamos su respectivo diseño
            enHorizontal ? _disenoHorizontal() : _disenoVertical(),
          ],
        ),
      ),
    );
  }

  // TODO Actividad 4: en vertical, la imagen del producto arriba y los datos debajo
  Widget _disenoVertical() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(child: _imagenProducto()),
        const SizedBox(height: 12.0),
        _datosProducto(),
      ],
    );
  }

  // TODO Actividad 4: en horizontal, la imagen del producto a la izquierda y los datos a la derecha
  Widget _disenoHorizontal() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _imagenProducto(),
        const SizedBox(width: 16.0),
        Expanded(child: _datosProducto()),
      ],
    );
  }

  // TODO Actividad 4: imagen del producto
  Widget _imagenProducto() {
    return Image.asset(_imagen, height: 200.0, fit: BoxFit.contain);
  }

  // TODO Actividad 4: todos los datos del producto
  Widget _datosProducto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Id:', style: _myTextStyle1),
            Text(' $_id ', style: _myTextStyle2),
            Text('Name: ', style: _myTextStyle1),
            // TODO Actividad 4: Expanded para que si un nombre eslargo pase a la línea siguiente
            Expanded(child: Text(_name, style: _myTextStyle2)),
          ],
        ),
        // TODO Actividad 4: precio del producto
        Row(
          children: <Widget>[
            Text('Precio: ', style: _myTextStyle1),
            Text('${_precio.toStringAsFixed(2)} €', style: _myTextStyle2),
          ],
        ),
        const SizedBox(height: 8.0),
        // TODO Actividad 4: categoría con su imagen
        Row(
          children: <Widget>[
            Text('Categoría: ', style: _myTextStyle1),
            Image.asset(_imagenCategoria,
                width: 60.0, height: 60.0, fit: BoxFit.cover),
            const SizedBox(width: 8.0),
            Expanded(child: Text(_categoria, style: _myTextStyle2)),
          ],
        ),
        const Divider(color: Colors.grey, thickness: 1),
        Text('Description ', style: _myTextStyle1),
        Text(_description, style: _myTextStyle3, textAlign: TextAlign.justify),
      ],
    );
  }
}