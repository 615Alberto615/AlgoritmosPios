import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gf12/modelos.dart';
import 'matrizasig.dart';

class matrizNW extends StatelessWidget {
  final List<ModeloNodonw> nodosD;
  final List<ModeloNodonw> nodosO;
  final List<ModeloLine> lineas;

  matrizNW({required this.nodosO, required this.nodosD, required this.lineas});

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
          // Solo verificar si la línea sale del nodo
          if (key1 == nodosO[i].key && key2 == nodosD[j].key) {
            valor = lineas[k].peso.toInt();
            break;
          }
        }
        fila.add(valor);
      }
      matriz.add(fila);
    }
    List<int> demandas = [];
    for (int i = 0; i < nodosD.length; i++) {
      demandas.add(nodosD[i].atri);
    }
    List<int> ofertas = [];
    for (int i = 0; i < nodosO.length; i++) {
      ofertas.add(nodosO[i].atri);
    }
    print("paso");
    print(matriz);
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
            TableCell(
              child: Text("Ofertas"),
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
                  child: matriz[i][j] == 0
                      ? Text("${matriz[i][j]}",
                          style: TextStyle(color: Colors.green))
                      : Text("${matriz[i][j]}"),
                ),
              TableCell(child: Text("${ofertas[i]}"))
            ],
          ),
        TableRow(
          children: [
            TableCell(
              child: Text("Demandas"),
            ),
            for (var i = 0; i < nodosD.length; i++)
              TableCell(
                child: Text("${nodosD[i].atri}"),
              ),
            TableCell(child: Text(""))
          ],
        ),
      ]),
    );
  }
}

class matrizNWSolve extends StatelessWidget {
  final List<ModeloNodonw> nodosD;
  final List<ModeloNodonw> nodosO;
  final List<ModeloLine> lineas;
  final bool mod;

  matrizNWSolve(
      {required this.nodosO,
      required this.nodosD,
      required this.lineas,
      required this.mod});

  @override
  Widget build(BuildContext context) {
    String titulo = "";
    List<List<int>> matriz = [];
    for (int i = 0; i < nodosO.length; i++) {
      List<int> fila = [];
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
        fila.add(valor);
      }
      matriz.add(fila);
    }
    List<int> demandas = [];
    for (int i = 0; i < nodosD.length; i++) {
      demandas.add(nodosD[i].atri);
    }
    List<int> ofertas = [];
    for (int i = 0; i < nodosO.length; i++) {
      ofertas.add(nodosO[i].atri);
    }
    print("paso");
    print(matriz);
    // Mandamos modo elegido
    List<List<num>> assignment = [];
    //...
    int maxValue = getMaxValue(matriz);

    if (mod) {
      // SI MAXIMIZA
      List<List<int>> invertedMatrix = invertMatrixValues(matriz, maxValue);
      assignment =
          northwestCornerMethodMinimization(ofertas, demandas, invertedMatrix);
      titulo = "Maximizar";
      print(assignment);
    } else {
      // Si minimiza
      assignment = northwestCornerMethodMinimization(ofertas, demandas, matriz);
      titulo = "Minimizar";
      print(assignment);
    }

    double totalCost = 0;
    for (int i = 0; i < ofertas.length; i++) {
      for (int j = 0; j < demandas.length; j++) {
        int cost = mod ? maxValue - matriz[i][j] : matriz[i][j];
        totalCost += assignment[i][j] * cost;
      }
    }

    print('Costo total: $totalCost');

