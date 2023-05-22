import 'package:flutter/material.dart';

import 'home.dart';

class AyudaArbol extends StatefulWidget {
  const AyudaArbol({super.key});

  @override
  State<AyudaArbol> createState() => _AyudaArbolState();
}

class _AyudaArbolState extends State<AyudaArbol> {
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
                "Este botón permite agregar el nodo del valor que haya introducido en la pantalla y agrega un nuevo nodo."),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text("Este botón permite eliminar todo el espacio de trabajo ."),
          ],
        ),
      ),
    );
  }
}
