import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wolf_tienda_online/components/default_button.dart';
import 'package:wolf_tienda_online/components/form_error.dart';
import 'package:wolf_tienda_online/models/user_model.dart';
import 'package:wolf_tienda_online/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class RegistrarseForm extends StatefulWidget {
  const RegistrarseForm({Key? key}) : super(key: key);

  @override
  _RegistrarseFormState createState() => _RegistrarseFormState();
}

class _RegistrarseFormState extends State<RegistrarseForm> {
  final _formKey = GlobalKey<FormState>();

  String? password;

  late bool _passwordVisible;
  late bool _passwordVisible2;

  bool remember = false;
  final List<String?> errors = [];

  final _auth = FirebaseAuth.instance;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController contrasenaEditingController = TextEditingController();
  TextEditingController reContrasenaEditingController = TextEditingController();
  TextEditingController nombreEditingController = TextEditingController();
  TextEditingController apellidoEditingController = TextEditingController();
  TextEditingController telefonoEditingController = TextEditingController();
  TextEditingController calleDirEditingController = TextEditingController();
  TextEditingController numeroDirEditingController = TextEditingController();
  TextEditingController codigoPostalEditingController = TextEditingController();
  TextEditingController ciudadEditingController = TextEditingController();
  TextEditingController dniEditingController = TextEditingController();

  //dropdown
  String? _chosenValue;

  late FocusNode focusMail,
      focusCont,
      focusReCont,
      focusNombre,
      focusApellido,
      focusDNI,
      focusTelefono,
      focusCalle,
      focusNumero,
      focusCodPos,
      focusCiudad;

