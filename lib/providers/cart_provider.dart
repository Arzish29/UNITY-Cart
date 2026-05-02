import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => subtotal > 999 ? 0 : 99;

  double get total => subtotal + deliveryFee;

  void addItem(Product product, {String size = '', String color = ''}) {
    final idx = _items.indexWhere(
        (i) => i.product.id == product.id && i.selectedSize == size);
    if (idx >= 0) {
      _items[idx].quantity++;
    } else {
      _items.add(CartItem(
        product: product,
        selectedSize: size.isEmpty && product.sizes.isNotEmpty
            ? product.sizes.first
            : size,
        selectedColor: color.isEmpty && product.colors.isNotEmpty
            ? product.colors.first
            : color,
      ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int qty) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx >= 0) {
      if (qty <= 0) {
        _items.removeAt(idx);
      } else {
        _items[idx].quantity = qty;
      }
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool containsProduct(String productId) =>
      _items.any((i) => i.product.id == productId);
}
