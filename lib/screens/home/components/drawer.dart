import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolf_tienda_online/screens/ajustes/ajustes_screen.dart';
import 'package:wolf_tienda_online/screens/cart/cart_screen.dart';
import 'package:wolf_tienda_online/screens/esqueleto/esqueleto_screen.dart';
import 'package:wolf_tienda_online/screens/iniciar_sesion/iniciarSesion_screen.dart';
import 'package:wolf_tienda_online/screens/profile/profile_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  FirebaseAuth auth = FirebaseAuth.instance;
  //late SharedPreferences logindata;
  late bool _logueado;

  Future signOut() async {
    await auth.signOut().then((value) => Navigator.pushNamedAndRemoveUntil(
        context, IniciarSesionScreen.routeName, (route) => false));
  }

  //Cambiando el booleano después del clic en Iniciar Sesion
  _changeTrueLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('logueo', false);

      debugPrint(
          "Seteo Login FALSE en Drawer ------------------------  logueado ${prefs.setBool('logueo', false)}");
    });
  }

  /* void setLoginData() async {
    logindata = await SharedPreferences.getInstance();
    print("Seteo Login FALSE en Drawer");
    logindata.setBool('login', false);
  } */

  @override
  Widget build(BuildContext context) {
    TextStyle estilo = TextStyle(
      color: kPrimaryColor,
      fontSize: getProportionateScreenWidth(18),
      fontWeight: FontWeight.bold,
    );
    TextStyle estiloSub = TextStyle(
      color: Colors.grey,
      fontSize: getProportionateScreenWidth(14),
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          ListTile(
            title: Text('Tienda', style: estilo),
            subtitle: Text('Store', style: estiloSub),
            leading: const Icon(Icons.storefront_outlined),
            iconColor: kPrimaryColor,
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
          ListTile(
            title: Text('Descuentos', style: estilo),
            subtitle: Text('Discounts', style: estiloSub),
            leading: const Icon(Icons.price_change_outlined),
            iconColor: kPrimaryColor,
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {},
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
          ListTile(
            title: Text('Mi cuenta', style: estilo),
            subtitle: Text('My account', style: estiloSub),
            leading: const Icon(Icons.account_circle_outlined),
            iconColor: kPrimaryColor,
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {
              //opcional cerrar drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfileScreen.routeName);
              //Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
              //Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.routeName, (route) => false);
            },
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
          ListTile(
            title: Text('Mis favoritos', style: estilo),
            subtitle: Text('My favorites', style: estiloSub),
            leading: const Icon(Icons.favorite_border_outlined),
            iconColor: kPrimaryColor,
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EsqueletoPage(
                          catProductos: "Celulares - Smartwatch",
                        )),
              );
            },
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
          ListTile(
            title: Text('Mi carrito', style: estilo),
            subtitle: Text('My cart', style: estiloSub),
            leading: const Icon(Icons.shopping_cart_outlined),
            iconColor: kPrimaryColor,
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
          ListTile(
            title: Text('Ajustes', style: estilo),
            subtitle: Text('Settings', style: estiloSub),
            leading: const Icon(Icons.settings),
            iconColor: kPrimaryColor,
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AjustesScreen.routeName);
            },
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
          ListTile(
            title: Text('Centro de ayuda', style: estilo),
            subtitle: Text('Help center', style: estiloSub),
            leading: const Icon(Icons.help_outline),
            iconColor: kPrimaryColor,
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {},
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
          ListTile(
            title: Text('Cerrar sesión', style: estilo),
            subtitle: Text('Log out', style: estiloSub),
            leading: const Icon(Icons.logout),
            iconColor: kPrimaryColor,
            tileColor: kPrimaryColor.withOpacity(0.1),
            trailing: const Icon(Icons.navigate_next, size: 30),
            onTap: () {
              signOut();
              _changeTrueLogueado();
            },
          ),
          const Divider(
            color: kSecondaryColor,
            height: 0,
          ),
        ],
      ),
    );
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
      child: Image.asset('assets/logo/Wolf_logo3.png'),
      decoration: BoxDecoration(color: kPrimaryColor),
    );
  }
}
