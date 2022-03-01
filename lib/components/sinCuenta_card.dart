import 'package:flutter/material.dart';
import 'package:wolf_tienda_online/screens/registrarse/registrarse_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class SinCuentaText extends StatelessWidget {
  const SinCuentaText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿No tienes una cuenta? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(18)),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RegistrarseScreen.routeName),
          child: Text(
            "Regístrate",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: kSecondaryColor),
          ),
        ),
      ],
    );
  }
}
