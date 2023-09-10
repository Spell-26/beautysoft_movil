import 'package:flutter/material.dart';
import 'package:beauty_soft/home/home.dart';

class BotonUno extends StatelessWidget {
  BotonUno({this.funcion, super.key, required this.texto, this.pagina});

  final void Function(Widget pagina)? funcion;
  final Widget? pagina;
  final String texto;

  @override
  Widget build(context) {
    return FilledButton(
      onPressed: () {
        funcion!(pagina!);
      },
      style: const ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll<Color>(Color.fromARGB(255, 106, 46, 134)),
        padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(20)),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BotonDos extends StatelessWidget {
  final void Function(Widget pagina)? funcion;
  final String texto;

  const BotonDos({this.funcion, required this.texto, super.key});

  @override
  Widget build(context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
        elevation: MaterialStatePropertyAll(8),
      ),
      /*ElevatedButton.styleFrom(
          elevation: 8, backgroundColor: Colors.purple),*/
      onPressed: () {
        funcion!(const Home());
      },
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
