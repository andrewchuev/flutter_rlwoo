import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/provider/user_provider.dart';

import 'cart.dart';
import 'models/user.dart';
import 'provider/woo_provider.dart';

PreferredSizeWidget WooAppBar(context) {
  return AppBar(
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('RLWoo'),

        FutureBuilder<User>(
          future: getUser(Provider.of<WooProvider>(context, listen: false).currentUserId),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${snapshot.data.userName} (${snapshot.data.email}) ${snapshot.data.firstName} ${snapshot.data.lastName}', style: TextStyle(fontSize: 12, color: Colors.black),)
                  ],
                )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.supervised_user_circle),
        onPressed: () {},
      ),
      Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 18,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF0C143),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                height: 15,
                width: 15,
                child: Center(
                  child: Consumer<WooProvider>(builder: (context, countOfProducts, child) {
                    return Text(
                      countOfProducts.productCount.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WooCart(),
                    ),
                  );
                },
                child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WooCart(),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
