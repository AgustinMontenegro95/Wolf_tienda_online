import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wolf_tienda_online/components/fondo_colorfiltered.dart';
import 'package:wolf_tienda_online/constants.dart';
import 'package:wolf_tienda_online/models/user_model.dart';
import 'package:wolf_tienda_online/size_config.dart';

import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  Future<void> _recibirDatos() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
  }

  final estiloCuerpo = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Colors.grey,
  );

  final estiloTitulo = const TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.w900,
    shadows: [
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 5,
        color: Colors.black,
      ),
    ],
  );

  final estiloPropiedad = const TextStyle(
    color: Colors.purpleAccent,
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontFamily: 'Muli',
    /* shadows: [
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 5,
        color: Colors.black,
      ),
    ], */
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _recibirDatos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // El futuro aún no ha terminado, devuelve un marcador de posición
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: kSecondaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            );
          }
          //retorna carga completa
          return Stack(children: [
            const FondoColorFiltered(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: ProfilePic(imagen: loggedInUser.imagPerfil)),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    _tituloCuenta("DATOS DE LA CUENTA"),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formatoFila("E-Mail", loggedInUser.email!),
                        ],
                      ),
                    ),
                    _tituloCuenta("DATOS PERSONALES"),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formatoFila("Nombre", loggedInUser.nombre!),
                          _formatoFila("Apellido", loggedInUser.apellido!),
                          _formatoFila("Documento", loggedInUser.dni!),
                          _formatoFila("Teléfono", loggedInUser.telefono!),
                        ],
                      ),
                    ),
                    _tituloCuenta("DOMICILIO"),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formatoFila("Calle", loggedInUser.calleDir!),
                          _formatoFila("Número", loggedInUser.numeroDir!),
                          _formatoFila("Ciudad", loggedInUser.ciudad!),
                          _formatoFila("Provincia", loggedInUser.provincia!),
                          _formatoFila(
                              "Código postal", loggedInUser.codPostal!),
                        ],
                      ),
                    ),
                    _botonEditarDatos(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 28,
              left: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: kPrimaryColor,
              ),
            ),
          ]);
        });
  }

  Widget _botonEditarDatos() {
    return Center(
      child: SizedBox(
        width: getProportionateScreenWidth(200),
        height: getProportionateScreenHeight(50),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: Colors.white,
            backgroundColor: kPrimaryColor.withOpacity(0.5),
          ),
          onPressed: () {},
          child: Text(
            "Modificar mis datos",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _formatoFila(String propiedad, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$propiedad: ", style: estiloPropiedad),
        Text(valor, style: estiloCuerpo)
      ],
    );
  }

  Widget _tituloCuenta(String titulo) {
    return Stack(children: [
      Center(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(colors: [
                  kSecondaryColor.withOpacity(0.1),
                  kPrimaryColor.withOpacity(0.1)
                ])),
            height: getProportionateScreenHeight(55),
            width: getProportionateScreenWidth(325)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: estiloTitulo,
          ),
        ],
      ),
    ]);
  }
}
