import 'package:flutter/material.dart';
import 'package:wolf_tienda_online/components/fondo_colorfiltered.dart';
import 'package:wolf_tienda_online/constants.dart';
import 'package:wolf_tienda_online/size_config.dart';

import 'registrarse_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const FondoColorFiltered(),
      SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Crea una cuenta",
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: getProportionateScreenWidth(35),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    "Completa los datos solicitados acontinuación",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: getProportionateScreenWidth(15)),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  const RegistrarseForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RedSocialCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      RedSocialCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      RedSocialCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ), */
                  //SizedBox(height: getProportionateScreenHeight(20)),
                  Text(
                    'Al crear la cuenta confirmas que estas de acuerdo con nuestros Términos y Condiciones.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        //descargar terminos y condiciones de firebase storage
                      },
                      child: const Text("Ver Terminos y Condiciones",
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1))),
                  SizedBox(height: getProportionateScreenHeight(10)),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
