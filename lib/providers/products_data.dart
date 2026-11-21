import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';

// TODO Actividad 2: añadidos iva, descuento y calorias para poder ordenar por ellos
enum OrderBy { id, name, category, price, iva, descuento, calorias }

class ProductsData {
  final List<Product> _products;

  ProductsData._(this._products);

  factory ProductsData.fromJson(
    String jsonData, {
    OrderBy orderBy = OrderBy.name,
  }) {
    Map<String, dynamic> mapJson = json.decode(jsonData);

    List<dynamic> list = mapJson["products"];

    List<Product> productsList = list
        .map((element) => Product.fromMap(element))
        .toList();

    // TODO Actividad 2: al cargar, la lista se ordena de forma ascendente
    _sortList(productsList, orderBy, true);

    return ProductsData._(productsList);
  }

  Product getProduct(int index) => _products[index];

  int getSize() => _products.length;

  //TODO Actividad 1: devuelve una lista con los productos seleccionados
  List<Product> getSelectedProducts(){
    List<Product> selectedList = [];
    for (var producto in _products) {
      if (producto.selected) {
        selectedList.add(producto);
      }
    }

    return selectedList;
  }

  //TODO Actividad 1: calcula el importe total de la compra según las cantidades de los productos
  double getTotal() {
    double total = 0.0;
    for (var producto in _products) {
      if (producto.selected) {
        total += producto.price * producto.quantity;
      }
    }
    return total;
  }

  // TODO Actividad 2: reordena la lista de productos por el campo indicado, ascendente o descendente
  void ordenar(OrderBy orderBy, bool ascendente) {
    _sortList(_products, orderBy, ascendente);
  }

  static Future<String> loadJson(BuildContext context, String file) async {
    await Future.delayed(Duration(seconds: 2));
    return await DefaultAssetBundle.of(context).loadString(file);
  }

  // TODO Actividad 2: nuevo parámetro ascendente y casos para los nuevos campos
  static void _sortList(List<Product> list, OrderBy orderBy, bool ascendente) {
    // TODO Actividad 2: con 1 se ordena de menor a mayor; con -1 se invierte el resultado de compareTo
    int sentido = ascendente ? 1 : -1;

    switch (orderBy) {
      case OrderBy.id:
        list.sort((prodA, prodB) => sentido * prodA.id.compareTo(prodB.id));
        break;
      case OrderBy.name:
        list.sort((prodA, prodB) => sentido * prodA.name.compareTo(prodB.name));
        break;
      case OrderBy.category:
        list.sort((prodA, prodB) =>
        sentido * prodA.category.compareTo(prodB.category));
        break;
      case OrderBy.price:
        list.sort((prodA, prodB) => sentido * prodA.price.compareTo(prodB.price));
        break;
      case OrderBy.iva:
        list.sort((prodA, prodB) => sentido * prodA.iva.compareTo(prodB.iva));
        break;
      case OrderBy.descuento:
        list.sort((prodA, prodB) =>
        sentido * prodA.descuento.compareTo(prodB.descuento));
        break;
      case OrderBy.calorias:
        list.sort((prodA, prodB) =>
        sentido * prodA.calorias.compareTo(prodB.calorias));
        break;
    }
  }
}