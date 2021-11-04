import 'package:flutter/material.dart';

class ShowDetails extends StatefulWidget {
  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300.0,
        width: 1000.0,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text("5 Days"),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text("1 Week"),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  Container(
                    height: 30.0,
                    width: 200.0,
                    child: Material(
                      color: Colors.white,
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(5.0),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            hintText: "Search",
                            suffixIcon: Material(
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Icon(
                                Icons.search,
                                size: 20.0,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.green,
              thickness: 0.5,
            ),
            Text("No Data")
          ],
        ));
  }
}
