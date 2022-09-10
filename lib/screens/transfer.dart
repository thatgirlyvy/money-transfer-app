import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/screens/home.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _receiverEmailController = TextEditingController();
  final _sentAmountController = TextEditingController();

  String receiverAmount = '0';

  String senderCurrency = 'XAF';
  String receiverCurrency = 'EUR';
  String? currentSold;

  var currencyItems = ['XAF', 'EUR', 'USD', 'CAD'];

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateReceiverData() async {
    DocumentSnapshot variable =
        await userCollection.doc(_receiverEmailController.text).get();
    print(variable['amount']);
    double currentSold = double.parse(variable['amount']);
    double newSold = currentSold + double.parse(receiverAmount);
    String sold = newSold.toString();
    return await userCollection
        .doc(_receiverEmailController.text)
        .update({'amount': sold});
  }

  Future updateSenderData() async {
    DocumentSnapshot variable = await userCollection.doc(user.email).get();
    print(variable['amount']);
    double currentSold = double.parse(variable['amount']);
    double newSold = currentSold - double.parse(_sentAmountController.text);
    String sold = newSold.toString();
    return await userCollection.doc(user.email).update({'amount': sold});
  }

  convertCurrency(String sender, String receiver) {
    double amount;
    if (sender == 'XAF' && receiver == 'XAF') {
      setState(() {
        amount = double.parse(_sentAmountController.text);
        receiverAmount = amount.toString();
      });
    } else if (sender == 'XAF' && receiver == 'USD') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 0.0015;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'XAF' && receiver == 'CAD') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 0.002;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'XAF' && receiver == 'EUR') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 0.0015;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'USD' && receiver == 'USD') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 1;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'USD' && receiver == 'XAF') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 656.5;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'USD' && receiver == 'CAD') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 1.31;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'USD' && receiver == 'EUR') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 1;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'EUR' && receiver == 'EUR') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 1;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'EUR' && receiver == 'USD') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 1;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'EUR' && receiver == 'XAF') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 653.41;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'EUR' && receiver == 'CAD') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 1.31;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'CAD' && receiver == 'CAD') {
      setState(() {
        amount = double.parse(_sentAmountController.text);
        receiverAmount = amount.toString();
      });
    } else if (sender == 'CAD' && receiver == 'USD') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 0.76;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'CAD' && receiver == 'XAF') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 499.87;
        receiverAmount = amount.toString();
      });
    } else if (sender == 'CAD' && receiver == 'EUR') {
      setState(() {
        amount = double.parse(_sentAmountController.text) * 0.76;
        receiverAmount = amount.toString();
      });
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purpleAccent,
            title: Text('Your transfert has been completed'),
            actions: [
              MaterialButton(onPressed: () {
                Navigator.pop(context);
              })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0,
        title: const Text(
          'Send Money',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _receiverEmailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter receiver email'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _sentAmountController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Enter amount'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sender currency: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    DropdownButton(
                      value: senderCurrency,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: currencyItems.map((String currencies) {
                        return DropdownMenuItem(
                          value: currencies,
                          child: Text(currencies),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          senderCurrency = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Receiver Currency: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    DropdownButton(
                      value: receiverCurrency,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: currencyItems.map((String currencies) {
                        return DropdownMenuItem(
                          value: currencies,
                          child: Text(currencies),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          receiverCurrency = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        convertCurrency(senderCurrency, receiverCurrency);
                      },
                      child: Text('Convert'),
                    )),
                SizedBox(
                  height: 15,
                ),
                Text('Amount Received:   ' +
                    receiverAmount +
                    '  ' +
                    receiverCurrency),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> data = {
                        "sender": user.email,
                        "receiver": _receiverEmailController.text,
                        "amount": receiverAmount,
                        "currency": receiverCurrency,
                        "date": DateFormat('dd-MMM-yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                DateTime.now().millisecondsSinceEpoch))
                      };
                      FirebaseFirestore.instance
                          .collection('transactions')
                          .add(data);
                      updateSenderData();
                      updateReceiverData();
                      _showDialog();
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
