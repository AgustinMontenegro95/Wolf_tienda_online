class UserModel {
  String? uid;
  String? email;
  String? nombre;
  String? apellido;
  String? telefono;
  String? calleDir;
  String? numeroDir;
  String? codPostal;
  String? ciudad;
  String? provincia;
  String? dni;
  String? imagPerfil;

  UserModel(
      {this.uid,
      this.email,
      this.nombre,
      this.apellido,
      this.telefono,
      this.calleDir,
      this.numeroDir,
      this.codPostal,
      this.ciudad,
      this.provincia,
      this.dni,
      this.imagPerfil});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      telefono: map['telefono'],
      calleDir: map['calleDir'],
      numeroDir: map['numeroDir'],
      codPostal: map['codPostal'],
      ciudad: map['ciudad'],
      provincia: map['provincia'],
      dni: map['dni'],
      imagPerfil: map['imagPerfil'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'calleDir': calleDir,
      'numeroDir': numeroDir,
      'codPostal': codPostal,
      'ciudad': ciudad,
      'provincia': provincia,
      'dni': dni,
      'imagPerfil': imagPerfil,
    };
  }
}
