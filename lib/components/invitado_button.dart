import 'package:flutter/material.dart';
import 'package:wolf_tienda_online/constants.dart';
import 'package:wolf_tienda_online/screens/home/home_screen.dart';
import 'package:wolf_tienda_online/screens/iniciar_sesion/iniciarSesion_screen.dart';
import 'package:wolf_tienda_online/screens/registrarse/registrarse_screen.dart';

class InvitadoButton extends StatelessWidget {
  const InvitadoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('INGRESAR COMO INVITADO'),
        onPressed: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
          _showAlertDialog(context);
        },
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          primary: kSecondaryColor,
        ));
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: const FittedBox(
              child: Text(
                "Modo INVITADO",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Ingresaste como invitado."),
                const Text(
                    "Para realizar una compra debes identificarte o, si no tienes cuenta, registrarte (Es gratis!)."),
                botonModoInvitado(
                    context, "Identificarme", IniciarSesionScreen.routeName),
                botonModoInvitado(
                    context, "Ir a registrarme", RegistrarseScreen.routeName),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text(
                  "ACEPTAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  primary: kPrimaryColor,
                ),
              )
            ],
          );
        });
  }

  TextButton botonModoInvitado(
      BuildContext context, String titulo, String ruta) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, ruta);
      },
      child: Center(
        child: Text(
          titulo,
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
