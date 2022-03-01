import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolf_tienda_online/components/form_error.dart';
import 'package:wolf_tienda_online/screens/home/home_screen.dart';
import 'package:wolf_tienda_online/screens/recuperar_contrasena/recuperarContrasena_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class IniciarSesionScreenForm extends StatefulWidget {
  const IniciarSesionScreenForm({Key? key}) : super(key: key);

  @override
  _IniciarSesionScreenFormState createState() =>
      _IniciarSesionScreenFormState();
}

class _IniciarSesionScreenFormState extends State<IniciarSesionScreenForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
  late bool _passwordVisible;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  //firebase
  final _auth = FirebaseAuth.instance;

  late bool _logueado;

  bool _initLogueado = true;

  late FocusNode focusEmail;
  late FocusNode focusCont;

  @override
  void initState() {
    focusEmail = FocusNode();
    focusCont = FocusNode();
    _passwordVisible = false;
    super.initState();
    if (_initLogueado == true) {
      _initLogueado = false;
      _loadLogueado();
    }
    //initial();
  }

  //Cargando el valor del logueo en el inicio
  _loadLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('logueo', false);
      debugPrint(
          "Cargando el valor del logueo en el inicio------------------------------------------------------false ----- prefs ${prefs.getBool('logueo')}");
    });
  }

  /* //Cargando el valor del logueo en el inicio
  _loadLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _logueado = (prefs.getBool('logueo')! ? true : false);
      print(
          "Cargando el valor del logueo en el inicio------------------------------------------------------false ----- logueado $_logueado");
    });
  } */

  //Cambiando el booleano después del clic en Iniciar Sesion
  _changeFalseLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('logueo', true);
      debugPrint(
          "Cambiando el booleano después del clic en Iniciar Sesion------------------------------------------------------true----- prefs ${prefs.getBool('logueo')}");
    });
  }

  /* void setLoginData() async {
    logindata = await SharedPreferences.getInstance();
    print("Seteo Login FALSE en INICIARSESION ---------Seteo inicial");
    logindata.setBool('login', false);
  } */

  /* void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  } */

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    focusEmail.dispose();
    focusCont.dispose();
    emailController.dispose();
    contrasenaController.dispose();
    super.dispose();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          recordarmeOlvidaste(context),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(25)),
          iniciarSesionButton(),
        ],
      ),
    );
  }

  Widget iniciarSesionButton() {
    return DefaultButton(
      text: "INICIAR SESIÓN",
      press: () {
        signIn(emailController.text, contrasenaController.text);
        //_changeFalseLogueado();

        /* if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // if all are valid then go to success screen
              KeyboardUtil.hideKeyboard(context);
              Navigator.pushNamed(context, InicioExitosoScreen.routeName);
            } */
      },
    );
  }

  Widget recordarmeOlvidaste(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 25,
          height: 35,
          child: Checkbox(
            value: remember,
            activeColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                remember = value;
              });
            },
          ),
        ),
        const Text(
          "Recordarme",
          style: TextStyle(fontSize: 15),
        ),
        Expanded(child: Container()),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RecuperarContScreen.routeName),
          child: const Text(
            "¿Olvidaste tu contraseña?",
            style:
                TextStyle(decoration: TextDecoration.underline, fontSize: 15),
          ),
        ),
      ],
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        focusNode: focusEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: emailController,
        onEditingComplete: () => FocusScope.of(context).requestFocus(focusCont),
        onSaved: (newValue) {
          emailController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kEmailNullError);
            return "Ingresa tu E-Mail.";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "Ingresa un email válido.\n\t\t\tEj: usuario@proveedor.com";
          }
          return null;
        },
        decoration: _decorationTextField(
            "E-mail", "Ingresa tu Email", const Icon(Icons.email_outlined)));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        focusNode: focusCont,
        obscureText: !_passwordVisible,
        controller: contrasenaController,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) {
          contrasenaController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kPassNullError);
            return "Ingresa tu contraseña.";
          } else if (value.length < 8) {
            //addError(error: kShortPassError);
            return "La contraseña es demasiado corta.";
          }
          return null;
        },
        decoration: _decorationTextField(
            "Contraseña", "Ingresa tu contraseña", _iconButton()));
  }

  Widget _iconButton() {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      /* icon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"), */
      icon: Icon(
        _passwordVisible
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        //color: kSecondaryColor,
      ),
      onPressed: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
      //alignment: Alignment.centerLeft,
    );
  }

  InputDecoration _decorationTextField(
      String labelText, String hintText, Widget? sufixIcon) {
    return InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: kSecondaryColor),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: sufixIcon,
        suffixIconColor: kSecondaryColor,
        /* filled: true,
        fillColor: Color(0xFFF2F2F2), */
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(width: 1, color: kSecondaryColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(width: 1, color: Colors.amber),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(width: 0.5, color: kPrimaryColor),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width: 1, color: Colors.amber)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width: 1, color: Colors.orange)));
  }

  //login function
  void signIn(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        await _auth
                .signInWithEmailAndPassword(email: email, password: password)
                .then((uid) => {
                      Fluttertoast.showToast(msg: 'Acceso exitoso'),
                      //Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false)
                    })
            /* .catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        }) */
            ;
      }
      if (remember!) {
        _changeFalseLogueado();
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg:
              "Email y/o contraseña incorrecta, vuelve a intentar." /* e.toString() */); // Only catches an exception of type `Exception`.
    } catch (e) {
      Fluttertoast.showToast(
          msg:
              "error 2" /* e.toString() */); // Catches all types of `Exception` and `Error`.
    }

    /* if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Acceso exitoso'),
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    } */
  }
}
