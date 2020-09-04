import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/app_bar.dart';
import 'package:woo/list_products.dart';
import 'package:woo/models/order.dart';
import 'package:woo/provider/woo_provider.dart';

class ThankYou extends StatefulWidget {
  final String orderNumber;

  ThankYou({Key key, @required this.orderNumber}) : super(key: key);

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WooAppBar(context),
      body: Column(
        children: [
          Text(
            'Thank you! Order #' + widget.orderNumber,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          FutureBuilder<Order>(
            future: getOrder(widget.orderNumber),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(snapshot.data.id.toString()),
                        Text(snapshot.data.billing['first_name']),
                        Text(snapshot.data.billing['last_name']),
                        Text(snapshot.data.billing['address_1']),
                        Text(snapshot.data.billing['city']),
                        Text(snapshot.data.billing['state']),
                        Text(snapshot.data.billing['postcode']),
                        Text(snapshot.data.billing['country']),
                        Text(snapshot.data.billing['email']),
                        Text(snapshot.data.billing['phone']),

                      ],
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
          FutureBuilder<Order>(
            future: getOrder(widget.orderNumber),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.lineItems.length,
                        itemBuilder: (context, i) {
                          return Text(snapshot.data.lineItems[i]['name'] + ' - ' + snapshot.data.lineItems[i]['price'].toString() );
                        }),
                  )
                  : Center(child: CircularProgressIndicator());
            },
          ),

          Consumer<WooProvider>(builder: (context, order, child) {
            return Text(
              'Total amount: ' + order.productTotal.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            );
          }),
          FlatButton(
            child: Text('Go shop'),
            color: Colors.black12,
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Products()));
            },
          )
        ],
      ),
    );
  }
}

Map<String, dynamic> getTextWidgets(List<dynamic> items) {
  Map items_list = {};

  items.forEach((element) {});
  //   Text(items[0]['name']),

  return items_list;
}
