import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProducts() async {
  var client = http.Client();
  String url = 'https://woo.reslab.pro/wp-json/wc/v3/products/';
  String params = '/?consumer_key=ck_be69348004c013e605a4f25064bb1add2e7c8af6&consumer_secret=cs_260c82209f3552f3db2d3838c5c255a7f343d3b3';
  final response = await client.get(url + params);
  // print(response.body);
  client.close();
  return parseProducts(response.body);
}

List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}



Future<Product> fetchProduct(int productId) async {
  var client = http.Client();
  String url = 'https://woo.reslab.pro/wp-json/wc/v3/products/';
  String params = '/?consumer_key=ck_be69348004c013e605a4f25064bb1add2e7c8af6&consumer_secret=cs_260c82209f3552f3db2d3838c5c255a7f343d3b3';
  final response = await client.get(url + productId.toString() + params);
  //print(response.body);
  client.close();
  return Product.fromJson(jsonDecode(response.body));
}

class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String thumbnailUrl;

  Product({this.id, this.name, this.description, this.price, this.thumbnailUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      thumbnailUrl: json['images'][0]['src'] as String,
    );
  }
}

Future<void> getProduct() async {
  var url =
      'https://woo.reslab.pro/wp-json/wc/v3/products/38/?consumer_key=ck_be69348004c013e605a4f25064bb1add2e7c8af6&consumer_secret=cs_260c82209f3552f3db2d3838c5c255a7f343d3b3';
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
