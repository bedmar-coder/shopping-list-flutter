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
      // TODO Actividad 5: Center + ListView con shrinkWrap: centrado en vertical y con scroll en horizontal
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            _cabecera(),
            _eMailInput(),
            _passwordInput(),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  // TODO Actividad 5: cabecera mejorada con icono y titulos
  Widget _cabecera() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 72.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Bienvenido',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4.0),
          Text(
            'Inicia sesión para empezar tu compra',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _eMailInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        // TODO Actividad 5: teclado de email e icono dentro del campo
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'User',
          hintText: 'Write your email address',
          prefixIcon: const Icon(Icons.email_outlined),
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
          // TODO Actividad 5: icono de candado
          prefixIcon: const Icon(Icons.lock_outline),
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
    // TODO Actividad 5: boton a todo el ancho con el color principal del tema
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
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
                SnackBar(
                  content: const Text('Usuario o contraseña incorrectos'),
                  // TODO Actividad 5: color de error del tema en lugar de un rojo fijo
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          }
        },
      ),
    );
  }
}