class Product {
  String? idProducto;
  String? nombre;
  String? descripcion;
  double? precio;
  String? color;
  String? imagen;
  double? valoracion;
  bool? esPopular;
  String? categoria;

  Product(
      {this.idProducto,
      this.nombre,
      this.descripcion,
      this.precio,
      this.color,
      this.imagen,
      this.valoracion,
      this.esPopular,
      this.categoria});

  //receiving data from server
  factory Product.fromMap(map) {
    return Product(
      idProducto: map['idProducto'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      precio: map['precio'],
      color: map['color'],
      imagen: map['imagen'],
      valoracion: map['valoracion'],
      esPopular: map['esPopular'],
      categoria: map['categoria'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'idProducto': idProducto,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'color': color,
      'imagen': imagen,
      'valoracion': valoracion,
      'esPopular': esPopular,
      'categoria': categoria,
    };
  }
}
