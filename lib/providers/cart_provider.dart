import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int itemCount = 0; // Número de ítems
  double totalPrice = 0.0; // Precio total

  // Método para agregar un producto al carrito
  void addItem(double price) {
    itemCount++;
    totalPrice += price;
    notifyListeners();
  }

  // Método para eliminar un producto (opcional)
  void removeItem(double price) {
    if (itemCount > 0) {
      itemCount--;
      totalPrice -= price;
      notifyListeners();
    }
  }

  // Método para vaciar el carrito
  void clearCart() {
    itemCount = 0;
    totalPrice = 0.0;
    notifyListeners();
  }
}
