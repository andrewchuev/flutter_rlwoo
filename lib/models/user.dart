import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:woo/provider/woo_provider.dart';

class User {
  final int id;
  final String email;
  final String userName;
  final String firstName;
  final String lastName;
  final Map<String, dynamic> billing;

  User({this.id, this.email, this.userName, this.firstName, this.lastName, this.billing});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      userName: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      billing: json['billing'] as Map<String, dynamic>,
    );
  }
}

Future createUser() async {
  var client = http.Client();
  String url = 'https://woo.reslab.pro/wp-json/wc/v3/customers';
  String params = '?consumer_key=ck_be69348004c013e605a4f25064bb1add2e7c8af6&consumer_secret=cs_260c82209f3552f3db2d3838c5c255a7f343d3b3';
  String body = '''{
    "email": "john.doe@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "username": "john.doe",
    "billing": {
      "first_name": "John",
      "last_name": "Doe",
      "company": "",
      "address_1": "969 Market",
      "address_2": "",
      "city": "San Francisco",
      "state": "CA",
      "postcode": "94103",
      "country": "US",
      "email": "john.doe@example.com",
      "phone": "(555) 555-5555"
    },
    "shipping": {
      "first_name": "John",
      "last_name": "Doe",
      "company": "",
      "address_1": "969 Market",
      "address_2": "",
      "city": "San Francisco",
      "state": "CA",
      "postcode": "94103",
      "country": "US"
    }
  }''';
  var response = await http.post(url + params, headers: {'Content-type': 'application/json'}, body: body);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  print('\n\nNew user\n\n');
  Map<String, dynamic> user = jsonDecode(response.body);
  client.close();
  return response;
}

Future<User> getUser(int userId) async {
  var client = http.Client();
  String url = 'https://woo.reslab.pro/wp-json/wc/v3/customers/$userId';
  String params = '?consumer_key=ck_be69348004c013e605a4f25064bb1add2e7c8af6&consumer_secret=cs_260c82209f3552f3db2d3838c5c255a7f343d3b3';
  var response = await http.get(url + params, headers: {'Content-type': 'application/json'});
  print('\n\n********** getUser ************\n\n');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var userObj = User.fromJson(jsonDecode(response.body));
  print(userObj.firstName);
  client.close();
  // Provider.of<WooProvider>(, listen: false).currentUserInfo = userObj;
  return userObj;
}
