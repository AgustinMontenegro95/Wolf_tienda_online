import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolf_tienda_online/constants.dart';
import 'package:wolf_tienda_online/screens/home/home_screen.dart';
import 'package:wolf_tienda_online/screens/iniciar_sesion/iniciarSesion_screen.dart';
import 'package:wolf_tienda_online/size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //late SharedPreferences logindata;
  late bool? newuser;

  @override
  void initState() {
    check_if_already_login();
    super.initState();
  }

  void check_if_already_login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /* newuser = (prefs.getBool('logueo')! ? true : false);
    print("$newuser -------------------- prefs ${prefs.getBool('logueo')}"); */
    newuser = prefs.getBool('logueo');
    if (newuser == true) {
      debugPrint(
          "Chequeando si esta logueado------------------------------------------------- ----- newuser $newuser");
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  /* void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    /* newuser = (logindata.getBool('login') ?? true);
    print(newuser); */
    if (logindata.getBool('login') == true) {
      print("Yendo a HOMESCREEN");
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  } */

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: PageView(
      scrollDirection: Axis.vertical,
      //physics: BouncingScrollPhysics(),
      children: [
        _pagina1(),
        //_pagina2(),
        //_pagina3(),
        _paginaInicioSesion(),
      ],
    ));
  }

  Widget _pagina1() {
    //stack superponer widget
    return Stack(
      children: [
        _imagenFondo("assets/logo/Wolf_logo4.png", BoxFit.none),
        Positioned(bottom: 10, right: 145, child: _iconNext(Colors.white)),
      ],
    );
  }

  Widget _pagina2() {
    return Stack(
      children: [
        _colorFondo(),
        _imagenFondo("assets/splash/splash.png", BoxFit.cover),
        Positioned(bottom: 10, right: 145, child: _iconNext(kPrimaryColor)),
      ],
    );
  }

  Widget _pagina3() {
    return Stack(
      children: [
        _colorFondo(),
        _imagenFondo("assets/splash/splash_limpio.png", BoxFit.cover),
        Positioned(bottom: 10, right: 145, child: _iconNext(kPrimaryColor)),
      ],
    );
  }

  Widget _paginaInicioSesion() {
    return const IniciarSesionScreen();
  }

  Widget _iconNext(Color color) {
    return Icon(
      Icons.keyboard_arrow_down,
      size: 70.0,
      color: color,
    );
  }

  Widget _imagenFondo(String imagen, BoxFit fit) {
    return Container(
      color: kPrimaryColor,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(imagen),
        fit: fit,
      ),
    );
  }

  Widget _textos() {
    const estiloTexto = TextStyle(color: Colors.white, fontSize: 50.0);

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Text("11º", style: estiloTexto),
          const Text("Miercoles", style: estiloTexto),
          Expanded(child: Container()),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 70.0,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: kSecondaryColor.withOpacity(0.8),
    );
  }

  Widget _boton() {
    return Center(
      child: SizedBox(
        height: 50,
        width: 120,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                primary: Colors.blue),
            onPressed: () {},
            child: const Text("Bienvenido")),
      ),
    );
  }
}
