import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gf12/asignacion.dart';
import 'package:gf12/ayudanw.dart';
import 'package:gf12/jh.dart';
import 'package:gf12/matriznw.dart';

import 'Compet.dart';
import 'Sorts.dart';
import 'arboles.dart';
import 'ayuda.dart';
import 'dij.dart';
import 'figuras.dart';
import 'home.dart';
import 'kruskal.dart';
import 'matriz.dart';
import 'modelos.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show MethodChannel;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';

const MethodChannel _channel = MethodChannel('com.example.gf12/saveFile');

int nodoSeleccionado1 = -1;
int nodoSeleccionado2 = -1;
double peso = 0;

class Home3 extends StatefulWidget {
  const Home3({Key? key}) : super(key: key);

  @override
  State<Home3> createState() => _HomeState();
}

class _HomeState extends State<Home3> {
  final nuevoNodo = TextEditingController();
  int modo = -1;
  int numNodo = 1;
  int keyline = 0;
  int keyline2 = 0;
  int keynodo = 0;
  ModeloNodo nodoinicio = ModeloNodo(-1, -1, 0, "-1", -1);
  int numNodo2 = 1;
  int keyline22 = 0;
  int keyline222 = 0;
  int keynodo2 = 0;
  ModeloNodo nodoinicio2 = ModeloNodo(-1, -1, 0, "-1", -1);
  List<ModeloNodonw> vNodo = [];
  List<ModeloNodonw> vNodoD = [];
  List<ModeloLine> vLinea = [];
  List<List<int>> matriz = [];
  matrizNWSolve? minimizacionWidget;
  matrizNWSolve? maximizacionWidget;
  double totalMinimizacion = 0;
  double totalMaximizacion = 0;
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
                  hintText: "Peso",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  if (peso != null) {
                    peso = value.isEmpty ? 0 : double.parse(value);
                  }
                },
              ),
            ),
            CustomPaint(
              painter: NodosOr(vNodo),
            ),
            CustomPaint(
              painter: Line(vLinea),
            ),
            CustomPaint(
              painter: NodosDes(vNodoD),
            ),
            GestureDetector(
              onPanDown: (ubi) {
                setState(() {
                  //agregar
                  if (modo == 1) {
                    vNodo.add(ModeloNodonw(
                        ubi.globalPosition.dx,
                        ubi.globalPosition.dy,
                        35,
                        numNodo.toString(),
                        0,
                        keynodo));
                    numNodo++;
                    keynodo++;
                  } else {
                    if (modo == 55) {
                      vNodoD.add(ModeloNodonw(
                          ubi.globalPosition.dx,
                          ubi.globalPosition.dy,
                          35,
                          numNodo.toString(),
                          0,
                          keynodo));
                      numNodo++;
                      keynodo++;
                    } else {
                      if (modo == 4) {
                        //eliminar
                        int pos = buscaNodo(
                            ubi.globalPosition.dx, ubi.globalPosition.dy);
                        if (pos >= 0) {
                          // Buscar y eliminar las líneas que tienen el nodo a eliminar como uno de sus extremos
                          for (int i = 0; i < vLinea.length; i++) {
                            if (vLinea[i].x1 == vNodo[pos].x &&
                                    vLinea[i].y1 == vNodo[pos].y ||
                                vLinea[i].x2 == vNodo[pos].x &&
                                    vLinea[i].y2 == vNodo[pos].y) {
                              vLinea.removeAt(i);
                              i--;
                            }
                          }
                          // Eliminar el nodo
                          vNodo.removeAt(pos);
                        } else {
                          // Buscar y eliminar el nodo en vNodoD
                          int posD = buscaNodoD(
                              ubi.globalPosition.dx, ubi.globalPosition.dy);
                          if (posD >= 0) {
                            // Buscar y eliminar las líneas que tienen el nodo a eliminar como uno de sus extremos
                            for (int i = 0; i < vLinea.length; i++) {
                              if (vLinea[i].x1 == vNodoD[posD].x &&
                                      vLinea[i].y1 == vNodoD[posD].y ||
                                  vLinea[i].x2 == vNodoD[posD].x &&
                                      vLinea[i].y2 == vNodoD[posD].y) {
                                vLinea.removeAt(i);
                                i--;
                              }
                            }
                            // Eliminar el nodo
                            vNodoD.removeAt(posD);
                          }
                        }
                      } else {
                        if (modo == 3) {
                          int nodoTocado = buscaNodo2(
                              ubi.localPosition.dx, ubi.localPosition.dy);

                          if (nodoTocado >= 0) {
                            // Nodo de vNodo
                            if (nodoSeleccionado1 == -1) {
                              nodoSeleccionado1 = nodoTocado;
                            } else if (nodoSeleccionado1 != -1 &&
                                nodoSeleccionado2 == -1 &&
                                buscaNodo2D(nodoTocado)) {
                              nodoSeleccionado2 = -1;

                              ModeloNodonw nodoInicio =
                                  vNodo[nodoSeleccionado1];
                              ModeloNodonw nodoDestino = vNodo[nodoTocado];

                              // Calcula la intersección entre la línea que une los centros de los nodos y los bordes de los nodos
                              double dx = nodoDestino.x - nodoInicio.x;
                              double dy = nodoDestino.y - nodoInicio.y;
                              double distancia = sqrt(dx * dx + dy * dy);

                              double xInicio =
                                  nodoInicio.x + (35 * dx / distancia);
                              double yInicio =
                                  nodoInicio.y + (35 * dy / distancia);
                              double xDestino =
                                  nodoDestino.x - (35 * dx / distancia);
                              double yDestino =
                                  nodoDestino.y - (35 * dy / distancia);

                              vLinea.add(ModeloLine(
                                  xInicio,
                                  yInicio,
                                  xDestino,
                                  yDestino,
                                  peso,
                                  nodoInicio.key,
                                  nodoDestino.key,
                                  Colors.blue));

                              nodoSeleccionado1 = -1;
                              nodoSeleccionado2 = -1;
                            }
                          } else if (nodoTocado < -1) {
                            // Nodo de vNodoD
                            int nodoD = -(nodoTocado + 2);
                            if (nodoSeleccionado1 != -1 &&
                                nodoSeleccionado2 == -1) {
                              ModeloNodonw nodoInicio =
                                  vNodo[nodoSeleccionado1];
                              ModeloNodonw nodoDestino = vNodoD[nodoD];

                              // Calcula la intersección entre la línea que une los centros de los nodos y los bordes de los nodos
                              double dx = nodoDestino.x - nodoInicio.x;
                              double dy = nodoDestino.y - nodoInicio.y;
                              double distancia = sqrt(dx * dx + dy * dy);

                              double xInicio =
                                  nodoInicio.x + (35 * dx / distancia);
                              double yInicio =
                                  nodoInicio.y + (35 * dy / distancia);
                              double xDestino =
                                  nodoDestino.x - (35 * dx / distancia);
                              double yDestino =
                                  nodoDestino.y - (35 * dy / distancia);

                              vLinea.add(ModeloLine(
                                  xInicio,
                                  yInicio,
                                  xDestino,
                                  yDestino,
                                  peso,
                                  nodoInicio.key,
                                  nodoDestino.key,
                                  Colors.black));

                              nodoSeleccionado1 = -1;
                              nodoSeleccionado2 = -1;
                            }
                          } else {
                            // Ningún nodo tocado
                            nodoSeleccionado1 = -1;
                            nodoSeleccionado2 = -1;
                          }
                        }
                      }
                    }
                  }
                });
              },
              onPanUpdate: (DragUpdateDetails ubi) {
                //mover
                setState(() {
                  if (modo == 2) {
                    //mover nodo
                    int pos =
                        buscaNodo(ubi.globalPosition.dx, ubi.globalPosition.dy);
                    if (pos >= 0) {
                      double dx = ubi.globalPosition.dx - vNodo[pos].x;
                      double dy = ubi.globalPosition.dy - vNodo[pos].y;
                      vNodo[pos].x = ubi.globalPosition.dx;
                      vNodo[pos].y = ubi.globalPosition.dy;

                      // actualizar líneas conectadas al nodo movido
                      for (int i = 0; i < vLinea.length; i++) {
                        if (vLinea[i].x1 == vNodo[pos].x &&
                            vLinea[i].y1 == vNodo[pos].y) {
                          vLinea[i].x1 += dx;
                          vLinea[i].y1 += dy;
                        } else if (vLinea[i].x2 == vNodo[pos].x &&
                            vLinea[i].y2 == vNodo[pos].y) {
                          vLinea[i].x2 += dx;
                          vLinea[i].y2 += dy;
                        }
                      }
                    }
                  }
                  if (modo == 8) {
                    //limpiar la pantalla
                  }
                  if (modo == 5) {
                    //eliminar linea
                    int pos = buscaLinea(
                        ubi.globalPosition.dx, ubi.globalPosition.dy);
                    if (pos >= 0) {
                      vLinea.removeAt(pos);
                    }
                  }
                  if (modo == 7) {
                    int pos =
                        buscaNodo(ubi.globalPosition.dx, ubi.globalPosition.dy);
                    int pos2 = buscaNodoD(
                        ubi.globalPosition.dx, ubi.globalPosition.dy);
                    if (pos >= 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Nuevo nombre nodo"),
                            content: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Ingresa nuevo nodo'),
                              controller: nuevoNodo,
                            ),
                            actions: [
                              TextButton(
                                child: Text("Aceptar"),
                                onPressed: () {
                                  vNodo[pos].nombre = nuevoNodo.text;
                                  print(nuevoNodo.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Eliminar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    if (pos2 >= 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Nuevo nombre nodo"),
                            content: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Ingresa nuevo nodo'),
                              controller: nuevoNodo,
                            ),
                            actions: [
                              TextButton(
                                child: Text("Aceptar"),
                                onPressed: () {
                                  vNodoD[pos2].nombre = nuevoNodo.text;
                                  print(nuevoNodo.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Eliminar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                });
              },
            )
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
                    tooltip: 'Crear nodo',
                    color: modo == 1 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        modo = 1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.auto_graph_rounded),
                    tooltip: 'Enlazar nodos',
                    color: modo == 3 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        modo = 3;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 4 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        modo = 4;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_sweep),
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 5 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        modo = 5;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.data_array_sharp),
                    tooltip: "Matriz de adyacencia",
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 6 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) => matrizNWSolve(
                                  nodosO: vNodo,
                                  nodosD: vNodoD,
                                  lineas: vLinea,
                                  mod: false,
                                ));
                        print("Nort West");
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_outlined),
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 7 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        modo = 7;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.layers_clear_sharp),
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 8 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        vNodo.clear();
                        vNodoD.clear();
                        vLinea.clear();
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.add_alarm_rounded),
                    tooltip: 'Crear nodo destino',
                    color: modo == 55 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      modo = 55;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_chart_outlined),
                    tooltip: 'Asignar demandas y ofertas',
                    color: modo == 66 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      // Controladores de texto para obtener los valores de los campos de entrada
                      List<TextEditingController> controladoresOr =
                          List.generate(
                              vNodo.length, (_) => TextEditingController());
                      List<TextEditingController> controladoresD =
                          List.generate(
                              vNodoD.length, (_) => TextEditingController());

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Agregar ofertas y demandas'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Agregar campos de entrada para ofertas según cantidad de nodos en vNodoOr
                                  for (int i = 0; i < vNodo.length; i++)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: controladoresOr[i],
                                            decoration: InputDecoration(
                                                labelText:
                                                    'Oferta nodo ${vNodo[i].key}'),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              // Actualizar el valor del atributo atri del nodo correspondiente en vNodo
                                              vNodo[i].atri = int.tryParse(
                                                      controladoresOr[i]
                                                          .text) ??
                                                  0;
                                              print(vNodo[i].atri);
                                            });
                                          },
                                          child: Text('Agregar'),
                                        ),
                                      ],
                                    ),
                                  // Agregar campos de entrada para demandas según cantidad de nodos en vNodoD
                                  for (int i = 0; i < vNodoD.length; i++)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: controladoresD[i],
                                            decoration: InputDecoration(
                                                labelText:
                                                    'Demanda nodo ${vNodoD[i].key}'),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              // Actualizar el valor del atributo atri del nodo correspondiente en vNodoD
                                              vNodoD[i].atri = int.tryParse(
                                                      controladoresD[i].text) ??
                                                  0;
                                              print(vNodoD[i].atri);
                                            });
                                          },
                                          child: Text('Agregar'),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.maximize_rounded),
                    tooltip: 'maximizar',
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 24 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) => matrizNWSolve(
                                nodosO: vNodo,
                                nodosD: vNodoD,
                                lineas: vLinea,
                                mod: false));
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.minimize_rounded),
                    tooltip: 'minimizar',
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 24 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) => matrizNWSolve(
                                nodosO: vNodo,
                                nodosD: vNodoD,
                                lineas: vLinea,
                                mod: true));
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    tooltip: 'Ayuda',
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 200 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Ayudanw()));
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.save),
                    color: modo == 200 ? Colors.green.shade300 : Colors.white,
                    onPressed: () async {
                      await guardarDatos();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.folder_open),
                    color: modo == 200 ? Colors.green.shade300 : Colors.white,
                    onPressed: () async {
                      await cargarDatos();
                      setState(() {});
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  int buscaNodo2(double x, double y) {
    for (int i = 0; i < vNodo.length; i++) {
      if (vNodo[i].dentro(x, y)) {
        return i;
      }
    }

    for (int i = 0; i < vNodoD.length; i++) {
      if (vNodoD[i].dentro(x, y)) {
        return -(i +
            2); // Devuelve -2 para el primer índice en vNodoD, -3 para el segundo, etc.
      }
    }

    return -1;
  }

  int buscaNodo(double x2, double y2) {
    int pos = -1, i;
    for (i = 0; i < vNodo.length; i++) {
      double x1 = vNodo[i].x;
      double y1 = vNodo[i].y;
      double r1 = vNodo[i].radio;
      double dist = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
      if (dist <= r1) {
        pos = i;
        i = vNodo.length + 1;
      }
    }

    return pos;
  }

  int buscaNodoD(double x2, double y2) {
    int pos = -1, i;
    for (i = 0; i < vNodoD.length; i++) {
      double x1 = vNodoD[i].x;
      double y1 = vNodoD[i].y;
      double r1 = vNodoD[i].radio;
      double dist = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
      if (dist <= r1) {
        pos = i;
        i = vNodo.length + 1;
      }
    }

    return pos;
  }

  bool buscaNodo2D(int nodo) {
    for (int i = 0; i < vNodoD.length; i++) {
      if (vNodoD[i].key == vNodo[nodo].key) {
        return true;
      }
    }
    return false;
  }

  double distanciaPuntoLinea(
      double x, double y, double x1, double y1, double x2, double y2) {
    double numerador =
        ((y2 - y1) * x - (x2 - x1) * y + x2 * y1 - y2 * x1).abs();
    double denominador = sqrt(pow(y2 - y1, 2) + pow(x2 - x1, 2));
    return numerador / denominador;
  }

  int buscaLinea(double x, double y) {
    for (int i = 0; i < vLinea.length; i++) {
      double distancia = distanciaPuntoLinea(
          x, y, vLinea[i].x1, vLinea[i].y1, vLinea[i].x2, vLinea[i].y2);
      if (distancia < 20) {
        // si la distancia es menor a 20 pixels, consideramos que se ha tocado la línea
        return i;
      }
    }
    return -1; // no se encontró ninguna línea
  }

  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  Future<bool> requestManageExternalStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }

    return false;
  }

  Future<void> saveFile(String fileName, String content) async {
    await _channel
        .invokeMethod('saveFile', {'name': fileName, 'content': content});
  }

