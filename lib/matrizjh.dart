import 'package:flutter/material.dart';
import 'modelos.dart';

class verMatriz extends StatelessWidget {
  final List<ModeloNodoJh> nodos;
  final List<ModeloLineJh> lineas;

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
      content: Table(border: TableBorder.all(), children: [
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
    );
  }
}
