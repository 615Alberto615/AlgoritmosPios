import 'dart:math';

import 'package:flutter/material.dart';

class ModeloNodo {
  double _x, _y, _radio;
  String _nombre;
  int _key;

  ModeloNodo(this._x, this._y, this._radio, this._nombre, this._key);

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  get radio => _radio;

  set radio(value) {
    _radio = value;
  }

  int get key => _key;

  set key(int value) {
    _key = value;
  }

  get y => _y;

  set y(value) {
    _y = value;
  }

  double get x => _x;

  set x(double value) {
    _x = value;
  }

  bool dentro(double x, double y) {
    double dx = x - _x;
    double dy = y - _y;
    double distancia = sqrt(dx * dx + dy * dy);
    return distancia <= _radio;
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'radio': radio,
        'nombre': nombre,
        'key': key,
      };

  factory ModeloNodo.fromJson(Map<String, dynamic> json) => ModeloNodo(
        json['x'],
        json['y'],
        json['radio'],
        json['nombre'],
        json['key'] ??
            0, // Proporcionar un valor predeterminado en caso de que 'key' sea nulo
      );
}

class ModeloLine {
  double _x1, _y1, _x2, _y2, _peso;
  int _key, _key2;
  Color _color;
  ModeloLine(this._x1, this._y1, this._x2, this._y2, this._peso, this._key,
      this._key2, this._color);
  double get peso => _peso;
  set peso(double value) {
    _peso = value;
  }

  Color get color => _color;
  set color(Color value) {
    _color = value;
  }

  double get y2 => _y2;
  set y2(double value) {
    _y2 = value;
  }

  double get x2 => _x2;
  set x2(double value) {
    _x2 = value;
  }

  double get y1 => _y1;
  set y1(double value) {
    _y1 = value;
  }

  int get key => _key;
  set key(int value) {
    _key = value;
  }

  int get key2 => _key2;
  set key2(int value) {
    _key2 = value;
  }

  double get x1 => _x1;
  set x1(double value) {
    _x1 = value;
  }

  Map<String, dynamic> toJson() => {
        'x1': x1,
        'y1': y1,
        'x2': x2,
        'y2': y2,
        'peso': peso,
        'key': key,
        'key2': key2,
        'color': color.value,
      };

  factory ModeloLine.fromJson(Map<String, dynamic> json) => ModeloLine(
        json['x1'],
        json['y1'],
        json['x2'],
        json['y2'],
        json['peso'],
        json['key'] ?? 0,
        json['key2'] ?? 0,
        Color(json['color'] ?? Colors.black.value),
      );
}

class ModeloLine2 {
  double _x1, _y1, _x2, _y2, _peso;
  ModeloLine2(this._x1, this._y1, this._x2, this._y2, this._peso);
  double get peso => _peso;
  set peso(double value) {
    _peso = value;
  }

  double get y2 => _y2;
  set y2(double value) {
    _y2 = value;
  }

  double get x2 => _x2;
  set x2(double value) {
    _x2 = value;
  }

  double get y1 => _y1;
  set y1(double value) {
    _y1 = value;
  }

  double get x1 => _x1;
  set x1(double value) {
    _x1 = value;
  }
}

class ModeloLinePath {
  final Path path;
  final double peso;

  ModeloLinePath(this.path, this.peso);
}

class Matriz {
  final List<List<int>> datos;

  const Matriz(this.datos);
}

//algoritmos
class ModeloGrafo {
  List<ModeloNodo> nodos;
  List<ModeloLine> aristas;

  ModeloGrafo(this.nodos, this.aristas);
}

class ModeloNodoJh {
  double _x, _y, _radio;
  String _nombre;
  int _n1, _n2;
  int _key;

  ModeloNodoJh(this._x, this._y, this._radio, this._nombre, this._n1, this._n2,
      this._key);

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  get radio => _radio;

  set radio(value) {
    _radio = value;
  }

  int get key => _key;

  set key(int value) {
    _key = value;
  }

