import 'package:flutter/material.dart';
import 'home.dart';

class Ayuda extends StatefulWidget {
  const Ayuda({super.key});

  @override
  State<Ayuda> createState() => _AyudaState();
}

class _AyudaState extends State<Ayuda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F2E7D5"),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Ayuda"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite agregar un nuevo nodo a la pantalla de dibujo. Al presionarlo, se mostrará un nuevo nodo en la pantalla que se puede eliminar y editar."),
            IconButton(
              icon: Icon(Icons.auto_graph_rounded),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite conectar los nodos con una línea y asignar un valor determinado por el usuario."),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite eliminar los nodos seleccionados y las líneas que conectan con dichos nodos."),
            IconButton(
              icon: Icon(Icons.delete_sweep),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite eliminar las líneas que unen a los nodos, al presionar sobre la punta de la flecha de dirección."),
            IconButton(
              icon: Icon(Icons.data_array_sharp),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón despliega una alerta con la matriz de adyacencia de los nodos y sus conexiones."),
            IconButton(
              icon: Icon(Icons.edit_outlined),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite editar el nombre del nodo al presionar sobre el nodo."),
            IconButton(
              icon: Icon(Icons.layers_clear_sharp),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón elimina o limpia toda la pantalla, eliminando todos los nodos y líneas."),
            IconButton(
              icon: Icon(Icons.save),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite guardar el grafo en pantalla en la carpeta de descargas."),
            IconButton(
              icon: Icon(Icons.folder_open),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite seleccionar un archivo json que contenga un grafo."),
            IconButton(
              icon: Icon(Icons.select_all_sharp),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite seleccionar un nodo de Inicio para el algoritmo de Dijkstra."),
            IconButton(
              icon: Icon(Icons.start),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite seleccionar un nodo de Destino para el algoritmo de Dijkstra."),
            IconButton(
              icon: Icon(Icons.data_object_outlined),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón calcula el camino más corto entre el nodo de Inicio y el nodo de Destino, mediante el algoritmo de Dijkstra."),
          ],
        ),
      ),
    );
  }
}
