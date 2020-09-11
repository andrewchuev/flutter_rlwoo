import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:woo/models/product.dart';
import 'package:woo/models/user.dart';
import 'package:woo/provider/woo_provider.dart';
import 'package:woo/thankyou.dart';

class Order {
  final int id;
  final String number;
  final Map<String, dynamic> billing;
  final List<dynamic> lineItems;

  Order({this.id, this.number, this.billing, this.lineItems});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      number: json['number'] as String,
      billing: json['billing'] as Map<String, dynamic>,
      lineItems: json['line_items'] as List <dynamic>,
    );
  }
}

Future getLineItems (String orderId) async {
  List<Widget> items = [];
  Order order = await getOrder(orderId);
  List<dynamic> lineItems = order.lineItems;
  print('********** items *************');

  lineItems.forEach((i) {
    print('\n\n$i\n');
    print(i['id']);
    print(i['name']);
    print(i['price']);
    items.add(Text('${i['id']} - ${i['name']} ${i['price']}'));
  });
  //print(jsonDecode(lineItems[0]));


  return lineItems;
}

Future createOrder(context) async {
  var client = http.Client();
  User user;
  String url = 'https://woo.reslab.cc/wp-json/wc/v3/orders';
  String params = '?consumer_key=ck_b871b5c35d7a77bd09ccfeeaf2afe24d9914b599&consumer_secret=cs_5811bcaa677652d3864dcc46fd4bc13f57c35a57';

  user = Provider.of<WooProvider>(context, listen: false).currentUserInfo;
  print('\n\n******** billing *********\n\n');
  print(user.billing);

  var items = getCart(context);
  String lineItem = '';
  for (var item in items) {
    lineItem += '{ "product_id": ${item.id}, "quantity": 1 }, ';
  }
  lineItem = lineItem.substring(0, lineItem.length - 2);
  String body = '''{
    "payment_method": "cod",
    "payment_method_title": "Cash on delivery",
    "set_paid": true,
    "billing": {
      "first_name": "${user.billing['first_name']}",
      "last_name": "${user.billing['last_name']}",
      "address_1": "${user.billing['address_1']}",
      "address_2": "",
      "city": "${user.billing['city']}",
      "state": "${user.billing['state']}",
      "postcode": "${user.billing['postcode']}",
      "country": "${user.billing['country']}",
      "email": "${user.billing['email']}",
      "phone": "${user.billing['phone']}"
    },
    "shipping": {
      "first_name": "John",
      "last_name": "Doe",
      "address_1": "969 Market",
      "address_2": "",
      "city": "San Francisco",
      "state": "CA",
      "postcode": "94103",
      "country": "US"
    },
    "line_items": [
      ${lineItem}
    ]
  }''';

  print(body);

  var response = await http.post(url + params,
      headers: {
        'Content-type': 'application/json',
      },
      body: body);
  print('Response status: ${response.statusCode}');
  if (response.statusCode == 500) {
    Map<String, dynamic> order = jsonDecode(response.body);
    print('\n\nOrder exist or error\n\n');
    print(order);
  } else if (response.statusCode == 201) {
    Map<String, dynamic> order = jsonDecode(response.body);
    print('\n\nNew order\n\n');
    //print('Response body: ${response.body}');
    //Provider.of<WooProvider>(context, listen: false).clearCart();
    String orderNumber = order['number'];
    Navigator.push(context, MaterialPageRoute(builder: (context) => ThankYou(orderNumber: orderNumber)));
  }
  client.close();
  return response;
}

List<Product> getCart(context) {
  List<Product> pList = Provider.of<WooProvider>(context, listen: false).productList;
  print(pList);
  return pList;
}

Future<Order> getOrder(String orderId) async {
  print('orderId = $orderId');
  var client = http.Client();
  String url = 'https://woo.reslab.cc/wp-json/wc/v3/orders/$orderId/';
  String params = '?consumer_key=ck_b871b5c35d7a77bd09ccfeeaf2afe24d9914b599&consumer_secret=cs_5811bcaa677652d3864dcc46fd4bc13f57c35a57';
  var response = await http.get(url + params, headers: {'Content-type': 'application/json'});
  var orderObj = Order.fromJson(jsonDecode(response.body));

  //getLineItems(orderObj.lineItems);
  client.close();
  return orderObj;
}
