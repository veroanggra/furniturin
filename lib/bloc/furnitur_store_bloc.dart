import 'package:flutter/material.dart';
import 'package:furniturin/models/furnitur_products.dart';

enum FurniturState { normal, details, cart }

class FurniturStoreBloc with ChangeNotifier {
  FurniturState furniturState = FurniturState.normal;
  List<FurniturProduct> catalog = List.unmodifiable(furniturProducts);
  List<FurniturProductItem> cart = [];

  void changeToNormal() {
    furniturState = FurniturState.normal;
    notifyListeners();
  }

  void changeToCart() {
    furniturState = FurniturState.cart;
    notifyListeners();
  }

  void deleteProduct(FurniturProductItem productItem) {
    cart.remove(productItem);
    notifyListeners();
  }

  void addProduct(FurniturProduct product) {
    for (FurniturProductItem item in cart) {
      if (item.product.name == product.name) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(FurniturProductItem(product: product));
    notifyListeners();
  }

  int totalCartElements() => cart.fold<int>(
      0, (previousValue, element) => previousValue + element.quantity);

  double totalPriceElements() => cart.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue + (element.quantity * element.product.price));
}

class FurniturProductItem {
  FurniturProductItem({this.quantity = 1, @required this.product});

  int quantity;
  final FurniturProduct product;

  void increment() {
    quantity++;
  }

  void decrement() {}
}
