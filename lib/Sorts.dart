import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:gf12/asignacion.dart';
import 'package:gf12/home.dart';
import 'package:gf12/nw.dart';
import 'package:path_provider/path_provider.dart';

import 'Compet.dart';
import 'arboles.dart';
import 'ayudasort.dart';
import 'dij.dart';
import 'figuras.dart';
import 'jh.dart';
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

int peso = 0;
const MethodChannel _channel = MethodChannel('com.example.gf12/saveFile');

class Home5 extends StatefulWidget {
  const Home5({Key? key}) : super(key: key);

  @override
  State<Home5> createState() => _HomeState();
}

class _HomeState extends State<Home5> with TickerProviderStateMixin {
  final nuevoNodo = TextEditingController();
  final stopwatch = Stopwatch();
  int modo = -1;
  int numNodo = 1;
  int keyline = 0;
  int keyline2 = 0;
  int keynodo = 0;
  ModeloNodo nodoinicio = ModeloNodo(-1, -1, 0, "-1", -1);
  List<ModeloNodo> vNodo = [];
  List<ModeloLine> vLinea = [];
  List<int> numeros = [];
  List<int> sortNumeros = [];
  final numerosController = TextEditingController();
  late AnimationController _controller;
  late AnimatedListState _listState;
  Duration elapsed = Duration();
  bool isPlaying = false;
  bool isPaused = false;
  int elapsedSeconds = 0;
  String sortTitle = '';
  @override
  void _startTimer() {
    setState(() {
      isPlaying = true;
      elapsedSeconds = 0;
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          elapsedSeconds++;
        });
        if (!isPlaying) {
          timer.cancel();
        }
      });
    });
  }

  void _selectionSort() async {
    setState(() {
      isPlaying = true;
      isPaused = false;
    });
    sortNumeros = await SelectionSort.sort(List.from(numeros), setState);
    sortTitle = 'Selection Sort';
    setState(() {
      isPlaying = false;
      isPaused = true;
    });
  }

  void _insertionSort() async {
    setState(() {
      isPlaying = true;
      isPaused = false;
    });
    sortNumeros = await InsertionSort.sort(List.from(numeros), setState);
    sortTitle = 'Insertion Sort';
    setState(() {
      isPlaying = false;
      isPaused = true;
    });
  }

  void _margeSort() async {
    setState(() {
      isPlaying = true;
      isPaused = false;
    });
    sortNumeros = await MergeSort.sort(List.from(numeros), setState);
    sortTitle = 'Merge Sort';
    setState(() {
      isPlaying = false;
      isPaused = true;
    });
  }

  void _shellSort() async {
    setState(() {
      isPaused = false;
      isPlaying = true;
    });
    sortNumeros = await ShellSort.sort(List.from(numeros), setState);
    sortTitle = 'Shell Sort';
    setState(() {
      isPlaying = false;
      isPaused = true;
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          final cantidadController = TextEditingController();
          final numerosIngresadosController = TextEditingController();

          return (AlertDialog(
            title: Text("Ingresar Numeros"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: cantidadController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cantidad de Numeros',
                  ),
                ),
                TextField(
                  controller: numerosIngresadosController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numeros (separados por una coma)',
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar")),
              ElevatedButton(
                onPressed: () {
                  final cantidad = int.parse(cantidadController.text);
                  final numerosIngresados = numerosIngresadosController.text
                      .split(",")
                      .map((e) => int.parse(e))
                      .toList();
                  if (cantidad == null || numerosIngresados.contains(null)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Ingrese todos los datos"),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }
                  setState(() {
                    numeros = numerosIngresados.toList();
                  });
                  Navigator.pop(context);
                },
                child: Text("Aceptar"),
              )
            ],
          ));
        }));
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: numerosController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: 'Cantidad de numeros aleatorios',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        numeros =
                            RandomNumberGenerator.generar(int.parse(value));
                      });
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 40,
              child: Text(
                sortTitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //if (isPlaying)
            Positioned(
              top: 30,
              right: 30,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isPlaying
                      ? 'Tiempo: $elapsedSeconds s'
                      : 'Tiempo: $elapsedSeconds',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: numeros.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 50,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${numeros[index]}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 400),
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sortNumeros.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 50,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${sortNumeros[index]}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }),
            ),
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
                    icon: Icon(Icons.select_all_sharp),
                    tooltip: 'Selection Sort',
                    color: modo == 1 ? Colors.green.shade300 : Colors.white,
                    onPressed: (() {
                      _selectionSort();
                      _startTimer();
                    }),
                  ),
                  IconButton(
                      icon: Icon(Icons.insert_page_break_sharp),
                      tooltip: 'Insertion Sort',
                      color: modo == 3 ? Colors.green.shade300 : Colors.white,
                      onPressed: (() {
                        _insertionSort();
                        _startTimer();
                      })),
                  IconButton(
                      icon: Icon(Icons.merge_type_sharp),
                      // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                      tooltip: 'Merge Sort',
                      color: modo == 4 ? Colors.green.shade300 : Colors.white,
                      onPressed: (() {
                        _margeSort();
                        _startTimer();
                      })),
                  IconButton(
                      icon: Icon(Icons.shield_moon),
                      // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                      tooltip: 'Shell Sort',
                      color: modo == 5 ? Colors.green.shade300 : Colors.white,
                      onPressed: (() {
                        _shellSort();
                        _startTimer();
                      })),
                  IconButton(
                    icon: Icon(Icons.layers_clear_sharp),
                    tooltip: 'Limpiar',
                    // si el modo es 5 entonces el color del icono sera verde de lo contrario sera rojo
                    color: modo == 8 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        numeros.clear();
                        sortNumeros.clear();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.radar),
                    tooltip: 'Aleatorio',
                    color: modo == 7 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        numeros.clear();
                        sortNumeros.clear();
                        numeros = RandomNumberGenerator.generar(
                            int.parse(numerosController.text));
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.publish_outlined),
                    tooltip: 'Ingresar Datos',
                    color: modo == 6 ? Colors.green.shade300 : Colors.white,
                    onPressed: () {
                      setState(() {
                        _showDialog(context);
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
              ),
            ],
          ),
        ),
      ),
    );
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

