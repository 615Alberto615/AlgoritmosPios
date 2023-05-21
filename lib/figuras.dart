import 'dart:math';
import 'package:flutter/material.dart';

import 'dij.dart';
import 'home.dart';
import 'modelos.dart';

class Nodos extends CustomPainter {
  List<ModeloNodo> vNodo;

  Nodos(this.vNodo);

  text(x, y, r, canvas) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 20);
    final TextSpan span = TextSpan(text: r, style: textStyle);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        text: msg);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = HexColor("#94B49F");
    Paint borde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = (3);

    vNodo.forEach((e) {
      canvas.drawCircle(Offset(e.x, e.y), e.radio, paint);
      canvas.drawCircle(Offset(e.x, e.y), e.radio, borde);
      _msg(e.x - 10, e.y - 5, e.nombre, canvas);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Line extends CustomPainter {
  List<ModeloLine> vLinea;
  Line(this.vLinea);
  //final List<int> caminoOptimo = dijkstra(nodoInicioSeleccionado, nodoDestinoSeleccionado);
  @override
  void paint(Canvas canvas, Size size) {
    _msg(double x, double y, String msg, Canvas canvas) {
      TextSpan span = TextSpan(
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          text: msg);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);

      tp.layout();
      tp.paint(canvas, Offset(x, y));
    }

    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final double arrowSize = 10;

    Path path = Path();

    vLinea.forEach((element) {
      paint.color = element.color;
      path.reset();
      path.moveTo(element.x1, element.y1);
      path.lineTo(element.x2, element.y2);
      _msg((element.x1 + element.x2) / 2, (element.y1 + element.y2) / 2,
          element.peso.toString(), canvas);

      double angle =
          atan2((element.y2 - element.y1), (element.x2 - element.x1));
      Path arrowPath = Path();
      arrowPath.moveTo(element.x2, element.y2);
      arrowPath.lineTo(element.x2 - arrowSize * cos(angle - pi / 7),
          element.y2 - arrowSize * sin(angle - pi / 7));
      arrowPath.lineTo(element.x2 - arrowSize * cos(angle + pi / 7),
          element.y2 - arrowSize * sin(angle + pi / 7));
      arrowPath.close();

      canvas.drawPath(path, paint);
      canvas.drawPath(arrowPath, paint);
      /*if (caminoOptimo.contains(element.key) &&
          caminoOptimo.contains(element.key2)) {
        // El segmento de línea está en el camino más óptimo, utilizar un color diferente
        paint.color = Colors.green;
      } else {
        // El segmento de línea no está en el camino más óptimo, utilizar el color normal
        paint.color = element.color;
      }*/
    });
  }

  @override
  bool shouldRepaint(Line oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Line oldDelegate) => false;
}

//algoritmos

class NodosJh extends CustomPainter {
  List<ModeloNodoJh> vNodojh;
  NodosJh(this.vNodojh);
  text(x, y, r, canvas) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 20);
    final TextSpan span = TextSpan(text: r, style: textStyle);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  text2(x, y, r, canvas) {
    final textStyle = TextStyle(color: Colors.black, fontSize: 20);
    final TextSpan span = TextSpan(text: r, style: textStyle);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        text: msg);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  void _drawVerticalLine(
      double x, double y, double length, Canvas canvas, Paint paint) {
    canvas.drawLine(
        Offset(x, y - length / 2), Offset(x, y + length / 2), paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = HexColor("#94B49F");
    Paint borde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = (3);

    vNodojh.forEach((e) {
      canvas.drawCircle(Offset(e.x, e.y), e.radio, paint);
      canvas.drawCircle(Offset(e.x, e.y), e.radio, borde);
      _msg(e.x - 10, e.y - 5, e.nombre, canvas);

      // Agregar dos números enteros debajo del nodo y separarlos por una línea horizontal
      double numberY = e.y + e.radio + 10;
      text2(e.x - 30, numberY, e.n1.toString(), canvas);
      text2(e.x + 10, numberY, e.n2.toString(),
          canvas); // Cambiar '34' al segundo número entero

      // Dibujar una línea horizontal entre los dos números
      //dibujar linea vertical
      _drawVerticalLine(e.x, numberY + 10, 30, canvas, borde);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Lij extends CustomPainter {
  List<ModeloLineJh> vLinea;
  Lij(this.vLinea);

  @override
  void paint(Canvas canvas, Size size) {
    _msg(double x, double y, String msg, Canvas canvas) {
      TextSpan span = TextSpan(
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          text: msg);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);

      tp.layout();
      tp.paint(canvas, Offset(x, y));
    }

    _msgBlue(double x, double y, String msg, Canvas canvas) {
      TextSpan span = TextSpan(
          style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          text: msg);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);

      tp.layout();
      tp.paint(canvas, Offset(x, y));
    }

    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final double arrowSize = 10;

    Path path = Path();

    vLinea.forEach((element) {
      path.reset();
      path.moveTo(element.x1, element.y1);
      path.lineTo(element.x2, element.y2);
      _msgBlue(
          (element.x1 + element.x2) / 2,
          (element.y1 + element.y2) / 2 - 20,
          "h: " + element.h.toString(),
          canvas);
      _msg((element.x1 + element.x2) / 2, (element.y1 + element.y2) / 2,
          element.peso.toString(), canvas);

      double angle =
          atan2((element.y2 - element.y1), (element.x2 - element.x1));
      Path arrowPath = Path();
      arrowPath.moveTo(element.x2, element.y2);
      arrowPath.lineTo(element.x2 - arrowSize * cos(angle - pi / 7),
          element.y2 - arrowSize * sin(angle - pi / 7));
      arrowPath.lineTo(element.x2 - arrowSize * cos(angle + pi / 7),
          element.y2 - arrowSize * sin(angle + pi / 7));
      arrowPath.close();

      canvas.drawPath(path, paint);
      canvas.drawPath(arrowPath, paint);
    });
  }

  @override
  bool shouldRepaint(Lij oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Lij oldDelegate) => false;
}

//nw
class NodosOr extends CustomPainter {
  List<ModeloNodonw> vNodo;
  NodosOr(this.vNodo);
  text(x, y, r, canvas) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 20);
    final TextSpan span = TextSpan(text: r, style: textStyle);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        text: msg);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = HexColor("#BAD7E9");
    Paint borde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = (3);

    vNodo.forEach((e) {
      canvas.drawCircle(Offset(e.x, e.y), e.radio, paint);
      canvas.drawCircle(Offset(e.x, e.y), e.radio, borde);
      _msg(e.x - 10, e.y - 5, e.nombre, canvas);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//des
class NodosDes extends CustomPainter {
  List<ModeloNodonw> vNodo;
  NodosDes(this.vNodo);
  text(x, y, r, canvas) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 20);
    final TextSpan span = TextSpan(text: r, style: textStyle);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        text: msg);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = HexColor("#FD8A8A");
    Paint borde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = (3);

    vNodo.forEach((e) {
      canvas.drawCircle(Offset(e.x, e.y), e.radio, paint);
      canvas.drawCircle(Offset(e.x, e.y), e.radio, borde);
      _msg(e.x - 10, e.y - 5, e.nombre, canvas);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
//asignacion

class NodosDesAsig extends CustomPainter {
  List<ModeloNodo> vNodo;
  NodosDesAsig(this.vNodo);
  text(x, y, r, canvas) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 20);
    final TextSpan span = TextSpan(text: r, style: textStyle);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        text: msg);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = HexColor("#FD8A8A");
    Paint borde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = (3);

    vNodo.forEach((e) {
      canvas.drawCircle(Offset(e.x, e.y), e.radio, paint);
      canvas.drawCircle(Offset(e.x, e.y), e.radio, borde);
      _msg(e.x - 10, e.y - 5, e.nombre, canvas);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class NodosOrAsig extends CustomPainter {
  List<ModeloNodo> vNodo;
  NodosOrAsig(this.vNodo);
  text(x, y, r, canvas) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 20);
    final TextSpan span = TextSpan(text: r, style: textStyle);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        text: msg);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = HexColor("#BAD7E9");
    Paint borde = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = (3);

    vNodo.forEach((e) {
      canvas.drawCircle(Offset(e.x, e.y), e.radio, paint);
      canvas.drawCircle(Offset(e.x, e.y), e.radio, borde);
      _msg(e.x - 10, e.y - 5, e.nombre, canvas);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//dij

class LineDij extends CustomPainter {
  List<ModeloLine> vLinea;
  List<int> caminoOptimo; // Campo para almacenar el camino óptimo

  LineDij(this.vLinea, this.caminoOptimo);
  //final List<int> caminoOptimo = dijkstra(nodoInicioSeleccionado, nodoDestinoSeleccionado);
  @override
  void paint(Canvas canvas, Size size) {
    _msg(double x, double y, String msg, Canvas canvas) {
      TextSpan span = TextSpan(
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          text: msg);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);

      tp.layout();
      tp.paint(canvas, Offset(x, y));
    }

    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final double arrowSize = 10;

    Path path = Path();

    vLinea.forEach((element) {
      paint.color = element.color;
      path.reset();
      path.moveTo(element.x1, element.y1);
      path.lineTo(element.x2, element.y2);
      _msg((element.x1 + element.x2) / 2, (element.y1 + element.y2) / 2,
          element.peso.toString(), canvas);

      double angle =
          atan2((element.y2 - element.y1), (element.x2 - element.x1));
      Path arrowPath = Path();
      arrowPath.moveTo(element.x2, element.y2);
      arrowPath.lineTo(element.x2 - arrowSize * cos(angle - pi / 7),
          element.y2 - arrowSize * sin(angle - pi / 7));
      arrowPath.lineTo(element.x2 - arrowSize * cos(angle + pi / 7),
          element.y2 - arrowSize * sin(angle + pi / 7));
      arrowPath.close();

      canvas.drawPath(path, paint);
      canvas.drawPath(arrowPath, paint);
      if (caminoOptimo.contains(element.key)) {
        // Cambiar el color de las líneas del camino óptimo
        paint.color = Colors.red; // Puedes cambiar el color a tu gusto
      } else {
        paint.color = element.color;
      }
    });
  }

  @override
  bool shouldRepaint(Line oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Line oldDelegate) => false;
}