// ...
  Future<void> guardarDatos() async {
    try {
      final data = {
        'nodos': vNodo.map((nodo) => nodo.toJson()).toList(),
        'nodosD':
            vNodoD.map((nodo) => nodo.toJson()).toList(), // Añade esta línea
        'lineas': vLinea.map((linea) => linea.toJson()).toList(),
      };

      final jsonData = json.encode(data);

      if (kIsWeb) {
        // Solución para Flutter Web
        final bytes = utf8.encode(jsonData);
        final blob = html.Blob([bytes], 'application/octet-stream');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute(
              'download', 'data_${DateTime.now().toIso8601String()}.json')
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        // Solución para Android e iOS
        final directory = await getExternalStorageDirectory();
        final fileName = 'data_${DateTime.now().toIso8601String()}.json';
        final filePath = '${directory!.path}/$fileName';
        final file = File(filePath);

        await file.writeAsString(jsonData);

        print('Datos guardados exitosamente');
        print('Ruta del archivo guardado: $filePath');
      }
    } catch (e) {
      print('Error al guardar los datos: $e');
    }
  }

  Future<void> cargarDatos() async {
    try {
      FilePickerResult? result;
      if (kIsWeb) {
        // Solución para Flutter Web
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
        );
      } else {
        // Solución para Android e iOS
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
        );
      }

      if (result != null) {
        final file = result.files.first;
        final contents = utf8.decode(file.bytes!);
        final data = json.decode(contents);

        setState(() {
          vNodo = List<ModeloNodonw>.from((data['nodos'] as List)
              .map((nodo) => ModeloNodonw.fromJson(nodo)));
          vNodoD = List<ModeloNodonw>.from(
              (data['nodosD'] as List) // Actualiza 'nodos2' a 'nodosD'
                  .map((nodo) => ModeloNodonw.fromJson(nodo)));
          vLinea = List<ModeloLine>.from((data['lineas'] as List)
              .map((linea) => ModeloLine.fromJson(linea)));
        });

        print('Datos cargados exitosamente');
      } else {
        print('No se seleccionó ningún archivo');
      }
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }
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

