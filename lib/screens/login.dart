import 'package:flutter/material.dart';
import 'package:t3_shopping_list/screens/products.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // TODO Actividad 3: constantes con el usuario y la contraseña correctos
  static const String _usarioValido = 'miguel@dam.com';
  static const String _passwordValida = 'Comprador1!';

  // TODO Actividad 3: guardamos lo que escriba el usuario para compararlo
  String _usuario = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_eMailInput(), _passwordInput(), _loginButton()],
        ),
      ),
    );
  }

  
  Widget _eMailInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'User',
          hintText: 'Write your email address',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),

        // TODO Actividad 3: guardamos el usuario cada vez que cambia el texto
        onChanged: (value) {
          _usuario = value;
        },
        validator: ((value) {
          if(value == null || value.isEmpty){
            return 'Sorry,  user can\'t be empty';
          }
          // TODO Actividad 3: regla para que si o si tenga @
          if (!value.split('').contains('@')) {
            return 'EL usuario debe incluir un @';
          }
          return null;
        }),
      ),
    );
  }

  Widget _passwordInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: true,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: 'Write your password',
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        // TODO Actividad 3: guardamos la contraseña uando cambia el texto
        onChanged: (value) {
          _password = value;
        },
        validator: ((value) {
          if(value == null || value.isEmpty){
            return 'Sorry, password can not be empty';
          }
          // TODO Actividad 3: mínimo 8 caracteres, una mayúscula, un número y un símbolo
          if (value.length < 8) {
            return 'La contraseña debe tener 8 o más caracteres';
          }
          if (!_tieneMayus(value)) {
            return 'La contraseña debe tener una mayúscula';
          }
          if (!_tieneUnNumero(value)) {
            return 'La contraseña debe tener un número';
          }
          if (!_tieneUnSimbolo(value)) {
            return 'La contraseña necesita un simbolo especial';
          }

          return null;
        }
        ),
      ),
    );
  }

  // TODO Actividad 3: true si el texto tiene al menos una mayuscula
  bool _tieneMayus(String texto) {
    for (var c in texto.split('')) {
      if (c != c.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  // TODO Actividad 3: true si el texto tiene al menos un número
  bool _tieneUnNumero(String texto) {
    for (var c in texto.split('')) {
      if (int.tryParse(c) != null) {
        return true;
      }
    }
    return false;
  }

  // TODO Actividad 3: true si el texto tiene al menos un símbolo (ni letra, ni número, ni espacio)
  bool _tieneUnSimbolo(String texto) {
    for (var c in texto.split('')) {
      bool isLetter = c.toLowerCase() != c.toUpperCase();
      bool isNumber = int.tryParse(c) != null;
      if (!isLetter && !isNumber && c != ' ') {
        return true;
      }
    }
    return false;
  }

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // TODO Actividad 3: comprobamos si el login es correcto comparando con las constantes
            if (_usuario == _usarioValido && _password == _passwordValida) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bienvenido $_usuario!')),
              );
              // TODO Actividad 3: pushReplacement sustituye el Login por la lista y ya no se puede volver
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductsScreen()),
              );
            } else {
              // TODO Actividad 3: login incorrecto con mensaje de error y nos quedamos en el login
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Usuario o contraseña incorrectos'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