    return AlertDialog(
        title: Text("Matriz de Adyacencia " + titulo),
        content: Column(
          children: [
            Table(border: TableBorder.all(), children: [
              TableRow(
                children: [
                  TableCell(
                    child: Text(""),
                  ),
                  for (var i = 0; i < nodosD.length; i++)
                    TableCell(
                      child: Text("${nodosD[i].nombre}"),
                    ),
                  TableCell(
                    child: Text("Ofertas"),
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
                        child: matriz[i][j] == 0
                            ? Text("${matriz[i][j]}",
                                style: TextStyle(color: Colors.green))
                            : Text("${matriz[i][j]}"),
                      ),
                    TableCell(child: Text("${nodosO[i].atri}")) // Cambio aquí
                  ],
                ),
              TableRow(
                children: [
                  TableCell(
                    child: Text("Demandas"),
                  ),
                  for (var i = 0; i < nodosD.length; i++)
                    TableCell(
                      child: Text("${nodosD[i].atri}"),
                    ),
                  TableCell(child: Text(""))
                ],
              ),
            ]),
            SizedBox(
              height: 10,
              width: 30,
            ), // Agrega un espacio vertical de 20 píxeles
            Column(
              children: [
                Text("Costo total (Atrri): $totalCost"),

                // Agrega más Widgets de ser necesario
              ],
            ),
          ],
        ));
  }
}
// Metodo NorOeste

List<List<num>> northwestCornerMethod(List<num> supplies, List<num> demands,
    List<List<num>> costs, bool maximize) {
  int m = supplies.length;
  int n = demands.length;

  // Crear matriz de asignación inicial con ceros
  List<List<num>> assignment =
      List.generate(m, (_) => List.generate(n, (_) => 0));

  int i = 0;
  int j = 0;

  // Mientras haya oferta y demanda no satisfecha
  while (i < m && j < n) {
    // Calcular el costo unitario de asignación en la celda actual
    num cost = costs[i][j];

    // Si se busca maximizar, convertir el costo a negativo para minimizar el costo total
    if (maximize) {
      cost = -cost;
    }

    // Asignar la cantidad mínima entre la oferta y demanda no satisfecha
    if (supplies[i] < demands[j]) {
      assignment[i][j] = supplies[i];
      demands[j] -= supplies[i];
      supplies[i] = 0;
      i++;
    } else {
      assignment[i][j] = demands[j];
      supplies[i] -= demands[j];
      demands[j] = 0;
      j++;
    }
  }

  return assignment;
}

//MINIMIZACION
/*List<List<num>> northwestCornerMethodMinimization(
    List<int> ofertas, List<int> demandas, List<List<int>> matriz) {
  List<List<num>> assignment = List.generate(
      ofertas.length, (index) => List.generate(demandas.length, (index) => 0));

  int i = 0;
  int j = 0;

  while (i < ofertas.length && j < demandas.length) {
    int minVal = min(ofertas[i], demandas[j]);
    assignment[i][j] = minVal;

    ofertas[i] -= minVal;
    demandas[j] -= minVal;

    if (ofertas[i] == 0) {
      i++;
    } else {
      j++;
    }
  }

  return assignment;
}*/

List<List<num>> northwestCornerMethodMinimization(
    List<int> ofertas, List<int> demandas, List<List<int>> matriz) {
  List<List<num>> assignment = List.generate(
      ofertas.length, (index) => List.generate(demandas.length, (index) => 0));

  int i = 0;
  int j = 0;
  int m = ofertas.length;
  int n = demandas.length;

  while (i < m && j < n) {
    int minVal = min(ofertas[i], demandas[j]);
    assignment[i][j] = minVal;

    matriz[i][j] = minVal; // Modificar el valor original de la matriz

    ofertas[i] -= minVal;
    demandas[j] -= minVal;

    if (ofertas[i] == 0) {
      i++;
    } else {
      j++;
    }
  }

  return assignment;
}

//
int getMaxValue(List<List<int>> matriz) {
  int maxValue = 0;
  for (final fila in matriz) {
    for (final valor in fila) {
      maxValue = max(maxValue, valor);
    }
  }
  return maxValue;
}

List<List<int>> invertMatrixValues(List<List<int>> matriz, int maxValue) {
  List<List<int>> invertedMatrix = [];
  for (final fila in matriz) {
    List<int> newRow = [];
    for (final valor in fila) {
      newRow.add(maxValue - valor);
    }
    invertedMatrix.add(newRow);
  }
  return invertedMatrix;
}
