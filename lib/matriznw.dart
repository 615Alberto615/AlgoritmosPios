import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gf12/modelos.dart';

class matrizNWSolve extends StatelessWidget {
  final List<ModeloNodonw> nodosD;
  final List<ModeloNodonw> nodosO;
  final List<ModeloLine> lineas;
  final bool mod;

  matrizNWSolve({
    required this.nodosO,
    required this.nodosD,
    required this.lineas,
    required this.mod,
  });

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

    int maxValue = getMaxValue(matriz);

    List<List<num>> assignment = [];
    List<List<int>> calculationMatrix =
        []; // Matriz utilizada para el cálculo del costo
    double totalCost = 0;

    if (mod) {
      List<List<int>> invertedMatrix = invertMatrixValues(matriz, maxValue);
      assignment =
          northwestCornerMethodMinimization(ofertas, demandas, invertedMatrix);
      calculationMatrix = invertedMatrix;
      titulo = "Maximización";
    } else {
      assignment = northwestCornerMethodMinimization(ofertas, demandas, matriz);
      calculationMatrix = matriz;
      titulo = "Minimización";
    }

    totalCost = calculateTotalCost(calculationMatrix, assignment);

    print('Costo total: $totalCost');

    return AlertDialog(
      title: Text("Matriz de Adyacencia $titulo"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              border: TableBorder.all(),
              children:
                  generateTable(nodosO, nodosD, matriz, "Matriz Original"),
            ),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(),
              children: generateTable(
                  nodosO,
                  nodosD,
                  assignment
                      .map((i) => i.map((j) => j.toInt()).toList())
                      .toList(),
                  "Matriz de Asignación"),
            ),
            SizedBox(height: 10),
            Text("Costo total: $totalCost"),
          ],
        ),
      ),
    );
  }

  List<TableRow> generateTable(List<ModeloNodonw> nodosO,
      List<ModeloNodonw> nodosD, List<List<int>> matriz, String title) {
    return [
      TableRow(
        children: [
          TableCell(child: Text(title)),
          for (var nodoD in nodosD) TableCell(child: Text(nodoD.nombre)),
          TableCell(child: Text("Ofertas")),
        ],
      ),
      for (var i = 0; i < nodosO.length; i++)
        TableRow(
          children: [
            TableCell(child: Text(nodosO[i].nombre)),
            for (var j = 0; j < nodosD.length; j++)
              TableCell(
                child: Text(
                  "${matriz[i][j]}",
                  style: TextStyle(
                      color: matriz[i][j] == 0 ? Colors.green : Colors.black),
                ),
              ),
            TableCell(child: Text("${nodosO[i].atri}")),
          ],
        ),
      TableRow(
        children: [
          TableCell(child: Text("Demandas")),
          for (var i = 0; i < nodosD.length; i++)
            TableCell(child: Text("${nodosD[i].atri}")),
          TableCell(child: Text("")),
        ],
      ),
    ];
  }

  List<List<num>> northwestCornerMethodMinimization(
      List<int> ofertas, List<int> demandas, List<List<int>> matriz) {
    List<List<num>> assignment = List.generate(
        ofertas.length, (_) => List.generate(demandas.length, (_) => 0));
    int i = 0, j = 0;
    while (i < ofertas.length && j < demandas.length) {
      int minVal = min(ofertas[i], demandas[j]);
      assignment[i][j] = minVal;
      ofertas[i] -= minVal;
      demandas[j] -= minVal;
      if (ofertas[i] == 0) i++;
      if (demandas[j] == 0) j++;
    }
    return assignment;
  }

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

  double calculateTotalCost(
      List<List<int>> matriz, List<List<num>> assignment) {
    double totalCost = 0;
    for (int i = 0; i < assignment.length; i++) {
      for (int j = 0; j < assignment[i].length; j++) {
        totalCost += assignment[i][j] * matriz[i][j];
      }
    }
    return totalCost;
  }
}
