import 'package:flutter/material.dart';
import 'modelos.dart';

class VerCentroide extends StatelessWidget {
  final List<ModeloNodo> nodos;
  final List<double> centroideC;

  VerCentroide({required this.nodos, required this.centroideC});

  @override
  Widget build(BuildContext context) {
    List<List<String>> matriz = [];
    List<List<String>> matrizCentroide = [];
    // Crear la matriz con las coordenadas de cada nodo
    for (var nodo in nodos) {
      matriz.add(['${nodo.x - 40}', '${nodo.y - 170}']);
    }
    matrizCentroide.add(['${centroideC[0] - 40}', '${centroideC[1] - 170}']);

    return AlertDialog(
      title: Text('Cálculo Algoritmo Compet'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Coordenadas de los Nodos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            DataTable(
              columns: [
                DataColumn(label: Text('Nodo')),
                DataColumn(label: Text('Coordenada X')),
                DataColumn(label: Text('Coordenada Y')),
              ],
              rows: List<DataRow>.generate(
                matriz.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text('${index + 1}')),
                    DataCell(Text(matriz[index][0])),
                    DataCell(Text(matriz[index][1])),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Coordenadas del Centroide',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            DataTable(
              columns: [
                DataColumn(label: Text('')),
                DataColumn(label: Text('Coordenada X')),
                DataColumn(label: Text('Coordenada Y')),
              ],
              rows: List<DataRow>.generate(
                matrizCentroide.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text('Centroide')),
                    DataCell(Text(matrizCentroide[index][0])),
                    DataCell(Text(matrizCentroide[index][1])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
