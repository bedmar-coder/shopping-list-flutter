import 'package:flutter/material.dart';
import 'package:t3_shopping_list/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const _title = 'Shopping List';

  @override
  Widget build(BuildContext context) {
    // TODO Actividad 5: paleta de colores de toda la app cambiada  avverde
    final esquemaColores = ColorScheme.fromSeed(seedColor: Colors.green);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      // TODO Actividad 5: tema global para que todas las pantallas tengan colores relacioandos
      theme: ThemeData(
        colorScheme: esquemaColores,
        // TODO Actividad 5: AppBar verde con texto blanco en todas las pantallas
        appBarTheme: AppBarTheme(
          backgroundColor: esquemaColores.primary,
          foregroundColor: esquemaColores.onPrimary,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),),
        body: const LoginScreen(),
      ),
    );
  }
}