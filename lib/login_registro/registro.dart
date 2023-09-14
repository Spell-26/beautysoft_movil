import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:beauty_soft/pagina_inicio/paginaInicio.dart';

class Registro extends StatefulWidget {
  const Registro({super.key, this.cambiarPagina});

  final void Function(Widget pagina)? cambiarPagina;

  @override
  State<Registro> createState() {
    return _RegistroState();
  }
}

class _RegistroState extends State<Registro> {
  final _formKey = GlobalKey<FormState>();

  //Encargados de asumir el valor de los inputs
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();
  final TextEditingController _contrasena2 = TextEditingController();

//Se genera la instancia de la base de datos
  final db = FirebaseFirestore.instance;
//Función para inserta el documento;
  registroUsuario() async {
    try {
      await db.collection('Usuarios').doc().set({
        "nombre": _nombre.text,
        "apellido": _apellido.text,
        "correo": _correo.text,
        "contrasena": _contrasena.text,
        "contrasena2": _contrasena2.text
      });
    } catch (e) {
      print("Error ${e.toString()}");
    }
  }

  // validarCorreoExistente() async {
  //   CollectionReference ref = FirebaseFirestore.instance.collection('Usuarios');
  //   QuerySnapshot usuarios = await ref.get();
  //   if (usuarios.docs.isEmpty) {
  //     for (var item in usuarios.docs) {
  //       if (item.get('correo' == _correo.text)) {
  //         print("No se puede registrar el mismo correo");
  //       }
  //     }
  //   }
  // }

  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  'Registro',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
                padding: const EdgeInsets.all(10),
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(107, 206, 227, 1),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: const Text(
                  'En esta ventana podrás registrarte como un nuevo usuario',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(83, 5, 250, 1)),
                )),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      margin: const EdgeInsets.only(top: 20, left: 55),
                      child: TextFormField(
                        controller: _nombre,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(164, 119, 90, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(164, 119, 90, 1))),
                            hintText: 'Nombre',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(118, 118, 118, 1))),
                        validator: (valor) {
                          if (valor!.isEmpty) {
                            return 'Por favor, ingrese su nombre';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 120,
                      margin: const EdgeInsets.only(top: 20, right: 60),
                      child: TextFormField(
                        validator: (valor) {
                          if (valor!.isEmpty) {
                            return 'Por favor, ingrese su apellido';
                          }
                          return null;
                        },
                        controller: _apellido,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(164, 119, 90, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(164, 119, 90, 1))),
                            hintText: 'Apellido',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(118, 118, 118, 1))),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
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
                          controller: _correo,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(164, 119, 90, 1))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(164, 119, 90, 1))),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(118, 118, 118, 1))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextFormField(
                          validator: (valor) {
                            String pattern =
                                r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
                            RegExp regExp = RegExp(pattern);
                            if (valor!.isEmpty) {
                              return "Por favor, la contraseña es necesaria";
                            } else if (!regExp.hasMatch(valor)) {
                              return "La contraseña debe tener al menos 8 caracteres, 1 letra mayúscula, 1 minúscula y 1 número. Además puede contener caracteres especiales.";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          obscureText: true,
                          controller: _contrasena,
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
                                  color: Color.fromRGBO(118, 118, 118, 1))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextFormField(
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Por favor, confirme contraseña';
                            }
                            if (valor != _password) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: _contrasena2,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(164, 119, 90, 1))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(164, 119, 90, 1))),
                              hintText: 'Confirmar contraseña',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(118, 118, 118, 1))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 280,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  backgroundColor:
                                      const Color.fromRGBO(116, 51, 127, 1)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print("enviando");
                                  const snackBar = SnackBar(
                                    backgroundColor:
                                        Color.fromRGBO(116, 51, 127, 1),
                                    content: Text('Registro exitoso'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  registroUsuario();
                                  widget.cambiarPagina!(PaginaInicio(
                                    pagina: widget.cambiarPagina,
                                  ));
                                } else {
                                  const snackBar = SnackBar(
                                    backgroundColor:
                                        Color.fromRGBO(116, 51, 127, 1),
                                    content: Text('Registro invalido'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: 280,
                        child: Text(
                          'Al diligenciar este formulario, usted acepta nuestras politicas de tratamiento de datos persopnales y otorga su consentimiento para que estos sean almecenados, recopilados y procesados.',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
