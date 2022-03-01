import 'package:flutter/material.dart';

import 'components/body.dart';

class IniciarSesionScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const IniciarSesionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /* appBar: AppBar(
        title: Text("Iniciar sesión", style: TextStyle(color: Colors.white),),
      ), */
      body: Body(),
    );
  }
}
