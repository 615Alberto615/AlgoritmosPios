class Nodo {
  late int _dato;
  Nodo? _izquierda;
  Nodo? _derecha;

  Nodo(int elemento) {
    this._dato = elemento;
    _izquierda = null;
    _derecha = null;
  }

  Nodo? insertar(Nodo? raiz, Nodo nuevo) {
    if (raiz == null) {
      raiz = nuevo;
    } else if (raiz._dato > nuevo._dato) {
      raiz._izquierda = insertar(raiz._izquierda, nuevo);
    } else if (raiz._dato < nuevo._dato) {
      raiz._derecha = insertar(raiz._derecha, nuevo);
    }
    return raiz;
  }

  int get dato {
    return _dato;
  }

  set dato(int elemento) {
    this._dato = elemento;
  }

  Nodo? get izquierda {
    return _izquierda;
  }

  set izquierda(Nodo? nodo) {
    this._izquierda = nodo;
  }

  Nodo? get derecha {
    return _derecha;
  }

  set derecha(Nodo? nodo) {
    this._derecha = nodo;
  }
}
