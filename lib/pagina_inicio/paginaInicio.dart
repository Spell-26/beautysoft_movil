import 'package:flutter/material.dart';
import 'package:beauty_soft/componentes_reutilizables/boton.dart';
import 'package:beauty_soft/login_registro/login.dart';
import 'package:beauty_soft/login_registro/registro.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key, this.pagina});

  final void Function(Widget pagina)? pagina;

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 106, 46, 134),
            Color.fromARGB(255, 197, 97, 69),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo_beautysoft.png',
            width: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Beauty Soft',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotonUno(
                texto: "Iniciar Sesión",
                funcion: pagina,
                pagina: Login(
                  cambiarPagina: pagina,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              BotonUno(
                texto: "Registrarse",
                funcion: pagina,
                pagina: Registro(
                  cambiarPagina: pagina,
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