List<List<int>> obtenerMatriz(List<ModeloNodo> nodos, List<ModeloLine> lineas) {
  List<List<int>> matriz = [];
  for (int i = 0; i < nodos.length; i++) {
    List<int> fila = [];
    for (int j = 0; j < nodos.length; j++) {
      int valor = 0;
      for (int k = 0; k < lineas.length; k++) {
        int key1 = lineas[k].key;
        int key2 = lineas[k].key2;
        if (key1 == nodos[i].key && key2 == nodos[j].key) {
          valor = lineas[k].peso.toInt();
          break;
        }
      }
      fila.add(valor);
    }
    matriz.add(fila);
  }
  return matriz;
}

List<int>? bellmanFord(List<List<int>> matriz, int n) {
  List<int> h = List.filled(n + 1, 0);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      for (int k = 0; k < n; k++) {
        if (matriz[j][k] > matriz[j][i] + matriz[i][k]) {
          matriz[j][k] = matriz[j][i] + matriz[i][k];
          h[k] = i;
        }
      }
    }
  }
  for (int j = 0; j < n; j++) {
    for (int k = 0; k < n; k++) {
      if (matriz[j][k] > matriz[j][h[k]] + matriz[h[k]][k]) {
        return null;
      }
    }
  }
  return h;
}

