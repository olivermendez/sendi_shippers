import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/payments.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

class PaymentMethods extends StatefulWidget {
  final Token token;
  const PaymentMethods({required this.token, Key? key}) : super(key: key);

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    Future<PaymentResponse?> getData() async {
      var url = Uri.parse('${Constants.apiUrl}payment/${widget.token.user.id}');

      var response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      );
      final nowPaymentResponse = PaymentResponse.fromRawJson(response.body);
      return nowPaymentResponse;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<PaymentResponse?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            //return DisplayOptions(snapshot.data!.options.commodities);
            return buildCreditCard(details: snapshot.data!.yourPaymentsMethods);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        //tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class buildCreditCard extends StatelessWidget {
  final List<YourPaymentsMethod> details;

  const buildCreditCard({required this.details, Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: details.length,
      itemBuilder: (context, index) {
        final opt = details[index];

        return Card(
          elevation: 4.0,
          color: Colors.black38,
          /*1*/
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Container(
            height: 200,
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
            child: Column(
              /*2*/
              crossAxisAlignment: CrossAxisAlignment.start,
              /*3*/
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /* Here we are going to place the _buildLogosBlock */
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    opt.cardNumber.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontFamily: 'CourrierPrime'),
                  ),

                  /* Here we are going to place the Card number */
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /* Here we are going to place the _buildDetailsBlock */

                    _buildDetailsBlock(
                      label: 'CARDHOLDER',
                      value: opt.cardHolder,
                    ),
                    _buildDetailsBlock(
                      label: 'VALID THRU',
                      value: opt.expirationDate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //TODO: Add payment method

}

Column _buildDetailsBlock({@required String? label, @required String? value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        '$label',
        style: const TextStyle(
            color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
      ),
      Text(
        '$value',
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      )
    ],
  );
}
