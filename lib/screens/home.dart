import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneyapp/screens/transfer.dart';
import 'package:moneyapp/screens/user/history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: Icon(
          Icons.notification_important,
          color: Colors.purple,
        ),
        actions: [
          Container(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                color: Colors.deepPurple[200],
                child: Text('Sign out'),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Welcome back',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ),
              StreamBuilder(
              stream: userCollection.where('uid', isEqualTo: user.uid).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Text(data['fullName'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 4),);
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
              Container(
                height: 150,
                width: 350,
                margin: EdgeInsets.only(top: 18),
                padding: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Current Balance',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    StreamBuilder(
              stream: userCollection.where('uid', isEqualTo: user.uid).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Text(data['currency'] +'   ' + data['amount'], style: TextStyle(fontSize: 20, letterSpacing: 2, color: Colors.black, fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonTheme(
                      minWidth: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransferScreen()));
                        },
                        child: Text(
                          'Send money',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: 250,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HistoryPage()));
                              },
                              child: Text(
                                'Recent Transaction',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Track Transactions",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 18),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(color: Colors.grey),
                    SizedBox(height: 10.0),
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
