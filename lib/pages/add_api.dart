import 'package:flutter/material.dart';
import 'package:kosh/database/databaseservices.dart';

import 'package:kosh/pages/delete_entries.dart';

class AddApi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddApiState();
  }
}

class AddApiState extends State<AddApi> {
  String _upiId;
  String _amount;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildUpiId() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Upi Id', fillColor: Colors.white),
      maxLength: 12,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Upi Id is Required';
        }
        if (value.length != 12) {
          return 'Upi Id Must be 12 Digit';
        }

        return null;
      },
      onSaved: (String value) {
        _upiId = value;
      },
    );
  }

  Widget _buildAmount() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Paid', fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Amount is Required';
        }
        if (!value.contains(RegExp('[a-z] || [A-Z]'))) {
          return 'Enter Proper Amount';
        }
        return null;
      },
      onSaved: (String value) {
        _amount = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(16.0),
            elevation: 10.0,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              width: 300.0,
              height: 300.0,
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildUpiId(),
                    _buildAmount(),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return null;
                        }

                        _formKey.currentState.save();
                        //Send to API
                        DatabaseService().updateUserData(
                            _upiId, _amount, _amount, false, 01 - 01 - 2021);
                        _formKey.currentState.reset();
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: Text("Submitted"),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40.0,
        ),
        DeleteEntries()
      ],
    );
  }
}
