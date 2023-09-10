import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:beauty_soft/home/home.dart';
// import 'package:beauty_soft/componentes_reutilizables/boton.dart';

class Login extends StatefulWidget {
  final void Function(Widget pagina)? cambiarPagina;

  const Login({this.cambiarPagina, super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  //Encargados de asumir el valor de los inputs
  final TextEditingController _usuario = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  validarDatos() async {
    try {
      //Me permite hacer referencia a la colección externa  y creare una intancia de la misma coleccion
      CollectionReference referencia =
          FirebaseFirestore.instance.collection('Usuarios');
      // nos permite hacer la consulta a la instancia
      QuerySnapshot usuario = await referencia.get();
      if (usuario.docs.isNotEmpty) {
        //Haga una iteracion por cada uno de los documentos;S
        for (var item in usuario.docs) {
          if (item.get('correo') == _usuario.text) {
            print("Usuario encontrado");
            print(item.get('correo'));
            if (item.get('contrasena2') == _contrasena.text) {
              print(item.get('contrasena2'));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            } else {
              print("No se encontró");
            }
          }
        }
      } else {
        print("No hay documentos");
      }
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(60)),
                    color: Colors.purple),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                decoration: const BoxDecoration(color: Colors.purple),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(120)),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Form(
        key: _formKey,
        child: Container(
          width: 250,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextFormField(
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(pattern);
                    if (value!.isEmpty) {
                      return "El correo es necesario";
                    } else if (!regExp.hasMatch(value)) {
                      return "Correo invalido";
                    } else {
                      return null;
                    }
                  },
                  controller: _usuario,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(164, 119, 90, 1))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(164, 119, 90, 1))),
                      hintText: 'Email o número de teléfono',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(118, 118, 118, 1)))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextFormField(
                  controller: _contrasena,
                  obscureText: true,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(164, 119, 90, 1))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(164, 119, 90, 1))),
                      hintText: 'Contraseña',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(118, 118, 118, 1)))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 8,
                              backgroundColor:
                                  const Color.fromRGBO(116, 51, 127, 1)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              validarDatos();
                            }
                          },
                          child: const Text("Enviar"))),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Color.fromRGBO(106, 46, 134, 1)))
                ],
              ),
            ),
            const SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registrarse',
                    style: TextStyle(color: Color.fromRGBO(106, 46, 134, 1)),
                  )
                ],
              ),
            )
          ]),
        ),
      )
    ]));
  }
}
