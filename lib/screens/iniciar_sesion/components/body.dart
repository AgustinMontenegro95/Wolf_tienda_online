import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wolf_tienda_online/components/fondo_colorfiltered.dart';
import 'package:wolf_tienda_online/components/invitado_button.dart';
import 'package:wolf_tienda_online/components/redSocial_card.dart';
import 'package:wolf_tienda_online/components/sinCuenta_card.dart';
import 'package:wolf_tienda_online/constants.dart';
import 'package:wolf_tienda_online/models/user_model.dart';
import 'package:wolf_tienda_online/screens/home/home_screen.dart';
import '../../../size_config.dart';
import 'iniciarSesion_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final bool _isLoggedIn = false;
  bool loading = false;

  final _auth = FirebaseAuth.instance;

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
                  Text(
                    "IDENTIFICATE",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenWidth(40),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    "Inicia sesión con tu correo electrónico y contraseña o con las redes sociales sugeridas",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: getProportionateScreenWidth(15)),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  const IniciarSesionScreenForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  redesSociales(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  const SinCuentaText(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Divider(
                    color: kPrimaryColor,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  const InvitadoButton(),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget redesSociales() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RedSocialCard(
          icon: "assets/icons/google-icon.svg",
          press: () {
            _logInWithGoogle();
          },
        ),
        RedSocialCard(
          icon: "assets/icons/facebook-2.svg",
          press: () {
            //initiateFacebookLogin();
            _logInWithFacebook();
          },
        ),
        RedSocialCard(
          icon: "assets/icons/twitter.svg",
          press: () {},
        ),
      ],
    );
  }

  //codigo programming addict
  void _logInWithFacebook() async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    setState(() {
      loading = true;
    });

    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      userModel.email = userData['email'];
      userModel.uid = user!.uid;
      userModel.nombre = userData['name'];
      userModel.apellido = "";
      userModel.telefono = "";
      userModel.calleDir = "";
      userModel.numeroDir = "";
      userModel.codPostal = "";
      userModel.ciudad = "";
      userModel.dni = "";
      userModel.provincia = "";
      userModel.imagPerfil = userData['picture']['data']['url'];

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());

      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      String contenido = "";
      switch (e.code) {
        case 'account-exists-with-different-credential':
          contenido =
              'Esta cuenta existe con un proveedor de inicio de sesión diferente';
          break;
        case 'invalid-credential':
          contenido = 'Ha ocurrido un error desconocido';
          break;
        case 'operation-not-allowed':
          contenido = 'Esta operación no esta permitida';
          break;
        case 'user-disabled':
          contenido =
              'El usuario con el que intentó iniciar sesión está deshabilitado';
          break;
        case 'user-not-found':
          contenido =
              'El usuario con el que intentó iniciar sesión no fue encontrado';
          break;
      }

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Error al iniciar sesión con Facebook"),
                content: Text(contenido),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"))
                ],
              ));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  //codigo programming addict
  void _logInWithGoogle() async {
    setState(() {
      loading = true;
    });

    final googleSingIn = GoogleSignIn(scopes: ['email']);

    try {
      final googleSignInAccount = await googleSingIn.signIn();
      if (googleSignInAccount == null) {
        setState(() {
          loading = false;
        });
        return;
      }

      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance.collection("users").add({
        'email': googleSignInAccount.email,
        'imageUrl': googleSignInAccount.photoUrl,
        'name': googleSignInAccount.displayName,
      });

      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      String contenido = "";
      switch (e.code) {
        case 'account-exists-with-different-credential':
          contenido =
              'Esta cuenta existe con un proveedor de inicio de sesión diferente';
          break;
        case 'invalid-credential':
          contenido = 'Ha ocurrido un error desconocido';
          break;
        case 'operation-not-allowed':
          contenido = 'Esta operación no esta permitida';
          break;
        case 'user-disabled':
          contenido =
              'El usuario con el que intentó iniciar sesión está deshabilitado';
          break;
        case 'user-not-found':
          contenido =
              'El usuario con el que intentó iniciar sesión no fue encontrado';
          break;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Error al iniciar sesión con Google"),
                content: Text(contenido),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"))
                ],
              ));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Error al iniciar sesión con Google"),
                content: const Text("Ocurrió un error desconocido"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"))
                ],
              ));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