void johnson(List<ModeloNodo> vNodo, List<ModeloLine> vLinea) {
  List<List<int>> matriz = obtenerMatriz(vNodo, vLinea);
  int n = matriz.length;
  List<List<int>> matriz2 = List.generate(n + 1, (i) => List.filled(n + 1, 0));
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      matriz2[i][j] = matriz[i][j];
    }
  }
  for (int i = 0; i < n; i++) {
    matriz2[i][n] = 0;
    matriz2[n][i] = 999999;
  }
  // Paso 1: Obtener un nuevo grafo con pesos positivos
  List<int>? h = bellmanFord(matriz2, n);
  if (h == null) {
    // El grafo contiene un ciclo negativo
    print("El grafo contiene un ciclo negativo");
  } else {
    // Paso 2: Obtener el nuevo grafo con pesos no negativos
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        matriz[i][j] = matriz[i][j] + h[i] - h[j];
      }
    }
    List<int> distancias = [];
    // Paso 3: Obtener las distancias mínimas
    for (int i = 0; i < n; i++) {
      List<int>? d = dijkstra(matriz, i);
      if (d == null) {
        // El grafo no es conexo
        print("El grafo no es conexo");
      } else {
        // Imprimir las distancias mínimas
        for (int j = 0; j < n; j++) {
          distancias.add(d[j] + h[j] - h[i]);
          print("Distancia mínima de $i a $j: ${d[j] + h[j] - h[i]}");
        }
      }
    }
  }
}

List<int>? dijkstra(List<List<int>> matriz, int origen) {
  int n = matriz.length;
  List<int> d = List.filled(n, 999999);
  List<bool> s = List.filled(n, false);
  d[origen] = 0;
  for (int i = 0; i < n; i++) {
    int u = -1;
    for (int j = 0; j < n; j++) {
      if (!s[j] && (u == -1 || d[j] < d[u])) {
        u = j;
      }
    }
    if (d[u] == 999999) {
      return null;
    }
    s[u] = true;
    for (int v = 0; v < n; v++) {
      if (matriz[u][v] != 0) {
        d[v] = min(d[v], d[u] + matriz[u][v]);
      }
    }
  }
  return d;
}
