import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kosh/database/databaseservices.dart';

class UploadFile extends StatefulWidget {
  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  int countentry = 0;
  String rawRefId;
  var rawDebit;
  var rawCredit;
  var date;
  bool isUploaded = false;

  var fileName;
  bool isfileSelected = false;
  FilePickerResult result;
  Future selectFiles() async {
    result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileName = result.files.first.name;
      setState(() {
        isfileSelected = true;
      });
    } else {
      print("no files selected");
    }
  }

  Future uploadFiles() async {
    if (result != null) {
      var filepath = result.files.first.bytes;
      var excel = Excel.decodeBytes(filepath);
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table].rows) {
          rawRefId = row.elementAt(2);
          var newRefId = rawRefId.replaceAll(new RegExp(r'[^0-9]'), '');
          if (newRefId.length > 12) {
            newRefId =
                newRefId.replaceRange(12, newRefId.length, '').toString();
          }
          date = row.elementAt(0);

          print(date);
          rawDebit = row.elementAt(4).toString();
          rawCredit = row.elementAt(5).toString();
          await DatabaseService()
              .updateUserData(newRefId, rawDebit, rawCredit, false, date);
          setState(() {
            countentry += 1;
          });
        }
      }
    } else {
      print("no file chosen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 20.0,
        child: Container(
          height: 400.0,
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
                  "Upload file",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          selectFiles();
                        },
                        child: Text("Choose File")),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text("In .xlsx format")
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Text("File Name : "),
                    isfileSelected
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(fileName,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.green)),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      isfileSelected = !isfileSelected;
                                    });
                                  })
                            ],
                          )
                        : Text("No File Selected")
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              isUploaded
                  ? Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Uploading...")
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        if (result != null) {
                          setState(() {
                            isUploaded = true;
                          });
                          await uploadFiles();
                          setState(() {
                            isUploaded = false;
                            isfileSelected = !isfileSelected;
                          });
                          DatabaseService().datacollection(countentry, 0);
                        }
                      },
                      child: Text("Upload")),
              SizedBox(
                height: 20.0,
              ),
              Text("Total Entry : $countentry")
            ],
          ),
        ),
      ),
    );
  }
}
