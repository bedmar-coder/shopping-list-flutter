import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';

enum OrderBy { id, name, category, price }

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

    _sortList(productsList, orderBy);

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

  static Future<String> loadJson(BuildContext context, String file) async {
    await Future.delayed(Duration(seconds: 2));
    return await DefaultAssetBundle.of(context).loadString(file);
  }

  static _sortList(List<Product> list, OrderBy orderBy) {
    switch (orderBy) {
      case OrderBy.id:
        list.sort((prodA, prodB) => prodA.id.compareTo(prodB.id));
        break;
      case OrderBy.name:
        list.sort((prodA, prodB) => prodA.name.compareTo(prodB.name));
        break;
      case OrderBy.category:
        list.sort((prodA, prodB) => prodA.category.compareTo(prodB.category));
        break;
      case OrderBy.price:
        list.sort((prodA, prodB) => prodA.price.compareTo(prodB.price));
        break;
    }
  }


}
