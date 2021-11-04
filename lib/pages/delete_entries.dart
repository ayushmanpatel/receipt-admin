import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kosh/database/databaseservices.dart';

class DeleteEntries extends StatefulWidget {
  @override
  _DeleteEntriesState createState() => _DeleteEntriesState();
}

class _DeleteEntriesState extends State<DeleteEntries> {
  int deletedEntries = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 20.0,
      child: Container(
        height: 350.0,
        width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
              height: 40.0,
              width: 300.0,
              padding: EdgeInsets.all(8.0),
              //clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Text(
                "Delete Verified Entries",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: ElevatedButton(
                  onPressed: () async {
                    var documentID;
                    var collection =
                        FirebaseFirestore.instance.collection('bankapi');
                    var querySnapshots = await collection
                        .where('verified', isEqualTo: true)
                        .get();
                    for (var snapshot in querySnapshots.docs) {
                      documentID = snapshot.id;
                      await DatabaseService().deleteEntries(documentID);
                      setState(() {
                        deletedEntries += 1;
                      });
                    }
                  },
                  child: Text("Delete")),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Entry deleted : $deletedEntries")
          ],
        ),
      ),
    );
  }
}
