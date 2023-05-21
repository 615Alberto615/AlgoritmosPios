import 'dart:math';

import 'package:flutter/material.dart';
import 'modelos.dart';

class verMatriz extends StatelessWidget {
  final List<ModeloNodo> nodos;
  final List<ModeloLine> lineas;

  verMatriz({required this.nodos, required this.lineas});

  @override
  Widget build(BuildContext context) {
    List<List<String>> matriz = [];
    for (int i = 0; i < nodos.length; i++) {
      List<String> fila = [];
      for (int j = 0; j < nodos.length; j++) {
        int valor = 0;
        for (int k = 0; k < lineas.length; k++) {
          int key1 = lineas[k].key;
          int key2 = lineas[k].key2;
          // Solo verificar si la línea sale del nodo
          if (key1 == nodos[i].key && key2 == nodos[j].key) {
            valor = lineas[k].peso.toInt();
            break;
          }
        }
        fila.add(valor.toString());
      }

      matriz.add(fila);
    }
    return AlertDialog(
      title: Text("Matriz de Adyacencia"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Table(border: TableBorder.all(), children: [
            TableRow(
              children: [
                TableCell(
                  child: Text(""),
                ),
                for (var i = 0; i < nodos.length; i++)
                  TableCell(
                    child: Text("${nodos[i].nombre}"),
                  ),
              ],
            ),
            for (var i = 0; i < nodos.length; i++)
              TableRow(
                children: [
                  TableCell(
                    child: Text("${nodos[i].nombre}"),
                  ),
                  for (var j = 0; j < nodos.length; j++)
                    TableCell(
                      child: Text("${matriz[i][j]}"),
                    ),
                ],
              ),
          ]),
          SizedBox(height: 16.0),
          Text('Costo Total: ${calcularCosto(matriz)}'),
        ],
      ),
    );
  }

  num calcularCosto(List<List<String>> costMatrix) {
    num total = 0;

    for (int i = 0; i < costMatrix.length; i++) {
      for (int j = 0; j < costMatrix[i].length; j++) {
        total += int.parse(costMatrix[i][j]);
      }
    }

    return total;
  }
}

class matrizAsig extends StatelessWidget {
  final List<ModeloNodo> nodosD;
  final List<ModeloNodo> nodosO;
  final List<ModeloLine> lineas;

  matrizAsig(
      {required this.nodosO, required this.nodosD, required this.lineas});

  @override
  Widget build(BuildContext context) {
    List<List<String>> matriz = [];
    for (int i = 0; i < nodosO.length; i++) {
      List<String> fila = [];
      for (int j = 0; j < nodosD.length; j++) {
        int valor = 0;
        for (int k = 0; k < lineas.length; k++) {
          int key1 = lineas[k].key;
          int key2 = lineas[k].key2;
          // Solo verificar si la línea sale del nodo
          if (key1 == nodosO[i].key && key2 == nodosD[j].key) {
            valor = lineas[k].peso.toInt();
            break;
          }
        }
        fila.add(valor.toString());
      }

      matriz.add(fila);
    }

    return AlertDialog(
      title: Text("Matriz de Adyacencia"),
      content: Table(border: TableBorder.all(), children: [
        TableRow(
          children: [
            TableCell(
              child: Text(""),
            ),
            for (var i = 0; i < nodosD.length; i++)
              TableCell(
                child: Text("${nodosD[i].nombre}"),
              ),
          ],
        ),
        for (var i = 0; i < nodosO.length; i++)
          TableRow(
            children: [
              TableCell(
                child: Text("${nodosO[i].nombre}"),
              ),
              for (var j = 0; j < nodosO.length; j++)
                TableCell(
                  child: Text("${matriz[i][j]}"),
                ),
              SizedBox(height: 16.0),
              Text('Costo Total: ${calcularCosto(matriz)}'),
            ],
          ),
      ]),
    );
  }

  num calcularCosto(List<List<String>> costMatrix) {
    num total = 0;

    for (int i = 0; i < costMatrix.length; i++) {
      for (int j = 0; j < costMatrix[i].length; j++) {
        total += int.parse(costMatrix[i][j]);
      }
    }

    return total;
  }
}

class matrizAsigMax extends StatelessWidget {
  final List<ModeloNodo> nodosD;
  final List<ModeloNodo> nodosO;
  final List<ModeloLine> lineas;
  final bool mod;

  matrizAsigMax(
      {required this.nodosO,
      required this.nodosD,
      required this.lineas,
      required this.mod});

