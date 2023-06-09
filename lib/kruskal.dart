import 'dart:async';
import 'dart:io';

import 'dart:math';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:gf12/asignacion.dart';
import 'package:gf12/nw.dart';
import 'package:path_provider/path_provider.dart';

import 'Compet.dart';
import 'Sorts.dart';
import 'arboles.dart';
import 'ayudadijs.dart';

import 'dij.dart';
import 'figuras.dart';
import 'home.dart';
import 'jh.dart';
import 'kruskal.dart';
import 'matrizdij.dart';
import 'modelos.dart';
import 'dart:collection';
//
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
import 'dart:collection';

double peso = 0;
const MethodChannel _channel = MethodChannel('com.example.gf12/saveFile');

class Home9 extends StatefulWidget {
  const Home9({Key? key}) : super(key: key);

  @override
  State<Home9> createState() => HomeState8();
}

class HomeState8 extends State<Home9> {
  final nuevoNodo = TextEditingController();
  int modo = -1;
  int numNodo = 1;
  int keyline = 0;
  int keyline2 = 0;
  int keynodo = 0;
  ModeloNodo nodoinicio = ModeloNodo(-1, -1, 0, "-1", -1);
  List<ModeloNodo> vNodo = [];
  List<ModeloLine> vLinea = [];
  ModeloNodo nodoInicioSeleccionado = ModeloNodo(-1, -1, 0, "-1", -1);
  ModeloNodo nodoDestinoSeleccionado = ModeloNodo(-1, -1, 0, "-1", -1);
  ModeloLine nuevaLinea = ModeloLine(0, 0, 0, 0, 0, 0, 0, Colors.black);
  List<int> caminoOptimo = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFD3C8C8),
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
                                        Colors.white),
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
              painter: Nodos(vNodo),
            ),
            CustomPaint(
              painter: Line(vLinea),
            ),
            GestureDetector(
              onPanDown: (ubi) {
                setState(() {
                  //agregar
                  if (modo == 1) {
                    vNodo.add(ModeloNodo(
                        ubi.globalPosition.dx,
                        ubi.globalPosition.dy,
                        35,
                        numNodo.toString(),
                        keynodo));
                    numNodo++;
                    keynodo++;
                  } else {
                    if (modo == 4) {
                      //eliminar
                      int pos = buscaNodo(
                          ubi.globalPosition.dx, ubi.globalPosition.dy);
                      if (pos >= 0) {
                        // Buscar las líneas que tienen el nodo a eliminar como uno de sus extremos
                        for (int i = 0; i < vLinea.length; i++) {
                          if (vLinea[i].x1 == vNodo[pos].x &&
                                  vLinea[i].y1 == vNodo[pos].y ||
                              vLinea[i].x2 == vNodo[pos].x &&
                                  vLinea[i].y2 == vNodo[pos].y) {
                            // Eliminar la línea
                            vLinea.removeAt(i);
                            i--; // Decrementar el índice para ajustar el tamaño del vector
                          }
                        }
                        // Eliminar el nodo
                        vNodo.removeAt(pos);
                      }
                    } else {
                      if (modo == 3) {
                        int pos1 = buscaNodo(
                            ubi.globalPosition.dx, ubi.globalPosition.dy);
                        bool existeLinea = false;

                        if (pos1 >= 0) {
                          int l1 = nodoinicio.key;
                          int l2 = vNodo[pos1].key;
                          double dx = vNodo[pos1].x - nodoinicio.x;
                          double dy = vNodo[pos1].y - nodoinicio.y;
                          double distancia = sqrt(dx * dx + dy * dy);
                          double angulo = atan2(dy, dx);

                          double xLlegada =
                              vNodo[pos1].x - (35 * dx / distancia);
                          double yLlegada =
                              vNodo[pos1].y - (35 * dy / distancia);
                          double xInicio = nodoinicio.x + (35 * dx / distancia);
                          double yInicio = nodoinicio.y + (35 * dy / distancia);

                          if (nodoinicio.x == -1) {
                            nodoinicio = vNodo[pos1];
                          } else {
                            if (vNodo[pos1].x == nodoinicio.x &&
                                vNodo[pos1].y == nodoinicio.y) {
                              // Las coordenadas son iguales, crear línea que rodea el nodo
                              double radius = 30.0;
                              double angle = atan2(nodoinicio.y - vNodo[pos1].y,
                                  nodoinicio.x - vNodo[pos1].x);
                              double x1 = nodoinicio.x + radius * cos(angle);
                              double y1 = nodoinicio.y + radius * sin(angle);

                              if (vNodo.isNotEmpty) {
                                vLinea.add(ModeloLine(
                                    nodoinicio.x,
                                    nodoinicio.y,
                                    x1,
                                    y1,
                                    peso,
                                    l1,
                                    l2,
                                    Colors.black));
                              }
                            } else {
                              for (ModeloLine linea in vLinea) {
                                if ((linea.x1 == xInicio &&
                                        linea.y1 == yInicio &&
                                        linea.x2 == xLlegada &&
                                        linea.y2 == yLlegada) ||
                                    (linea.x2 == xInicio &&
                                        linea.y2 == yInicio &&
                                        linea.x1 == xLlegada &&
                                        linea.y1 == yLlegada)) {
                                  existeLinea = true;
                                  break;
                                }
                              }

                              if (!existeLinea) {
                                vLinea.add(ModeloLine(
                                    xInicio,
                                    yInicio,
                                    xLlegada,
                                    yLlegada,
                                    peso,
                                    l1,
                                    l2,
                                    Colors.black));
                              }
                            }

                            nodoinicio = ModeloNodo(-1, -1, 0, "-1", -1);
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
                    // Mover nodo de inicio
                    int pos =
                        buscaNodo(ubi.globalPosition.dx, ubi.globalPosition.dy);
                    setState(() {
                      nodoInicioSeleccionado = vNodo[pos];
                    });

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Alerta'),
                          content: Text(
                              'Nodo de inicio seleccionado: ${nodoInicioSeleccionado.nombre}'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
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
                  } else {
                    if (modo == 400) {
                      // Mover nodo de destino
                      int pos = buscaNodo(
                          ubi.globalPosition.dx, ubi.globalPosition.dy);
                      setState(() {
                        nodoDestinoSeleccionado = vNodo[pos];
                      });

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alerta'),
                            content: Text(
                                'Nodo de destino seleccionado: ${nodoDestinoSeleccionado.nombre}'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      if (modo == 300) {}
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
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 6 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                verMatriz(nodos: vNodo, lineas: vLinea));
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
                        vLinea.clear();
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
                                builder: (context) => const Ayuda()));
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  IconButton(
                    icon: Icon(Icons.data_object_outlined),
                    color: modo == 300 ? Colors.green.shade300 : Colors.white,
                    onPressed: () async {
                      print('Nodos: ${vNodo.length}');
                      print('Líneas: ${vLinea.length}');
                      print(
                          'Nodo de inicio seleccionado: ${nodoInicioSeleccionado.nombre}');
                      print(
                          'Nodo de destino seleccionado: ${nodoDestinoSeleccionado.nombre}');

                      List<ModeloLine> arbolExpansionMinima =
                          kruskal(vNodo, vLinea);
                      print('Arbol de expansión mínima: $arbolExpansionMinima');

                      for (ModeloLine linea in arbolExpansionMinima) {
                        linea.color = Colors.blue; // Nuevo color
                      }

                      setState(() {});
                      Future.delayed(Duration.zero, () {
                        mostrarArbolExpansionMinima(
                            context, arbolExpansionMinima);
                      });
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.catching_pokemon),
                      color: modo == 300 ? Colors.green.shade300 : Colors.white,
                      onPressed: () async {
                        print('Nodos: ${vNodo.length}');
                        print('Líneas: ${vLinea.length}');
                        print(
                            'Nodo de inicio seleccionado: ${nodoInicioSeleccionado.nombre}');
                        print(
                            'Nodo de destino seleccionado: ${nodoDestinoSeleccionado.nombre}');

                        List<ModeloLine> arbolExpansionMaxima =
                            kruskal2(vNodo, vLinea);
                        print(
                            'Arbol de expansión maxima: $arbolExpansionMaxima');

                        for (ModeloLine linea in arbolExpansionMaxima) {
                          linea.color = Colors.red; // Nuevo color
                        }

                        setState(() {});
                        Future.delayed(Duration.zero, () {
                          mostrarArbolExpansionMaxima(
                              context, arbolExpansionMaxima);
                        });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<ModeloLine> kruskal(List<ModeloNodo> nodos, List<ModeloLine> lineas) {
    List<ModeloLine> arbolExpansionMinima = [];

    // Ordenar las aristas por peso de menor a mayor
    lineas.sort((a, b) => a.peso.compareTo(b.peso));

    // Inicializar conjuntos disjuntos
    List<List<int>> conjuntos = [];
    for (int i = 0; i < nodos.length; i++) {
      conjuntos.add([i]); // Cada nodo está en su propio conjunto
    }

    int aristasAgregadas = 0;
    int indiceLinea = 0;

    while (aristasAgregadas < nodos.length - 1) {
      ModeloLine lineaActual = lineas[indiceLinea];
      int nodo1 = lineaActual.key;
      int nodo2 = lineaActual.key2;

      // Verificar si los nodos están en conjuntos diferentes
      int conjuntoNodo1 = encontrarConjunto(conjuntos, nodo1);
      int conjuntoNodo2 = encontrarConjunto(conjuntos, nodo2);

      if (conjuntoNodo1 != conjuntoNodo2) {
        // Los nodos no forman un ciclo, se agrega la arista al árbol de expansión mínima
        arbolExpansionMinima.add(lineaActual);
        aristasAgregadas++;

        // Unir los conjuntos de los nodos
        union(conjuntos, conjuntoNodo1, conjuntoNodo2);
      }

      indiceLinea++;
    }

    return arbolExpansionMinima;
  }

  List<ModeloLine> kruskal2(List<ModeloNodo> nodos, List<ModeloLine> lineas) {
    List<ModeloLine> arbolExpansionMaxima = [];

    // Ordenar las aristas por peso de menor a mayor
    lineas.sort((a, b) => b.peso.compareTo(a.peso));

    // Inicializar conjuntos disjuntos
    List<List<int>> conjuntos = [];
    for (int i = 0; i < nodos.length; i++) {
      conjuntos.add([i]); // Cada nodo está en su propio conjunto
    }

    int aristasAgregadas = 0;
    int indiceLinea = 0;

    while (aristasAgregadas < nodos.length - 1) {
      ModeloLine lineaActual = lineas[indiceLinea];
      int nodo1 = lineaActual.key;
      int nodo2 = lineaActual.key2;

      // Verificar si los nodos están en conjuntos diferentes
      int conjuntoNodo1 = encontrarConjunto(conjuntos, nodo1);
      int conjuntoNodo2 = encontrarConjunto(conjuntos, nodo2);

      if (conjuntoNodo1 != conjuntoNodo2) {
        // Los nodos no forman un ciclo, se agrega la arista al árbol de expansión mínima
        arbolExpansionMaxima.add(lineaActual);
        aristasAgregadas++;

        // Unir los conjuntos de los nodos
        union(conjuntos, conjuntoNodo1, conjuntoNodo2);
      }

      indiceLinea++;
    }

    return arbolExpansionMaxima;
  }

  int encontrarConjunto(List<List<int>> conjuntos, int nodo) {
    for (int i = 0; i < conjuntos.length; i++) {
      if (conjuntos[i].contains(nodo)) {
        return i;
      }
    }
    return -1;
  }

  void union(List<List<int>> conjuntos, int conjunto1, int conjunto2) {
    conjuntos[conjunto1].addAll(conjuntos[conjunto2]);
    conjuntos.removeAt(conjunto2);
  }

  void mostrarArbolExpansionMinima(
      BuildContext context, List<ModeloLine> arbolExpansionMinima) {
    String textoArbol = arbolExpansionMinima.map((linea) {
      ModeloNodo nodo1 = vNodo.firstWhere((nodo) => nodo.key == linea.key);
      ModeloNodo nodo2 = vNodo.firstWhere((nodo) => nodo.key == linea.key2);
      return '${nodo1.nombre} - ${nodo2.nombre} (${linea.peso})';
    }).join('\n');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Árbol de expansión mínima'),
          content: Text(textoArbol),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarArbolExpansionMaxima(
      BuildContext context, List<ModeloLine> arbolExpansionMaxima) {
    String textoArbol = arbolExpansionMaxima.map((linea) {
      ModeloNodo nodo1 = vNodo.firstWhere((nodo) => nodo.key == linea.key);
      ModeloNodo nodo2 = vNodo.firstWhere((nodo) => nodo.key == linea.key2);
      return '${nodo1.nombre} - ${nodo2.nombre} (${linea.peso})';
    }).join('\n');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Árbol de expansión máxima'),
          content: Text(textoArbol),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<int> dijkstraMax(int inicioKey, int destinoKey) {
    Map<int, double> distancias = {};
    Map<int, int?> previos = {};
    List<int> nodosNoVisitados = vNodo.map((nodo) => nodo.key).toList();
    int maxIter = 10000; // Número máximo de iteraciones permitidas

    for (var nodo in vNodo) {
      distancias[nodo.key] =
          nodo.key == inicioKey ? 0 : double.negativeInfinity;
      previos[nodo.key] = null;
    }

    int iter = 0;
    while (nodosNoVisitados.isNotEmpty) {
      if (iter++ > maxIter) {
        print(
            "El cálculo se ha detenido debido a demasiadas iteraciones, puede haber un bucle infinito");
        return []; // Termina la ejecución
      }
      nodosNoVisitados.sort((a, b) => distancias[b]!.compareTo(distancias[a]!));
      int nodoActualKey = nodosNoVisitados.removeAt(0);

      if (nodoActualKey == destinoKey) {
        break;
      }

      for (var linea in vLinea) {
        if (linea.key == nodoActualKey) {
          int nodoVecinoKey = linea.key2;
          double distancia = distancias[nodoActualKey]! + linea.peso;

          if (distancia > distancias[nodoVecinoKey]!) {
            distancias[nodoVecinoKey] = distancia;
            previos[nodoVecinoKey] = nodoActualKey;
          }
        } else if (linea.key2 == nodoActualKey) {
          int nodoVecinoKey = linea.key;
          double distancia = distancias[nodoActualKey]! + linea.peso;

          if (distancia > distancias[nodoVecinoKey]!) {
            distancias[nodoVecinoKey] = distancia;
            previos[nodoVecinoKey] = nodoActualKey;
          }
        }
      }
    }

    List<int> caminoOptimo = [];
    int? nodoKey = destinoKey;
    while (nodoKey != null) {
      caminoOptimo.add(nodoKey);
      nodoKey = previos[nodoKey];
    }

    if (caminoOptimo.isEmpty || caminoOptimo.last != inicioKey) {
      print("Camino no encontrado");
      return []; // No hay camino válido
    }

    return caminoOptimo.reversed.toList();
  }

  void mostrarCaminoOptimo(BuildContext context, List<int> caminoOptimo) {
    List<ModeloNodo> nodosCamino = caminoOptimo.map((key) {
      return vNodo.firstWhere((nodo) => nodo.key == key);
    }).toList();

    String textoCamino = nodosCamino.map((nodo) => nodo.nombre).join(" -> ");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Camino óptimo'),
          content: Text(textoCamino),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<int> dijkstra(int inicioKey, int destinoKey) {
    Map<int, double> distancias = {};
    Map<int, int?> previos = {};
    List<int> nodosNoVisitados = vNodo.map((nodo) => nodo.key).toList();

    for (var nodo in vNodo) {
      distancias[nodo.key] = nodo.key == inicioKey ? 0 : double.infinity;
      previos[nodo.key] = null;
    }

    while (nodosNoVisitados.isNotEmpty) {
      nodosNoVisitados.sort((a, b) => distancias[a]!.compareTo(distancias[b]!));
      int nodoActualKey = nodosNoVisitados.removeAt(0);

      if (nodoActualKey == destinoKey) {
        break;
      }

      for (var linea in vLinea) {
        if (linea.key == nodoActualKey) {
          int nodoVecinoKey = linea.key2;

          double distancia = distancias[nodoActualKey]! + linea.peso;

          if (distancia < distancias[nodoVecinoKey]!) {
            distancias[nodoVecinoKey] = distancia;
            previos[nodoVecinoKey] = nodoActualKey;
          }
        } else if (linea.key2 == nodoActualKey) {
          int nodoVecinoKey = linea.key;

          double distancia = distancias[nodoActualKey]! + linea.peso;

          if (distancia < distancias[nodoVecinoKey]!) {
            distancias[nodoVecinoKey] = distancia;
            previos[nodoVecinoKey] = nodoActualKey;
          }
        }
      }
    }

    List<int> caminoOptimo = [];
    int? nodoKey = destinoKey;
    while (nodoKey != null) {
      caminoOptimo.add(nodoKey);
      nodoKey = previos[nodoKey];
    }

    if (caminoOptimo.isEmpty || caminoOptimo.last != inicioKey) {
      print("Camino no encontrado");
      return []; // No hay camino válido
    }

    return caminoOptimo.reversed.toList();
  }

  bool _compararCoordenadas(double a, double b) {
    final tolerancia = 0.50000; // Ajusta la tolerancia según tus necesidades
    return (a - b).abs() < tolerancia;
  }

  int buscaNodo(double x, double y) {
    for (int i = 0; i < vNodo.length; i++) {
      if (vNodo[i].dentro(x, y)) {
        return i;
      }
    }
    return -1;
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
          vNodo = List<ModeloNodo>.from(
              (data['nodos'] as List).map((nodo) => ModeloNodo.fromJson(nodo)));
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

//crea una funcion para crear la matriz adyacente de los nodos
void matrizAdyacente(List<ModeloNodo> vNodo, List<ModeloLine> vLinea) {
  //crea una lista de listas de enteros
  List<List<int>> matriz = [];
  //crea una lista de enteros
  List<int> lista = [];
  //recorre la lista de nodos
  for (int i = 0; i < vNodo.length; i++) {
    //recorre la lista de lineas
    for (int j = 0; j < vLinea.length; j++) {
      //si el nodo de inicio de la linea es igual al nodo de la lista de nodos
      if (vNodo[i].x == vLinea[j].x1 && vNodo[i].y == vLinea[j].y1) {
        //agrega el peso de la linea a la lista
        int peso2 = peso.toInt();
        lista.add(peso2);
      }
    }
    //agrega la lista a la matriz
    matriz.add(lista);
    //limpia la lista
    lista = [];
  }
  //imprime la matriz
  print(matriz);
}
