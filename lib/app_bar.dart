import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'models/user.dart';
import 'provider/woo_provider.dart';

PreferredSizeWidget WooAppBar(context, title) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () {},
      ),
      Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF0C143),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15),
                    right: Radius.circular(15),
                  ),
                ),
                height: 15,
                width: 50,
                child: Center(
                  child: Consumer<WooProvider>(builder: (context, userInfo, child) {
                    return Text(
                      userInfo.currentUserInfo.userName,
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
                    icon: Icon(Icons.supervised_user_circle),
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