  @override
  Widget build(BuildContext context) {
    List<List<int>> matriz = [];
    for (int i = 0; i < nodosO.length; i++) {
      List<int> fila = [];
      for (int j = 0; j < nodosD.length; j++) {
        int valor = 0;
        for (int k = 0; k < lineas.length; k++) {
          int key1 = lineas[k].key;
          int key2 = lineas[k].key2;
          if (key1 == nodosO[i].key && key2 == nodosD[j].key) {
            valor = lineas[k].peso.toInt();
            break;
          }
        }
        fila.add(valor);
      }
      matriz.add(fila);
    }

    List<List<int>> assignments = [];
    List<List<int>> assignmentsx = [];
    List<List<int>> min = [];
    assignments =
        List.generate(matriz.length, (i) => List.filled(matriz[0].length, 0));

    String titulo = "";

    if (mod) {
      List<int> assignment2 = assignOptimal(matriz, maximize: true);
      for (int i = 0; i < assignment2.length; i++) {
        assignments[i][assignment2[i]] = 1;
      }
      print('Asignación óptima (maximizar): $assignment2');
      print('Matriz de asignaciones (maximizar):\n${assignments.toString()}');
      titulo = "Matriz de adyacencia (Maximizacion)";
    } else {
      // Minimizar
      List<int> assignment1 = assignOptimal(matriz, maximize: false);
      for (int i = 0; i < assignment1.length; i++) {
        assignments[i][assignment1[i]] = 1;
      }
      print('Asignación óptima (minimizar): $assignment1');
      print('Matriz de asignaciones (minimizar):\n${assignments.toString()}');
      titulo = "Matriz de adyacencia (Minimizacion)";
    }

    return AlertDialog(
      title: Text(titulo),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(""),
                    ),
                    for (var i = 0; i < nodosD.length; i++)
                      TableCell(
                        child: Text("${nodosD[i].nombre}"),
                      ),
                  ],
                ),
                for (var i = 0; i < nodosO.length; i++)
                  TableRow(
                    children: [
                      TableCell(
                        child: Text("${nodosO[i].nombre}"),
                      ),
                      for (var j = 0; j < nodosD.length; j++)
                        TableCell(
                          child: Text(
                            "${assignments[i][j] == 0 ? '0'.padLeft(3) : assignments[i][j].toString().padLeft(3)}",
                            style: TextStyle(
                                color: assignments[i][j] == 0
                                    ? Colors.green
                                    : null),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Costo total: ${calcularCostoTotal(matriz, assignments, mod)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  num calcularCostoTotal(
      List<List<int>> costMatrix, List<List<int>> assignments, bool maximize) {
    num total = 0;

    for (int i = 0; i < costMatrix.length; i++) {
      for (int j = 0; j < costMatrix[i].length; j++) {
        int value = costMatrix[i][j];
        if (maximize) {
          value = costMatrix[i].reduce(max) - value;
        }
        total += value * assignments[i][j];
      }
    }

    return total;
  }
}

List<int> assignOptimal(List<List<int>> costMatrix, {bool maximize = false}) {
  int n = costMatrix.length;

  for (int i = 0; i < n; i++) {
    int value;
    if (maximize) {
      value = costMatrix[i].reduce(max);
      for (int j = 0; j < n; j++) {
        costMatrix[i][j] = value - costMatrix[i][j];
      }
    } else {
      value = costMatrix[i].reduce(min);
      for (int j = 0; j < n; j++) {
        costMatrix[i][j] -= value;
      }
    }
  }

  for (int j = 0; j < n; j++) {
    List<int> column = [];
    for (int i = 0; i < n; i++) {
      column.add(costMatrix[i][j]);
    }
    int value;
    if (maximize) {
      value = column.reduce(max);
      for (int i = 0; i < n; i++) {
        costMatrix[i][j] = value - costMatrix[i][j];
      }
    } else {
      value = column.reduce(min);
      for (int i = 0; i < n; i++) {
        costMatrix[i][j] -= value;
      }
    }
  }

  List<int> assignment = List<int>.filled(n, -1);
  List<bool> rowUsed = List<bool>.filled(n, false);
  List<bool> colUsed = List<bool>.filled(n, false);

  for (int k = 0; k < n; k++) {
    for (int i = 0; i < n; i++) {
      if (rowUsed[i]) continue;
      for (int j = 0; j < n; j++) {
        if (colUsed[j]) continue;
        if (costMatrix[i][j] == 0) {
          assignment[i] = j;
          rowUsed[i] = true;
          colUsed[j] = true;
          break;
        }
      }
    }
  }

  return assignment;
}

List<List<int>> assignOptimalMin(List<List<int>> costMatrix) {
  print("fff ${costMatrix}");
  List<List<int>> assignmentmin = [];
  for (int i = 0; i < costMatrix.length; i++) {
    for (int j = 0; j < costMatrix[0].length; j++) {
      if (costMatrix[i][j] == 1) {
        costMatrix[i][j] = 0;
      } else {
        costMatrix[i][j] = 1;
      }
    }
  }
  print(costMatrix);
  return costMatrix;
}