  @override
  void initState() {
    focusMail = FocusNode();
    focusCont = FocusNode();
    focusReCont = FocusNode();
    focusNombre = FocusNode();
    focusApellido = FocusNode();
    focusDNI = FocusNode();
    focusTelefono = FocusNode();
    focusCalle = FocusNode();
    focusNumero = FocusNode();
    focusCodPos = FocusNode();
    focusCiudad = FocusNode();

    _passwordVisible = false;
    _passwordVisible2 = false;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    //focusNode
    focusMail.dispose();
    focusCont.dispose();
    focusReCont.dispose();
    focusNombre.dispose();
    focusApellido.dispose();
    focusDNI.dispose();
    focusTelefono.dispose();
    focusCalle.dispose();
    focusNumero.dispose();
    focusCodPos.dispose();
    focusCiudad.dispose();
    //controllers
    emailEditingController.dispose();
    contrasenaEditingController.dispose();
    reContrasenaEditingController.dispose();
    nombreEditingController.dispose();
    apellidoEditingController.dispose();
    telefonoEditingController.dispose();
    calleDirEditingController.dispose();
    numeroDirEditingController.dispose();
    codigoPostalEditingController.dispose();
    ciudadEditingController.dispose();
    dniEditingController.dispose();
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
          separador("Datos de ingreso"),
          SizedBox(height: getProportionateScreenHeight(25)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(35)),
          separador("Datos personales"),
          SizedBox(height: getProportionateScreenHeight(25)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDniFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(35)),
          separador("Dirección"),
          SizedBox(height: getProportionateScreenHeight(25)),
          buildAddressStreetFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPostalCodeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCityFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Stack(children: [
            Column(
              children: [
                Container(
                  height: getProportionateScreenHeight(10),
                ),
                buildProvinceDropDown(),
              ],
            ),
            Positioned(
              left: 39,
              top: -2,
              child: Container(
                color: Colors.white,
                child: const Text(
                  " Provincia ",
                  style: TextStyle(color: kSecondaryColor, fontSize: 12),
                ),
              ),
            )
          ]),
          //Implementar IMAGEN PERFIL
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "CREAR CUENTA",
            press: () {
              if (_chosenValue != null) {
                signUp(emailEditingController.text,
                    contrasenaEditingController.text);
              } else {
                Fluttertoast.showToast(msg: "Selecciona una provincia");
              }

              //Navigator.pushNamed(context, OtpScreen.routeName);

              /* if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                Navigator.pushNamed(context, OtpScreen.routeName);
              } */
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        focusNode: focusMail,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        controller: emailEditingController,
        onSaved: (newValue) {
          emailEditingController.text = newValue!;
        },
        onEditingComplete: () => FocusScope.of(context).requestFocus(focusCont),
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
            return "Ingresa tu email.";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            //addError(error: kInvalidEmailError);
            return "Ingresa un email válido. Ej: ***@***.com";
          }
          return null;
        },
        decoration: _decorationTextField("E-Mail", "Ingresa tu e-mail...",
            const Icon(Icons.email_outlined)));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        focusNode: focusCont,
        textInputAction: TextInputAction.next,
        obscureText: !_passwordVisible2,
        controller: contrasenaEditingController,
        onSaved: (newValue) {
          contrasenaEditingController.text = newValue!;
        },
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusReCont),
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          password = value;
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
            "Contraseña", "Ingresa tu contraseña", _iconButton(2)));
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
        focusNode: focusReCont,
        textInputAction: TextInputAction.next,
        obscureText: !_passwordVisible,
        controller: reContrasenaEditingController,
        onSaved: (newValue) {
          reContrasenaEditingController.text = newValue!;
        },
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusNombre),
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.isNotEmpty &&
              password == reContrasenaEditingController.text) {
            removeError(error: kMatchPassError);
          }
          //reContrasenaEditingController.text = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kPassNullError);
            return "Vuelve a ingresa tu contraseña.";
          } else if ((password != value)) {
            //addError(error: kMatchPassError);
            return "Las contraseñas no coinciden.";
          }
          return null;
        },
        decoration: _decorationTextField(
            "Confirmar contraseña", "Reingresa tu contraseña", _iconButton(1)));
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
        focusNode: focusNombre,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        controller: nombreEditingController,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusApellido),
        onSaved: (newValue) {
          nombreEditingController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kNamelNullError);
            return "Debes ingresar tu nombre.";
          }
          return null;
        },
        decoration: _decorationTextField("Nombre", "Ingresa tu nombre",
            const Icon(Icons.account_circle_outlined)));
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
        focusNode: focusApellido,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        onEditingComplete: () => FocusScope.of(context).requestFocus(focusDNI),
        onSaved: (newValue) {
          apellidoEditingController.text = newValue!;
        },
        controller: apellidoEditingController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kLastNamelNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kLastNamelNullError);
            return "Debes ingresar tu apellido.";
          }
          return null;
        },
        decoration: _decorationTextField("Apellido", "Ingresa tu apellido",
            const Icon(Icons.account_circle_outlined)));
  }

  TextFormField buildDniFormField() {
    return TextFormField(
        focusNode: focusDNI,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: dniEditingController,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusTelefono),
        onSaved: (newValue) {
          dniEditingController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kDNINullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kDNINullError);
            return "Debes ingresar tu DNI.";
          } else if (value.length > 8 || value.length < 7) {
            //addError(error: kShortPassError);
            return "Debes ingresar un DNI válido.";
          }
          return null;
        },
        decoration: _decorationTextField(
            "DNI", "Ingresa tu DNI", const Icon(Icons.credit_card_outlined)));
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        focusNode: focusTelefono,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        controller: telefonoEditingController,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusCalle),
        onSaved: (newValue) {
          telefonoEditingController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kPhoneNumberNullError);
            return "Ingresa tu número de teléfono.";
          }
          return null;
        },
        decoration: _decorationTextField("Teléfono", "Ingresa tu teléfono",
            const Icon(Icons.phone_android_outlined),
            helper: "Ingresar número sin '0' ni '15'."));
  }

  TextFormField buildAddressStreetFormField() {
    return TextFormField(
        focusNode: focusCalle,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.streetAddress,
        textCapitalization: TextCapitalization.sentences,
        controller: calleDirEditingController,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusNumero),
        onSaved: (newValue) {
          calleDirEditingController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kAddressNullError);
            return "Ingresa la calle.";
          }
          return null;
        },
        decoration: _decorationTextField("Calle - Dirección",
            "Ingresa la calle", const Icon(Icons.location_city_rounded)));
  }

  TextFormField buildAddressNumberFormField() {
    return TextFormField(
        focusNode: focusNumero,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: numeroDirEditingController,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusCodPos),
        onSaved: (newValue) {
          numeroDirEditingController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kAddressNullError);
            return "Ingresa el número.";
          }
          return null;
        },
        decoration: _decorationTextField("Número - Dirección",
            "Ingresa la numeración", const Icon(Icons.location_city_rounded)));
  }

  TextFormField buildPostalCodeFormField() {
    return TextFormField(
        focusNode: focusCodPos,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: codigoPostalEditingController,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(focusCiudad),
        onSaved: (newValue) {
          codigoPostalEditingController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kCodPosNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kCodPosNullError);
            return "Ingresa el código postal.";
          } else if (value.length != 4) {
            //addError(error: kShortPassError);
            return "Debes ingresar un código postal válido.";
          }
          return null;
        },
        decoration: _decorationTextField(
            "Código postal",
            "Ingresa el código postal",
            const Icon(Icons.location_on_outlined)));
  }

  TextFormField buildCityFormField() {
    return TextFormField(
        focusNode: focusCiudad,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        controller: ciudadEditingController,
        onSaved: (newValue) {
          ciudadEditingController.text = newValue!;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kCityNullError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            //addError(error: kCityNullError);
            return "Ingresa tu ciudad.";
          }
          return null;
        },
        decoration: _decorationTextField("Ciudad", "Ingresa tu ciudad",
            const Icon(Icons.location_on_outlined)));
  }

  Widget buildProvinceDropDown() {
    return Container(
      padding: const EdgeInsets.only(top: 7, bottom: 7, right: 12, left: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: kPrimaryColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<String>(
        underline: Container(
            decoration:
                const BoxDecoration(border: Border(bottom: BorderSide.none))),
        isExpanded: true,
        icon: Icon(Icons.location_on_outlined, color: Colors.grey[600]),
        menuMaxHeight: 300,
        borderRadius: BorderRadius.circular(20),
        value: _chosenValue,
        items: <String>[
          "      Buenos Aires",
          "      Capital Federal",
          "      Catamarca",
          "      Chaco",
          "      Chubut",
          "      Córdoba",
          "      Corrientes",
          "      Entre Ríos",
          "      Formosa",
          "      Jujuy",
          "      La Pampa",
          "      La Rioja",
          "      Mendoza",
          "      Misiones",
          "      Neuquén",
          "      Rio Negro",
          "      Salta",
          "      San Juan",
          "      San Luis",
          "      Santa Cruz",
          "      Santa Fe",
          "      Santiago del Estero",
          "      Tierra del fuego",
          "      Tucumán"
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value.substring(6),
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Container(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Selecciona una provincia",
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "Muli"),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _chosenValue = value;
          });
        },
      ),
    );
  }

  InputDecoration _decorationTextField(
      String labelText, String hintText, Widget? sufixIcon,
      {String? helper}) {
    return InputDecoration(
        helperText: helper,
        labelText: labelText,
        labelStyle: const TextStyle(color: kSecondaryColor),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: sufixIcon,
        suffixIconColor: kSecondaryColor,
        /* filled: false,
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

  Widget _iconButton(int n) {
    bool b = false;
    if (n == 1) {
      b = _passwordVisible;
    } else if (n == 2) {
      b = _passwordVisible2;
    }
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      /* icon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"), */
      icon: Icon(
        b ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        //color: kSecondaryColor,
      ),
      onPressed: () {
        if (n == 1) {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        } else if (n == 2) {
          setState(() {
            _passwordVisible2 = !_passwordVisible2;
          });
        }
      },
    );
  }

  Widget separador(String titulo) {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        thickness: 1.0,
        color: Colors.indigo[700],
      )),
      Text(
        "  $titulo  ",
        style: TextStyle(color: Colors.indigo[700], fontSize: 15),
      ),
      Expanded(
          child: Divider(
        thickness: 1.0,
        color: Colors.indigo[700],
      )),
    ]);
  }

  //Crear cuenta
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailsToFirestore();
        Navigator.pushNamed(context, HomeScreen.routeName);
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.nombre = nombreEditingController.text;
    userModel.apellido = apellidoEditingController.text;
    userModel.telefono = telefonoEditingController.text;
    userModel.calleDir = calleDirEditingController.text;
    userModel.numeroDir = numeroDirEditingController.text;
    userModel.codPostal = codigoPostalEditingController.text;
    userModel.ciudad = ciudadEditingController.text;
    userModel.dni = dniEditingController.text;
    userModel.provincia = _chosenValue;
    //Ver aqui
    userModel.imagPerfil = "";

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Cuenta creada satisfactoriamente :)");

    /* Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false); */
  }
}
