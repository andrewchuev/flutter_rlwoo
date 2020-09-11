import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/app_bar.dart';
import 'package:woo/list_products.dart';
import 'package:woo/models/order.dart';
import 'package:woo/provider/woo_provider.dart';
import 'package:woo/style.dart';

class ThankYou extends StatefulWidget {
  final String orderNumber;
  final Map<String, String> orderHeaderFields = {
    'First name': 'first_name',
    'Last name': 'last_name',
    'Address': 'address_1',
    'City': 'city',
    'State': 'state',
    'Postcode': 'postcode',
    'Country': 'country',
    'Email': 'email',
    'Phone': 'phone',
  };

  ThankYou({Key key, @required this.orderNumber}) : super(key: key);

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WooAppBar(context, 'Thank you!'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Order #${widget.orderNumber} complete',
              style: h1,
            ),
          ),
          FutureBuilder<Order>(
            future: getOrder(widget.orderNumber),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        border: TableBorder.all(color: Colors.black26, width: 1, style: BorderStyle.solid),
                        children: orderHeader(snapshot.data.billing, widget.orderHeaderFields)),
                  )
                  : Center(child: CircularProgressIndicator());
            },
          ),
          FutureBuilder<Order>(
            future: getOrder(widget.orderNumber),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                    border: TableBorder.all(color: Colors.black26, width: 1, style: BorderStyle.solid),
                    children: orderItems(snapshot.data.lineItems)),
                  )
                  : Center(child: CircularProgressIndicator());
            },
          ),
          Consumer<WooProvider>(builder: (context, order, child) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerRight,
              child: Text(
                'Total amount: ' + order.productTotal.toString(),
                style: h2,
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text('Go shop'),
              color: Colors.black12,
              onPressed: () {
                Provider.of<WooProvider>(context, listen: false).clearCart();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Products()));
              },
            ),
          )
        ],
      ),
    );
  }
}

List<TableRow> orderHeader(var data, fields) {
  List<TableRow> rows = [];
  for (var item in fields.entries) {
    var row = TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(item.key),
      ),
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(data[item.value] != null ? data[item.value] : ''),
      ),
    ]);
    rows.add(row);
  }
  return rows;
}

List<TableRow> orderItems(List<dynamic> data) {
  List<TableRow> rows = [];

  for (int i = 0; i < data.length; i++) {
    var row = TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(data[i]['name']),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(3.0),
        child: Text('\$' + data[i]['price'].toString()),
      ),
    ]);
    rows.add(row);
  }
  return rows;
}
