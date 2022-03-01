import 'package:flutter/material.dart';
import 'package:wolf_tienda_online/constants.dart';

import 'components/body.dart';

class EsqueletoPage extends StatelessWidget {
  static String routeName = "/esqueleto";
  final String? catProductos;

  const EsqueletoPage({Key? key, this.catProductos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String appbarTitulo;
    String categoria() {
      switch (catProductos) {
        case "Celulares - Smartwatch":
          appbarTitulo = "Celulares - Smartwatch";
          break;
        default:
          appbarTitulo = "Categoria";
          break;
      }
      debugPrint(appbarTitulo);
      return appbarTitulo;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          backgroundColor: kPrimaryColor.withOpacity(0.5),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          title: Text(
            categoria(),
            style: const TextStyle(),
          ),
        ),
        body: Body(
          appbarTitulo: appbarTitulo,
        ));
  }

  /* eleccion(String tc, String nc) {
    if (tc.isNotEmpty && tc != "Busqueda") {
      return esqueleto(tc);
    } else if (nc.isNotEmpty) {
      return widgetBusqueda(nc);
    }
  } */

  /*  Future<QuerySnapshot<Object?>>? busqueda(String cm) async {
    
    QuerySnapshot document = await db
        .collection("Salado")
        .where("Coincidencias", arrayContains: cm).get();

    if (document.size == 0) {
      QuerySnapshot docu = await db
          .collection("Dulce")
          .where("Coincidencias", arrayContains: cm)
          .get();
      return docu;
    } else 
    return document;
  } */

  /* FutureBuilder<QuerySnapshot<Object?>> widgetBusqueda(String cm) {
    return FutureBuilder<QuerySnapshot>(
      future: busqueda(cm),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          );
        if (snapshot.data!.docs.length == 0) {
          return _busquedaPorTexto(cm);
        }else{
           return _construirEsqueleto(snapshot);
        }
      },
    );
  } */

  /* Widget _construirEsqueleto(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return Container(
      child: GridView.builder(
          itemCount: snapshot.data!.docs.length,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 190 / 190,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            return Container(
              height: 190,
              width: 190,
              child: _tarjeta(context, producto = Product.fromMap(document)),
            );
          }),
    );
  } */

  /* Widget _busquedaPorTexto(String cm){
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05, child: Container(color: Colors.white,),),
            Icon(Icons.warning_amber, color: Colors.red, size: 125,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10, child: Container(color: Colors.white,),),
            Text("No existen resultados para ", 
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.grey), 
              textAlign: TextAlign.center,
            ),
            Text('"$cm"', 
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.blue, fontStyle: FontStyle.italic), 
                  textAlign: TextAlign.center,
                ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10, child: Container(color: Colors.white,),),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.20,
                child: FittedBox(child: Text("VOLVER", textAlign: TextAlign.center,))),
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.orange),
                ),
                primary: Colors.orange,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10, child: Container(color: Colors.white,),),
          ],
        ),
      );
    } */

}
