import 'modelo_arbol.dart';
import 'dart:math' show max;

class Arbol {
  Nodo? _raiz;

  void insertarNodo(int elemento) {
    Nodo nuevo = new Nodo(elemento);
    if (_raiz == null) {
      _raiz = nuevo;
    } else {
      _raiz = nuevo.insertar(_raiz, nuevo);
    }
  }

  int altura(Nodo? n) {
    if (n == null) {
      return 0;
    }
    int altder = (n.derecha == null ? 0 : 1 + altura(n.derecha));
    int altizq = (n.izquierda == null ? 0 : 1 + altura(n.izquierda));
    return max(altder, altizq);
  }

  void resetArbol() {
    _raiz = null;
  }

  Nodo? get raiz {
    return _raiz;
  }

  set raiz(Nodo? n) {
    this._raiz = n;
  }

  List<int> preorderTraversal() {
    return _preorderTraversal(_raiz, []);
  }

  List<int> _preorderTraversal(Nodo? nodo, List<int> result) {
    if (nodo == null) {
      return result;
    }
    result.add(nodo.dato);
    _preorderTraversal(nodo.izquierda, result);
    _preorderTraversal(nodo.derecha, result);
    return result;
  }

  List<int> postorderTraversal() {
    return _postorderTraversal(_raiz, []);
  }

  List<int> _postorderTraversal(Nodo? nodo, List<int> result) {
    if (nodo == null) {
      return result;
    }
    _postorderTraversal(nodo.izquierda, result);
    _postorderTraversal(nodo.derecha, result);
    result.add(nodo.dato);
    return result;
  }
}