  int get n1 => _n1;

  set n1(int value) {
    _n1 = value;
  }

  int get n2 => _n2;

  set n2(int value) {
    _n2 = value;
  }

  get y => _y;

  set y(value) {
    _y = value;
  }

  double get x => _x;

  set x(double value) {
    _x = value;
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'radio': radio,
        'nombre': nombre,
        'n1': n1,
        'n2': n2,
        'key': key,
      };

  factory ModeloNodoJh.fromJson(Map<String, dynamic> json) => ModeloNodoJh(
        json['x'],
        json['y'],
        json['radio'],
        json['nombre'],
        json['n1'] ?? 0,
        json['n2'] ?? 0,
        json['key'] ??
            0, // Proporcionar un valor predeterminado en caso de que 'key' sea nulo
      );
}

class ModeloLineJh {
  double _x1, _y1, _x2, _y2, _peso, _h;
  int _key, _key2;
  ModeloLineJh(this._x1, this._y1, this._x2, this._y2, this._peso, this._h,
      this._key, this._key2);
  double get peso => _peso;
  set peso(double value) {
    _peso = value;
  }

  double get h => _h;
  set h(double value) {
    _h = value;
  }

  double get y2 => _y2;
  set y2(double value) {
    _y2 = value;
  }

  double get x2 => _x2;
  set x2(double value) {
    _x2 = value;
  }

  double get y1 => _y1;
  set y1(double value) {
    _y1 = value;
  }

  int get key => _key;
  set key(int value) {
    _key = value;
  }

  int get key2 => _key2;
  set key2(int value) {
    _key2 = value;
  }

  double get x1 => _x1;
  set x1(double value) {
    _x1 = value;
  }

  Map<String, dynamic> toJson() => {
        'x1': x1,
        'y1': y1,
        'x2': x2,
        'y2': y2,
        'peso': peso,
        'h': h,
        'key': key,
        'key2': key2,
      };

  factory ModeloLineJh.fromJson(Map<String, dynamic> json) => ModeloLineJh(
        json['x1'],
        json['y1'],
        json['x2'],
        json['y2'],
        json['peso'] ?? 0,
        json['h'] ?? 0,
        json['key'] ?? 0,
        json['key2'] ?? 0,
      );
}
// nw

class ModeloNodoOrg {
  double _x, _y, _radio;
  String _nombre;
  int _key;

  ModeloNodoOrg(this._x, this._y, this._radio, this._nombre, this._key);

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  get radio => _radio;

  set radio(value) {
    _radio = value;
  }

  int get key => _key;

  set key(int value) {
    _key = value;
  }

  get y => _y;

  set y(value) {
    _y = value;
  }

  double get x => _x;

  set x(double value) {
    _x = value;
  }
}

class ModeloNodonw {
  double _x, _y, _radio;
  int _atri;
  String _nombre;
  int _key;

  ModeloNodonw(
      this._x, this._y, this._radio, this._nombre, this._atri, this._key);

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  get radio => _radio;

  set radio(value) {
    _radio = value;
  }

  int get key => _key;

  set key(int value) {
    _key = value;
  }

  get y => _y;

  set y(value) {
    _y = value;
  }

  get atri => _atri;

  set atri(value) {
    _atri = value;
  }

  double get x => _x;

  set x(double value) {
    _x = value;
  }

  bool dentro(double x, double y) {
    double dx = x - _x;
    double dy = y - _y;
    double distancia = sqrt(dx * dx + dy * dy);
    return distancia <= _radio;
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'radio': radio,
        'nombre': nombre,
        'atri': atri,
        'key': key,
      };

  factory ModeloNodonw.fromJson(Map<String, dynamic> json) => ModeloNodonw(
        json['x'],
        json['y'],
        json['radio'] ?? 0,
        json['nombre'] ?? "",
        json['atri'] ?? 0,
        json['key'] ??
            0, // Proporcionar un valor predeterminado en caso de que 'key' sea nulo
      );
}
