import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/app_bar.dart';
import 'package:flutter_html/flutter_html.dart';

import 'models/product.dart';
import 'provider/woo_provider.dart';

class SingleProduct extends StatefulWidget {
  final int productId;

  SingleProduct({Key key, @required this.productId}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WooAppBar(context, 'Single product'),
      body: Container(
        child: FutureBuilder<Product>(
          future: fetchProduct(widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.network(
                            snapshot.data.thumbnailUrl,
                            height: 300,
                          ),
                        ),
                        Text(
                          snapshot.data.name,
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text('\$' + snapshot.data.price),
                        ),
                        FlatButton(
                          child: Text('Add to cart'),
                          color: Colors.black12,
                          onPressed: () {
                            Provider.of<WooProvider>(context, listen: false).increaseProductList(snapshot.data);
                            print('add to cart');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text('Description', style: TextStyle(fontSize: 18),),
                        ),
                        Html(
                          data: snapshot.data.description,
                          padding: EdgeInsets.all(8),
                        ),
                      ],
                    ),
                )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
