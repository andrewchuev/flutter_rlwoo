import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/app_bar.dart';
import 'package:woo/checkout.dart';
import 'package:woo/provider/woo_provider.dart';

import 'models/user.dart';


class WooCart extends StatefulWidget {
  @override
  _WooCartState createState() => _WooCartState();
}

class _WooCartState extends State<WooCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WooAppBar(context, 'Cart'),
      body: Container(
          child: Column(
         //crossAxisAlignment: CrossAxisAlignment.end,
         //mainAxisAlignment: MainAxisAlignment.end,

        children: [

          Consumer<WooProvider>(builder: (context, prod, child) {
            return Expanded(
              child: ListView.builder(
                itemCount: prod.productList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red,),
                          onPressed: () {Provider.of<WooProvider>(context, listen: false).removeFromCart(prod.productList[i]);},
                        ),
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
              title: Text('Total count: '),
              trailing: Text('${countOfProducts.productCount}'),
            );
          }),
          Consumer<WooProvider>(builder: (context, amount, child) {
            return ListTile(
              title: Text('Amount: '),
              trailing: Text('\$${amount.productTotal}'),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text('Checkout'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WooCheckout()));
              },
              color: Colors.black12,
            ),
          )
        ],
      )),
    );
  }
}

