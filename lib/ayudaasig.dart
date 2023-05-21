import 'package:flutter/material.dart';

import 'home.dart';

class AyudaAsig extends StatefulWidget {
  const AyudaAsig({super.key});

  @override
  State<AyudaAsig> createState() => _AyudaAsigState();
}

class _AyudaAsigState extends State<AyudaAsig> {
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
                "Este botón permite agregar un nuevo nodo origen a la pantalla de dibujo. Al presionarlo, se mostrará un nuevo nodo en la pantalla que se puede eliminar y editar."),
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
              icon: Icon(Icons.maximize),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite iniciar la funcion de maximizacion de la matriz de adyacencia creada por los nodos y sus conexiones, obteniendo como resultado la asignacion optima de los nodos de origen con los nodos de destino"),
            IconButton(
              icon: Icon(Icons.minimize),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite iniciar la funcion de minimizacion de la matriz de adyacencia creada por los nodos y sus conexiones, obteniendo como resultado la asignacion optima de los nodos de origen con los nodos de destino"),
            IconButton(
              icon: Icon(Icons.add_alarm_rounded),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite agregar un nuevo nodo de destino a la pantalla de dibujo. Al presionarlo, se mostrará un nuevo nodo en la pantalla que se puede eliminar y editar."),
          ],
        ),
      ),
    );
  }
}
