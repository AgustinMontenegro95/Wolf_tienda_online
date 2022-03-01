import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/product_model.dart';

class Body extends StatelessWidget {
  final String? appbarTitulo;

  const Body({Key? key, this.appbarTitulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Product producto;
    final products = FirebaseFirestore.instance;

    bool elecVista = false;

    return FutureBuilder<QuerySnapshot>(
      future: products
          .collection("products")
          .where("categoria", isEqualTo: appbarTitulo)
          .get(),
      //future: products.collection("products").get(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: kSecondaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          );
        }

        if (elecVista == true) {
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 100 / 100,
                crossAxisCount: 1,
              ),
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                return Container(
                  child:
                      _tarjeta1(context, producto = Product.fromMap(document)),
                );
              });
        } else if (elecVista == false) {
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 100 / 130,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                return Container(
                  child:
                      _tarjeta2(context, producto = Product.fromMap(document)),
                );
              });
        }
        return Container();
      },
    );
  }

  Card _tarjeta1(BuildContext context, Product producto) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(5),
      elevation: 10,
      child: InkWell(
          onTap: () {
            /* Navigator.push(context,
                MaterialPageRoute(builder: (context) => Detail(comida))); */
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                  /* height: MediaQuery.of(context).size.height * 0.165,
                  width: MediaQuery.of(context).size.width, */
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/carga_image.gif'),
                    image: NetworkImage(producto.imagen.toString()),
                    fadeInDuration: const Duration(milliseconds: 200),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -15,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(right: 15, top: 5),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(30)),
                        //border: Border.all(color: Colors.black54),
                        color: Colors.black54),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: -3,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.16,
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(
                      child: Column(
                        /* crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, */
                        children: [
                          Text(
                            producto.nombre.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "\$ ${producto.precio.toString()}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (producto.esPopular!)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2.5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color:
                                              kSecondaryColor.withOpacity(0.5)),
                                      color: kSecondaryColor.withOpacity(0.4)),
                                  child: const Text(
                                    "MÁS VENDIDO",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black54),
                                    color: Colors.white.withOpacity(0.3)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(producto.valoracion.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Card _tarjeta2(BuildContext context, Product producto) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(5),
      elevation: 10,
      child: InkWell(
          onTap: () {
            /* Navigator.push(context,
                MaterialPageRoute(builder: (context) => Detail(comida))); */
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                  /* height: MediaQuery.of(context).size.height * 0.165,
                  width: MediaQuery.of(context).size.width, */
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/carga_image.gif'),
                    image: NetworkImage(producto.imagen.toString()),
                    fadeInDuration: const Duration(milliseconds: 200),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -15,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, left: 1),
                    padding: const EdgeInsets.only(right: 20, top: 5),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(25)),
                        //border: Border.all(color: Colors.black54),
                        color: Colors.black54),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: -5,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          producto.nombre.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "\$ ${producto.precio.toString()}",
                          style:
                              const TextStyle(color: Colors.white, fontSize: 8),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (producto.esPopular!)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color:
                                            kSecondaryColor.withOpacity(0.5)),
                                    color: kSecondaryColor.withOpacity(0.4)),
                                child: const Text(
                                  "MÁS VENDIDO",
                                  style: TextStyle(
                                      fontSize: 6, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            Container(
                              //margin: EdgeInsets.only(top: 5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black54),
                                  color: Colors.white.withOpacity(0.3)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(producto.valoracion.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 6)),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 7,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
