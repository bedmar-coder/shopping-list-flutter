import 'package:flutter/material.dart';

// TODO Actividad 5: widget reutilizable con la imagen del producto
class ImagenProducto extends StatelessWidget {
  final String ruta;
  final String tagHero;
  final double ancho;
  final double alto;

  const ImagenProducto(this.ruta, this.tagHero, this.ancho, this.alto,
      {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Actividad 5: Hero anima la imagen entre dos pantallas que usen el mismo tag
    return Hero(
      tag: tagHero,
      // TODO Actividad 5: mismo redondeo en todas las pantallas para que la imagen no cambie de forma
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.asset(ruta, width: ancho, height: alto, fit: BoxFit.cover),
      ),
    );
  }
}