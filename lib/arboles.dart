import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'Compet.dart';
import 'Sorts.dart';
import 'asignacion.dart';
import 'ayudaarbol.dart';
import 'home.dart';
import 'arbol.dart';
import 'arbolPainter.dart';
import 'jh.dart';
import 'kruskal.dart';
import 'modelo_arbol.dart';
import 'nw.dart';
import 'dij.dart';

int peso = 0;
late List<int> preorder = [];
late List<int> postorder = [];
late List<int> comparar = [];
late List<int> comparar2 = [];
late List<int> vector = [];
bool exact = false;

class Home6 extends StatefulWidget {
  const Home6({Key? key}) : super(key: key);

  @override
  State<Home6> createState() => _Home7State();
}

class _Home7State extends State<Home6> {
  Arbol objArbol = new Arbol();
  final _textFieldController = TextEditingController();
  late int _dato;

  late ArbolPainter _painter;
  @override
  void initState() {
    super.initState();
    _painter = new ArbolPainter(objArbol);
  }

  final nuevoNodo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: HexColor("#F2E7D5"),
        body: Stack(
          children: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    List<String> opciones = [
                      'Jhonson',
                      'Asignacion',
                      'Northwest',
                      'Sorts',
                      'Arboles',
                      'Compet',
                      'Dijkstra',
                      'Kruskal',
                      'Reset',
                    ];
                    return AlertDialog(
                      title: Text('Opciones de Algoritmos:'),
                      content: SizedBox(
                        height: 200,
                        width: 200, // ajusta la altura según tus necesidades
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: opciones.length,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              onPressed: () {
                                // Aquí puedes manejar la selección de la opción
                                Navigator.pop(context);
                                switch (index) {
                                  case 0:
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home2()));
                                    });
                                    break;
                                  case 1:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home4()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  case 2:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home3()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  case 3:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home5()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  case 4:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home6()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  case 5:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home7()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  case 6:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home8()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  case 7:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home9()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;

                                  case 8:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                }
                              },
                              child: Text(
                                opciones[index],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        HexColor("#F2E7D5")),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: "Valor",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  if (peso != null) {
                    peso = value.isEmpty ? 0 : int.parse(value);
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150),
              child: CustomPaint(
                painter: _painter,
                size: Size(MediaQuery.of(context).size.width, 250),
              ),
            ),
            if (vector.length > 0) In(),
            if (preorder.length > 0) Vector(),
            if (postorder.length > 0) Order(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    tooltip: 'Agregar dato',
                    color: Colors.green.shade300,
                    onPressed: () {
                      setState(() {
                        _dato = peso;
                        preorder.add(_dato);
                        comparar2.add(_dato);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    tooltip: 'Agregar dato postorder',
                    color: Colors.green.shade300,
                    onPressed: () {
                      setState(() {
                        _dato = peso;
                        postorder.add(_dato);
                        comparar.add(_dato);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    tooltip: 'Agregar dato vector',
                    color: Colors.green.shade300,
                    onPressed: () {
                      setState(() {
                        _dato = peso;
                        objArbol.insertarNodo(_dato);
                        vector.add(_dato);
                        // Actualiza los recorridos Preorder, Inorder y Postorder aquí.
                        // Debes tener definidas las funciones correspondientes para ello en la clase Arbol.
                        preorder = objArbol.preorderTraversal();
                        postorder = objArbol.postorderTraversal();
                        // Inorder ya está siendo actualizado con el método insertarNodo()
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.build_circle),
                    tooltip: 'Crear arbol',
                    color: Colors.green.shade300,
                    onPressed: () {
                      setState(() {
                        objArbol.resetArbol();
                        comparar.sort();
                        comparar2.sort();

                        for (int i = 0; i < preorder.length; i++) {
                          if (comparar2[i] == comparar[i]) {
                            exact = true;
                          } else {
                            exact = false;
                            break;
                          }
                        }
                        print(exact);
                        if (exact) {
                          for (int i = 0; i < preorder.length; i++) {
                            objArbol.insertarNodo(preorder[i]);
                          }
                        } else {
                          print("Entro");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Alerta(context),
                          );
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.help),
                    tooltip: 'Ayuda',
                    color: Colors.green.shade300,
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AyudaArbol()));
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    tooltip: 'Eliminar',
                    color: Colors.green.shade300,
                    onPressed: () {
                      setState(() {
                        comparar.clear();
                        comparar2.clear();
                        objArbol.resetArbol();
                        preorder.clear();
                        postorder.clear();
                        vector.clear();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Vector() {
  return Container(
    margin: EdgeInsets.only(top: 600),
    child: Column(
      children: [
        Text("Pre Orden"),
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            for (var i = 0; i < preorder.length; i++)
              TableCell(
                child: Text(preorder[i].toString()),
              ),
          ])
        ]),
      ],
    ),
  );
}

Widget Order() {
  return Container(
    margin: EdgeInsets.only(top: 630),
    child: Column(
      children: [
        Text("Post Orden"),
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            for (var i = 0; i < postorder.length; i++)
              TableCell(
                child: Text(postorder[i].toString()),
              ),
          ])
        ]),
      ],
    ),
  );
}

Widget Alerta(BuildContext context) {
  return AlertDialog(
    title: Text('Alerta de error'),
    content: Text(
        'Los datos de Preorder y Postorder no coinciden. Intente de nuevo, por favor.'),
    actions: <Widget>[
      TextButton(
        child: Text('Aceptar'),
        onPressed: () {
          // Acción a realizar al hacer clic en el botón Aceptar
          Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
        },
      ),
    ],
  );
}

Widget Post() {
  return Container(
    margin: EdgeInsets.only(
        top:
            690), // Ajusta el margen superior para evitar la superposición con los otros widgets.
    child: Column(
      children: [
        Text("Postorder"),
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            for (var i = 0; i < postorder.length; i++)
              TableCell(
                child: Text(postorder[i].toString()),
              ),
          ])
        ]),
      ],
    ),
  );
}

Widget Pre() {
  return Container(
    margin: EdgeInsets.only(
        top:
            660), // Ajusta el margen superior para evitar la superposición con los otros widgets.
    child: Column(
      children: [
        Text("Preorder"),
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            for (var i = 0; i < preorder.length; i++)
              TableCell(
                child: Text(preorder[i].toString()),
              ),
          ])
        ]),
      ],
    ),
  );
}

Widget In() {
  return Container(
    margin: EdgeInsets.only(
        top:
            670), //incrementar el valor de top para hacer espacio para el widget de Post Orden
    child: Column(
      children: [
        Text("Inorder"),
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            for (var i = 0; i < vector.length; i++)
              TableCell(
                child: Text(vector[i].toString()),
              ),
          ])
        ]),
      ],
    ),
  );
}

Widget Peso() => TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Peso',
      ),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
    );

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
