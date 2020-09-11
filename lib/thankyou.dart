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
      appBar: WooAppBar(context, 'Order complete'),
      body: Column(
        children: [
          Text(
            'Thank you!',
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
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Odrer No'),
                          Text(snapshot.data.id.toString()),
                        ]),
                        ListTile(
                          title: Text('First Name'),
                          trailing: Text(snapshot.data.billing['first_name']),
                        ),
                        ListTile(
                          title: Text('Last Name'),
                          trailing: Text(snapshot.data.billing['last_name']),
                        ),
                        ListTile(
                          title: Text('Address'),
                          trailing: Text(snapshot.data.billing['address_1']),
                        ),
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
                            return Text(snapshot.data.lineItems[i]['name'] + ' - ' + snapshot.data.lineItems[i]['price'].toString());
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
              Provider.of<WooProvider>(context, listen: false).clearCart();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Products()));
            },
          )
        ],
      ),
    );
  }
}



List<Widget> orderHeader(snapshot) {
  List<Widget> items = [];
  Map<String, String> fields = {
    'First name': 'first_name',
    'Last name': 'last_name',
    'Address': 'address',
    'City': 'city',
    'State': 'state',
    'Postcode': 'postcode',
    'Country': 'country',
    'Email': 'email',
    'Phone': 'phone',
  };

  for(var item in fields.entries){
    print("${item.key} - ${item.value}");
    items.add(tableRow(item.key, item.value));
  }

  return items;
}

Widget tableRow(String title, String name) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(title),
    Text(name),
  ]);
}


