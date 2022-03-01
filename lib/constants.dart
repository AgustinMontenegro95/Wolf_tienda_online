import 'package:flutter/material.dart';
import 'package:wolf_tienda_online/size_config.dart';

Color kPrimaryColor = const Color.fromRGBO(3, 0, 61, 1.0);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color.fromRGBO(255, 2, 139, 1.0);
const kTextColor = Color.fromARGB(255, 31, 30, 30);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor, ingresa tu email.";
const String kInvalidEmailError = "Por favor, ingresa un email válido.";
const String kPassNullError = "Por favor, ingresa tu contraseña.";
const String kShortPassError = "La contraseña es demasiado corta.";
const String kMatchPassError = "Las contraseñas no coinciden.";
const String kNamelNullError = "Por favor, ingresa tu nombre.";
const String kLastNamelNullError = "Por favor, ingresa tu apellido.";
const String kDNINullError = "Por favor, ingresa tu DNI.";
const String kPhoneNumberNullError =
    "Por favor, ingresa tu número de teléfono.";
const String kAddressNullError = "Por favor, ingresa tu dirección.";
const String kCodPosNullError = "Por favor, ingresa tu código postal.";
const String kCityNullError = "Por favor, ingresa tu ciudad.";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}
