import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/models/product.dart';
import 'package:woo/models/user.dart';

class UserProvider extends FutureProvider {
  User _currentUserInfo;
  get currentUserInfo => getUser(3);

  Future<User> getCurrentUser() async {
    _currentUserInfo = await getUser(3);
    return _currentUserInfo;
  }


}