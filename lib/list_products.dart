import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/provider/woo_provider.dart';
import 'package:woo/single_product.dart';

import 'app_bar.dart';

import 'models/product.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    //getProduct();
    return Scaffold(
      appBar: WooAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: FutureBuilder<List<Product>>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ? ProductsList(products: snapshot.data) : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SingleProduct(productId: products[index].id)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Image.network(
                    products[index].thumbnailUrl,
                    height: 85,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  products[index].name,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Text(
                '\$' + products[index].price,
                style: TextStyle(fontSize: 10),
              ),
              FlatButton(
                onPressed: () {

                  Provider.of<WooProvider>(context, listen: false).increaseProductList(products[index]);
                  print('add to cart');
                },
                child: Text('Add to cart', style: TextStyle(fontSize: 10)),
                color: Colors.black12,
              )
            ],
          ),
        );
      },
    );
  }
}
