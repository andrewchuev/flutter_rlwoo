import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/app_bar.dart';
import 'package:woo/provider/woo_provider.dart';
import 'package:woo/models/order.dart';
import 'package:woo/style.dart';

import 'models/user.dart';

class WooCheckout extends StatefulWidget {
  @override
  _WooCheckoutState createState() => _WooCheckoutState();
}

class _WooCheckoutState extends State<WooCheckout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WooAppBar(context, 'Checkout'),
      body: Container(
          child: Column(
        children: [
          Consumer<WooProvider>(builder: (context, prod, child) {
            return Expanded(
              child: ListView.builder(
                itemCount: prod.productList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(prod.productList[i].name),
                      ],
                    ),
                    trailing: Text('\$' + prod.productList[i].price),
                  );
                },
              ),
            );
          }),
          Consumer<WooProvider>(builder: (context, countOfProducts, child) {
            return ListTile(
              title: Text('Total count: ', style: h2,),
              trailing: Text('${countOfProducts.productCount}', style: h2,),
            );
          }),
          Consumer<WooProvider>(builder: (context, amount, child) {
            return ListTile(
              title: Text('Total amount: ', style: h2,),
              trailing: Text('\$${amount.productTotal}', style: h2,),
            );
          }),
          FlatButton(
            child: Text('Pay'),
            onPressed: () {
              createOrder(context);
            },
            color: Colors.black12,
          )
        ],
      )),
    );
  }
}
