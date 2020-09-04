

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/models/user.dart';
import 'package:woo/provider/user_provider.dart';
import 'package:woo/provider/woo_provider.dart';

import 'list_products.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => WooProvider(),
    ),
  ], child: WooApp()));
}

class WooApp extends StatefulWidget {
  @override
  _WooAppState createState() => _WooAppState();
}

class _WooAppState extends State<WooApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Products(),
    );
  }
}
