import 'package:flutter/material.dart';

import 'components/body.dart';

class RegistrarseScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const RegistrarseScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /* appBar: AppBar(
        title: Text("Regístrate", style: TextStyle(color: Colors.white),),
      ), */
      body: Body(),
    );
  }
}
