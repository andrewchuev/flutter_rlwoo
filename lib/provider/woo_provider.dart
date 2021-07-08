import 'package:flutter/material.dart';
import 'package:woo/models/product.dart';
import 'package:woo/models/user.dart';

class WooProvider extends ChangeNotifier {
  int _productCount = 0;
  double _productTotal = 0;
  List<Product> _productList = [];
  int _currentUserId = 2;
  User _currentUserInfo;

  void removeFromCart(Product product) {
    _productCount--;
    _productList.remove(product);
    _productTotal -= double.parse(product.price);
    notifyListeners();
  }

  void clearCart() {
    _productCount = 0;
    _productTotal = 0;
    _productList = [];
    notifyListeners();
  }

  void increaseProductList(Product product) {
    _productCount++;
    _productList.add(product);
    _productTotal += double.parse(product.price);
    notifyListeners();
  }

  void getUserInfo() async {
    _currentUserInfo = await getUser(_currentUserId);
    notifyListeners();
  }

  User get currentUserInfo => _currentUserInfo;

  int get productCount => _productCount;

  double get productTotal => _productTotal;

  List<Product> get productList => _productList;

  /*void getCurrentUserInfo() {
    _currentUserInfo = getUser(_currentUserId);
    notifyListeners();
  }*/

  int get currentUserId => _currentUserId;

  set currentUserInfo(userId) => getUser(userId);
}
