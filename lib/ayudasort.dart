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
              icon: Icon(Icons.select_all_sharp),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este boton permite hacer la ordenación mediante Selection Sort"),
            IconButton(
              icon: Icon(Icons.insert_page_break_sharp),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite hacer la ordenación mediante Insertion Sort"),
            IconButton(
              icon: Icon(Icons.merge_type_sharp),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text("Este botón permite hacer la ordenacion medinate Merge Sort"),
            IconButton(
              icon: Icon(Icons.shield_moon),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text("Este botón permite hacer la ordenación mediante Shell Sort"),
            IconButton(
              icon: Icon(Icons.layers_clear_sharp),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text("Estte boton permite limpiar toda la pantalla"),
            IconButton(
              icon: Icon(Icons.radar),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text("Este botón permite realizar numeros numeros randomicos."),
            IconButton(
              icon: Icon(Icons.publish_outlined),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
            Text(
                "Este botón permite ingresar los numeros que deseas para poder organizarlos"),
            IconButton(
              icon: Icon(Icons.summarize_outlined),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
