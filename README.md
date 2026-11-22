# Shopping List (Flutter)

A small shopping list app built with Flutter as a class project for the Multimedia and Mobile Device Programming module (PMDM) of my Multiplatform Application Development (DAM) studies. It started as a guided workshop, and I then extended it with five extra features of my own: a shopping cart, sorting, stricter login validation, a full product detail screen and a UI redesign.

No external packages were used, only Flutter and Material.

## Features

- Login screen with form validation: the user must be an email, and the password needs at least 8 characters, an uppercase letter, a number and a symbol. Credentials are checked before entering the app, and the login screen is replaced so you can't go back to it.
- Product list loaded asynchronously from a local JSON file.
- Shopping cart: select products from the list, change quantities (minimum 1) and see the total price update in real time.
- Sorting bar: sort the list by any field (name, price, category, VAT, discount, calories...) in ascending or descending order.
- Product detail screen with all the product information and a category image, with a layout that adapts to portrait and landscape.
- Material 3 theme generated from a single seed color, and Hero animations for the product images between screens.

## Built with

- Flutter 3.47.7 / Dart
- StatefulWidget and setState for state management
- FutureBuilder and asset loading for the JSON data
- Form, TextFormField and custom validators
- Navigator (push and pushReplacement)
- ListView.builder, MediaQuery for orientation and Hero animations

## Some decisions I made

- The cart doesn't use a separate list or model. Each product keeps its own selected state and quantity, and the cart works with references to the same objects, so changes are shared between screens without passing data back.
- The selection icon is its own StatefulWidget, so tapping it only rebuilds the icon and not the whole list. It also uses didUpdateWidget, because ListView.builder recycles item states while scrolling.
- The JSON loading Future is created once and reused, so sorting the list doesn't reload the data every time.
- Password rules are checked by walking through the characters instead of using regular expressions, to keep the logic easy to read.

## Project structure

- lib/main.dart: app entry point and global theme
- lib/models/product.dart: product model
- lib/providers/products_data.dart: data loading, sorting, selected products and total
- lib/screens/: login, product list, cart and product detail screens
- lib/widgets/imagen_producto.dart: reusable product image with Hero animation
- assets/: product data (JSON) and images

## Getting started

You need Flutter 3.47.7. Newer versions require a newer Android Gradle Plugin than the one this project uses.

    git clone https://github.com/bedmar-coder/shopping-list-flutter.git
    cd shopping-list-flutter
    flutter pub get
    flutter run

Demo login: miguel@dam.com / Comprador1!

## Author

Miguel Ángel Sánchez Herrero