class RandomNumberGenerator {
  static List<int> generar(int count) {
    Random random = new Random();
    List<int> numeros = [];
    for (int i = 0; i < count; i++) {
      numeros.add(random.nextInt(100));
    }
    print(numeros);
    return numeros;
  }
}

class SelectionSort {
  static Future<List<int>> sort(List<int> numeros, Function setState) async {
    int len = numeros.length;
    for (int i = 0; i < len - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < len; j++) {
        if (numeros[j] < numeros[minIndex]) {
          minIndex = j;
        }
      }
      if (minIndex != i) {
        int temp = numeros[i];
        numeros[i] = numeros[minIndex];
        numeros[minIndex] = temp;
      }
      setState(() {});
      await Future.delayed(Duration(milliseconds: 500));
      print(numeros);
    }
    return numeros;
  }
}

class InsertionSort {
  static Future<List<int>> sort(List<int> numeros, Function setState) async {
    int len = numeros.length;
    for (int i = 0; i < len; i++) {
      int key = numeros[i];
      int j = i - 1;
      while (j >= 0 && numeros[j] > key) {
        numeros[j + 1] = numeros[j];
        j--;
      }
      numeros[j + 1] = key;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 500));
    }
    print(numeros);
    return numeros;
  }
}

class MergeSort {
  static Future<List<int>> sort(List<int> numeros, Function setState) async {
    if (numeros.length <= 1) {
      return numeros;
    }
    int medio = (numeros.length / 2).floor();
    List<int> izquierda = numeros.sublist(0, medio);
    List<int> derecha = numeros.sublist(medio);

    izquierda = await sort(izquierda, setState);
    derecha = await sort(derecha, setState);
    print(izquierda);
    print(derecha);
    return await merge(izquierda, derecha, setState);
  }

  static Future<List<int>> merge(
      List<int> izquierda, List<int> derecha, Function setState) async {
    List<int> resultado = [];
    int i = 0;
    int j = 0;
    while (i < izquierda.length && j < derecha.length) {
      if (izquierda[i] < derecha[j]) {
        resultado.add(izquierda[i]);
        i++;
      } else {
        resultado.add(derecha[j]);
        j++;
      }
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
    }
    resultado.addAll(izquierda.sublist(i));
    resultado.addAll(derecha.sublist(j));
    setState(() {});
    await Future.delayed(Duration(milliseconds: 100));
    print(resultado);
    return resultado;
  }
}

class ShellSort {
  static Future<List<int>> sort(List<int> numeros, Function setState) async {
    int len = numeros.length;
    int gap = (len / 2).floor();

    while (gap > 0) {
      for (int i = gap; i < len; i++) {
        int temp = numeros[i];
        int j = i;

        while (j >= gap && numeros[j - gap] > temp) {
          numeros[j] = numeros[j - gap];
          j -= gap;
        }
        numeros[j] = temp;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
      }
      gap = (gap / 2).floor();
    }
    print(numeros);
    return numeros;
  }
}
