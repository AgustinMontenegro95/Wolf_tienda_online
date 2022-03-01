import 'package:flutter/material.dart';

import 'components/body.dart';

class RecuperarContScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  const RecuperarContScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /* appBar: AppBar(
        title: Text("Recuperar contraseña"),
      ), */
      body: Body(),
    );
  }
}
