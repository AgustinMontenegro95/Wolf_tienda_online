import 'package:flutter/material.dart';
import 'package:wolf_tienda_online/screens/ajustes/components/body.dart';

class AjustesScreen extends StatelessWidget {
  static String routeName = "/ajustes";

  const AjustesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajustes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Body(),
    );
  }
}
