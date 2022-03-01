import 'package:flutter/widgets.dart';
import 'package:wolf_tienda_online/screens/ajustes/ajustes_screen.dart';
import 'package:wolf_tienda_online/screens/cart/cart_screen.dart';
import 'package:wolf_tienda_online/screens/complete_profile/complete_profile_screen.dart';
import 'package:wolf_tienda_online/screens/details/details_screen.dart';
import 'package:wolf_tienda_online/screens/esqueleto/esqueleto_screen.dart';
import 'package:wolf_tienda_online/screens/home/home_screen.dart';
import 'package:wolf_tienda_online/screens/iniciar_sesion/iniciarSesion_screen.dart';
import 'package:wolf_tienda_online/screens/otp/otp_screen.dart';
import 'package:wolf_tienda_online/screens/profile/profile_screen.dart';
import 'package:wolf_tienda_online/screens/registrarse/registrarse_screen.dart';
import 'package:wolf_tienda_online/screens/splash/splash_screen.dart';

import 'screens/recuperar_contrasena/recuperarContrasena_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IniciarSesionScreen.routeName: (context) => const IniciarSesionScreen(),
  RecuperarContScreen.routeName: (context) => const RecuperarContScreen(),
  RegistrarseScreen.routeName: (context) => const RegistrarseScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  AjustesScreen.routeName: (context) => const AjustesScreen(),
  EsqueletoPage.routeName: (context) => const EsqueletoPage(),
};
