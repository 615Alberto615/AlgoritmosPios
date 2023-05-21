import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gf12/asignacion.dart';
import 'package:gf12/nw.dart';

import 'Compet.dart';
import 'Sorts.dart';
import 'arboles.dart';
import 'ayudajh.dart';
import 'dij.dart';
import 'figuras.dart';
import 'home.dart';
import 'kruskal.dart';
import 'matrizjh.dart';
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

double peso = 0;
const MethodChannel _channel = MethodChannel('com.example.gf12/saveFile');

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _HomeState();
}

class _HomeState extends State<Home2> {
  final nuevoNodo = TextEditingController();
  int modo = -1;
  int numNodo = 1;
  int keyline = 0;
  int keyline2 = 0;
  int keynodo = 0;
  ModeloNodoJh nodoinicio = ModeloNodoJh(-1, -1, 0, "-1", 0, 0, -1);
  List<ModeloNodoJh> vNodo = [];
  List<ModeloLineJh> vLinea = [];
  List<List<int>> matriz = [];

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
              painter: NodosJh(vNodo),
            ),
            CustomPaint(
              painter: Lij(vLinea),
            ),
            GestureDetector(
              onPanDown: (ubi) {
                setState(() {
                  //agregar
                  if (modo == 1) {
                    vNodo.add(ModeloNodoJh(
                        ubi.globalPosition.dx,
                        ubi.globalPosition.dy,
                        35,
                        numNodo.toString(),
                        0,
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
                        bool existeLinea2 = false;
                        bool existeLinea3 = false;

                        double xd = 20;
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
                              // las coordenadas son iguales, crear línea que rodea el nodo
                              double radius = 30.0;
                              double angle = atan2(nodoinicio.y - vNodo[pos1].y,
                                  nodoinicio.x - vNodo[pos1].x);
                              double x1 = nodoinicio.x + radius * cos(angle);
                              double y1 = nodoinicio.y + radius * sin(angle);
                              if (vNodo.isNotEmpty) {
                                vLinea.add(ModeloLineJh(nodoinicio.x,
                                    nodoinicio.y, x1, y1, peso, 0, l1, l2));
                              }
                            } else {
                              for (ModeloLineJh linea in vLinea) {
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
                              for (ModeloLineJh linea in vLinea) {
                                if ((linea.x1 == xInicio &&
                                        linea.y1 == yInicio &&
                                        linea.x2 == xLlegada &&
                                        linea.y2 ==
                                            yLlegada) || // Nueva línea con llegada como inicio de línea existente
                                    (linea.x2 == xInicio &&
                                        linea.y2 == yInicio &&
                                        linea.x1 == xLlegada &&
                                        linea.y1 ==
                                            yLlegada) || // Nueva línea con inicio como llegada de línea existente
                                    (linea.x1 == xLlegada &&
                                        linea.y1 == yLlegada &&
                                        linea.x2 == xInicio &&
                                        linea.y2 ==
                                            yInicio) || // Línea existente con llegada como inicio de nueva línea
                                    (linea.x2 == xLlegada &&
                                        linea.y2 == yLlegada &&
                                        linea.x1 == xInicio &&
                                        linea.y1 == yInicio)) {
                                  // Línea existente con inicio como llegada de nueva línea
                                  existeLinea2 = true;
                                  break;
                                }
                              }

                              if (existeLinea == true) {
                                vLinea.add(ModeloLineJh(
                                    nodoinicio.x + xd,
                                    nodoinicio.y + xd,
                                    xLlegada + xd,
                                    yLlegada + xd,
                                    peso,
                                    0,
                                    l1,
                                    l2));
                              } else {
                                if (existeLinea2 == true) {
                                  vLinea.add(ModeloLineJh(
                                      xLlegada + xd,
                                      yLlegada + xd,
                                      xInicio + xd,
                                      yInicio + xd,
                                      peso,
                                      0,
                                      l1,
                                      l2));
                                } else {
                                  if (existeLinea3 == true) {
                                    vLinea.add(ModeloLineJh(
                                        xInicio + xd,
                                        yInicio + xd,
                                        xLlegada + xd,
                                        yLlegada + xd,
                                        peso,
                                        0,
                                        l1,
                                        l2));
                                  } else {
                                    vLinea.add(ModeloLineJh(xInicio, yInicio,
                                        xLlegada, yLlegada, peso, 0, l1, l2));
                                  }
                                }
                              }
                              nodoinicio =
                                  ModeloNodoJh(-1, -1, 0, "-1", 0, 0, -1);
                            }
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
                    } else {
                      if (modo == 55) {
                        /*List<List<int>> matriz = obtenerMatriz(vNodo, vLinea);
                        List<int>? camino = dijkstra(matriz, 0);
                        for (int i = 0; i < vNodo.length; i++) {
                          vNodo[i].n1 = camino![i];
                        }*/
                      }
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
                    icon: Icon(Icons.summarize_outlined),
                    tooltip: 'Crear nodo',
                    color: modo == 55 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        List<List<int>> matriz2 = obtenerMatriz(vNodo, vLinea);
                        List<int>? camino2 = dijkstra(matriz2, 0);
                        List<int> pesosEntrantes =
                            calcularPesosEntrantes(vNodo, vLinea);
                        //int c = camino2![vNodo.length];
                        //pesosEntrantes.add(c);
                        //pesosEntrantes.remove(0);
                        print(pesosEntrantes);
                        for (int i = 0; i < vNodo.length; i++) {
                          vNodo[i].n1 = camino2![i];
                          vNodo[i].n2 = pesosEntrantes[i];
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.route_outlined),
                    tooltip: 'Enlazar nodos',
                    color: modo == 66 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        List<List<int>> matriz = obtenerMatriz(vNodo, vLinea);
                        int n = matriz.length;
                        List<int>? hh = bellmanFord(matriz, n);
                        for (int i = 0; i < n; i++) {
                          if (hh == null) {
                            vLinea[i].h = 0;
                          } else {
                            vLinea[i].h = hh[i].toDouble();
                          }
                        }
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
          vNodo = List<ModeloNodoJh>.from((data['nodos'] as List)
              .map((nodo) => ModeloNodoJh.fromJson(nodo)));
          vLinea = List<ModeloLineJh>.from((data['lineas'] as List)
              .map((linea) => ModeloLineJh.fromJson(linea)));
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

List<List<int>> obtenerMatriz(
    List<ModeloNodoJh> nodos, List<ModeloLineJh> lineas) {
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

List<int> calcularPesosEntrantes(
    List<ModeloNodoJh> vNodo, List<ModeloLineJh> vLinea) {
  List<int> pesosEntrantes = [];
  int origen = vNodo.indexWhere((nodo) => nodo.key == 0);
  List<List<int>> matriz = obtenerMatriz(vNodo, vLinea);
  List<int>? camino = dijkstra(matriz, origen);

  for (ModeloLineJh linea in vLinea) {
    int indiceDestino = vNodo.indexWhere((nodo) => nodo.key == linea.key2);
    int peso = camino![indiceDestino] - linea.peso.toInt();
    pesosEntrantes.add(peso);
    print(pesosEntrantes);
  }
  if (vNodo.length == vLinea.length) {
    pesosEntrantes.remove(0);
  }
  pesosEntrantes.add(camino![vNodo.length - 1]);
  return pesosEntrantes;
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
