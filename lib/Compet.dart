import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:gf12/asignacion.dart';
import 'package:gf12/centroide.dart';
import 'package:gf12/nw.dart';
import 'package:path_provider/path_provider.dart';

import 'Sorts.dart';
import 'arboles.dart';
import 'ayuda.dart';
import 'dij.dart';
import 'figuras.dart';
import 'home.dart';
import 'jh.dart';
import 'kruskal.dart';
import 'matriz.dart';
import 'modelos.dart';

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

double peso = 0;
const MethodChannel _channel = MethodChannel('com.example.gf12/saveFile');

class Home7 extends StatefulWidget {
  const Home7({Key? key}) : super(key: key);

  @override
  State<Home7> createState() => _HomeState();
}

class _HomeState extends State<Home7> {
  List<double> centroide = []; // Variable para almacenar las coordenadas del centroide
  final nuevoNodo = TextEditingController();
  int modo = -1;
  int numNodo = 1;
  int keyline = 0;
  int keyline2 = 0;
  int keynodo = 0;
  ModeloNodo nodoinicio = ModeloNodo(-1, -1, 0, "-1", -1);
  List<ModeloNodo> vNodo = [];
  List<ModeloLine> vLinea = [];
  List<List<double>> data = [];

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
                      backgroundColor: Color(0xFFD3C8C8),
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
                  hintText: "compet",
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
                              for (ModeloLine linea in vLinea) {
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
                                vLinea.add(ModeloLine(
                                    nodoinicio.x + xd,
                                    nodoinicio.y + xd,
                                    xLlegada + xd,
                                    yLlegada + xd,
                                    peso,
                                    l1,
                                    l2,
                                    Colors.blue));
                              } else {
                                if (existeLinea2 == true) {
                                  vLinea.add(ModeloLine(
                                      xLlegada + xd,
                                      yLlegada + xd,
                                      xInicio + xd,
                                      yInicio + xd,
                                      peso,
                                      l1,
                                      l2,
                                      Colors.blue));
                                } else {
                                  if (existeLinea3 == true) {
                                    vLinea.add(ModeloLine(
                                        xInicio + xd,
                                        yInicio + xd,
                                        xLlegada + xd,
                                        yLlegada + xd,
                                        peso,
                                        l1,
                                        l2,
                                        Colors.blue));
                                  } else {
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
                              }
                              nodoinicio = ModeloNodo(-1, -1, 0, "-1", -1);
                            }
                          }
                        }
                      } else{
                        if (modo == 9) {
                            // Modo 9: Dibujar nodo del centroide
                            calcularCentroide();
                            if (centroide.isNotEmpty) {
                              vNodo.add(ModeloNodo(
                                centroide[0],
                                centroide[1],
                                35,
                                'Centroide',
                                keynodo));
                              numNodo++;
                              keynodo++;
                              print(centroide[0]);
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
                      if (modo == 500) {}
                    }
                  }
                  if (modo == 9) {
                    // Modo 9: Dibujar nodo del centroide
                    calcularCentroide();
                    if (centroide.isNotEmpty) {
                      vNodo.add(ModeloNodo(
                        centroide[0],
                        centroide[1],
                        35,
                        'Centroide',
                        keynodo));
                      numNodo++;
                      keynodo++;
                      print(centroide[0]);
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
                  /*IconButton(
                    icon: Icon(Icons.auto_graph_rounded),
                    tooltip: 'Enlazar nodos',
                    color: modo == 3 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        modo = 3;
                      });
                    },
                  ),*/
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
                    icon: Icon(Icons.calculate), // Reemplaza "my_icon" con el icono deseado
                    color: modo == 9 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      calcularCentroide();
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                VerCentroide(nodos: vNodo, centroideC: centroide));
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

  //------------------------------Compet----------------------------------
void calcularCentroide() {
  data = obtenerCoordenadasNodos();
  int k = 2;
  centroide = findCentroid(data, k);
  print("El centroide es: (${centroide[0]}, ${centroide[1]})");
  print(findCentroid(data, k));

}

List<List<double>> obtenerCoordenadasNodos() {
  List<List<double>> data = [];

  for (var nodo in vNodo) {
    data.add([nodo.x, nodo.y]);
  }

  return data;
}

List<double> findCentroid(List<List<double>> data, int k) {
  List<double> centroid = List.filled(data[0].length, 0.0);

  for (var i = 0; i < data.length; i++) {
    for (var j = 0; j < data[i].length; j++) {
      centroid[j] += data[i][j];
    }
  }

  for (var j = 0; j < centroid.length; j++) {
    centroid[j] /= data.length;
  }

  return centroid;
}
/*
  Future<void> guardarDatos() async {
    try {
      bool hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        print('Permiso de almacenamiento denegado');
        return;
      }

      final directory = await getExternalStorageDirectory();
      final fileName = 'data_${DateTime.now().toIso8601String()}.json';
      final filePath = '${directory!.path}/$fileName';
      final file = File(filePath);

      final data = {
        'nodos': vNodo.map((nodo) => nodo.toJson()).toList(),
        'lineas': vLinea.map((linea) => linea.toJson()).toList(),
      };

      final jsonData = json.encode(data);
      await file.writeAsString(jsonData);

      print('Datos guardados exitosamente');
      print('Ruta del archivo guardado: $filePath');
    } catch (e) {
      print('Error al guardar los datos: $e');
    }
  }

  Future<void> cargarDatos() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['json']);

      if (result != null) {
        final file = File(result.files.single.path!);
        final contents = await file.readAsString();
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
  }*/
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

/*
void johnson(List<ModeloNodo> vNodo, List<ModeloLine> vLinea) {
  double a = 0, b = 0, c = 0;
  String d = '';
  // Primero, agregamos un nodo virtual con aristas de peso 0 a todos los demás nodos
  ModeloNodo nodoVirtual = ModeloNodo(a, b, c, d);
  vNodo.add(nodoVirtual);
  for (int i = 0; i < vNodo.length - 1; i++) {
    vLinea.add(ModeloLine(a, b, vNodo[i].x, vNodo[i].y, 0));
  }

  // Luego, ejecutamos el algoritmo de Bellman-Ford en el grafo con el nodo virtual
  List<int> distancias = bellmanFord(nodoVirtual, vNodo, vLinea);
  if (distancias == null) {
    print('Error: el grafo contiene un ciclo negativo');
    return;
  }

  // Después, actualizamos los pesos de las aristas
  for (int i = 0; i < vLinea.length; i++) {
    vLinea[i].peso += distancias[vLinea[i].desde] - distancias[vLinea[i].hasta];
  }

  // Por último, ejecutamos Dijkstra para cada nodo en el grafo
  for (int i = 0; i < vNodo.length; i++) {
    List<int> distancias = dijkstra(vNodo[i], vNodo, vLinea);
    // Hacer lo que necesites con las distancias
  }
}

List<int> bellmanFord(
    ModeloNodo origen, List<ModeloNodo> vNodo, List<ModeloLine> vLinea) {
  // Inicializamos las distancias con infinito excepto para el origen que es 0
  List<int> distancias =
      List<int>.filled(vNodo.length, double.infinity.toInt());
  distancias[vNodo.indexOf(origen)] = 0;

  // Relaxamos las aristas vNodo.length - 1 veces
  for (int i = 0; i < vNodo.length - 1; i++) {
    for (int j = 0; j < vLinea.length; j++) {
      int u = vNodo.indexOf(vLinea[j].desde);
      int v = vNodo.indexOf(vLinea[j].hasta);
      int peso = vLinea[j].peso;
      if (distancias[u] + peso < distancias[v]) {
        distancias[v] = distancias[u] + peso;
      }
    }
  }

  // Verificamos si hay ciclos negativos
  for (int i = 0; i < vLinea.length; i++) {
    int u = vNodo.indexOf(vLinea[i].desde);
    int v = vNodo.indexOf(vLinea[i].hasta);
    int peso = vLinea[i].peso;
    if (distancias[u] + peso < distancias[v]) {
      return null;
    }
  }

  return distancias;
}

List<int> dijkstra(
    ModeloNodo origen, List<ModeloNodo> vNodo, List<ModeloLine> vLinea) {
// Inicializamos las distancias con infinito excepto para el origen que es 0
  List<int> distancias =
      List<int>.filled(vNodo.length, double.infinity.toInt());
  distancias[vNodo.indexOf(origen)] = 0;

// Creamos un conjunto de nodos visitados y un conjunto de nodos por visitar
  Set<int> nodosVisitados = Set<int>();
  Set<int> nodosPorVisitar =
      Set<int>.from(List<int>.generate(vNodo.length, (i) => i));

  while (nodosPorVisitar.isNotEmpty) {
// Buscamos el nodo no visitado con la distancia más corta
    int nodoActual = nodosPorVisitar.reduce((nodo1, nodo2) =>
        distancias[nodo1] < distancias[nodo2] ? nodo1 : nodo2);
// Agregamos el nodo actual a los visitados y lo eliminamos de los nodos por visitar
    nodosVisitados.add(nodoActual);
    nodosPorVisitar.remove(nodoActual);

// Relaxamos las aristas adyacentes al nodo actual
    for (int i = 0; i < vLinea.length; i++) {
      int u = vNodo.indexOf(vLinea[i].desde);
      int v = vNodo.indexOf(vLinea[i].hasta);
      int peso = vLinea[i].peso;
      if (u == nodoActual &&
          !nodosVisitados.contains(v) &&
          distancias[u] != double.infinity.toInt() &&
          distancias[u] + peso < distancias[v]) {
        distancias[v] = distancias[u] + peso;
      }
    }
  }

  return distancias;
}
*/