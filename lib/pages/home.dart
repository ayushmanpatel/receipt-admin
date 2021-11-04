import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:kosh/pages/showDetails.dart';

class Home extends StatefulWidget {
  final String totalentry;
  final String totalverified;

  const Home({Key key, this.totalentry, this.totalverified}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var totalentry;
  var totalverified;
  bool update = true;
  @override
  void initState() {
    super.initState();
    _showentry();
  }

  Future<void> _showentry() async {
    var totalentry1;
    var collection = FirebaseFirestore.instance.collection('datacollection');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      totalentry1 = snapshot.data();
      setState(() {
        totalentry = totalentry1['total_entry'].toString();
        totalverified = totalentry1['total_verified'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150.0,
              width: MediaQuery.of(context).size.width * 0.20,
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Number of Payments Verified",
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "$totalverified",
                        style: TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            Container(
              height: 150.0,
              width: MediaQuery.of(context).size.width * 0.20,
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Pending",
                              style: TextStyle(
                                fontSize: 14.0,
                              )),
                          SizedBox(
                            width: 16.0,
                          ),
                          GestureDetector(
                              child: update
                                  ? Icon(Icons.refresh)
                                  : CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                    ),
                              onTap: () async {
                                setState(() {
                                  update = !update;
                                });
                                var totalentry1;
                                var collection = FirebaseFirestore.instance
                                    .collection('datacollection');
                                var querySnapshots = await collection.get();
                                for (var snapshot in querySnapshots.docs) {
                                  totalentry1 = snapshot.data();
                                  totalentry =
                                      totalentry1['total_entry'].toString();
                                  totalverified =
                                      totalentry1['total_verified'].toString();
                                }
                                setState(() {
                                  totalentry = totalentry;
                                  totalverified = totalverified;
                                  update = !update;
                                });
                              })
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "$totalverified/$totalentry",
                        style: TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        ShowDetails()
      ],
    );
  }
}
