import 'package:flutter/material.dart';
import 'package:kosh/pages/add_api.dart';
import 'package:kosh/pages/home.dart';
import 'package:kosh/pages/upload_file.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key key}) : super(key: key);

  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  List<Widget> pages;
  Widget currentPage;

  Home homePage;
  AddApi addApiPage;
  UploadFile uploadFile;
  @override
  void initState() {
    super.initState();

    homePage = Home();
    addApiPage = AddApi();
    uploadFile = UploadFile();

    pages = [homePage, uploadFile, addApiPage];

    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200.0,
          decoration: BoxDecoration(color: Colors.blueGrey[800]),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _createHeader(),
              Divider(
                color: Colors.green,
                thickness: 0.5,
                indent: 5.0,
                endIndent: 5.0,
              ),
              _createDrawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () {
                    setState(() {
                      currentPage = homePage;
                    });
                  }),
              _createDrawerItem(
                  icon: Icons.file_upload,
                  text: 'Upload File',
                  onTap: () {
                    setState(() {
                      currentPage = uploadFile;
                    });
                  }),
              _createDrawerItem(
                  icon: Icons.add,
                  text: 'Add Data',
                  onTap: () {
                    setState(() {
                      currentPage = addApiPage;
                    });
                  }),
              ListTile(
                title: Text('0.0.1'),
                onTap: () {},
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 42.0, top: 60.0),
            width: MediaQuery.of(context).size.width - 210.0,
            height: double.maxFinite,
            child: _showTappedPage(currentpage: currentPage))
      ],
    );
  }

  Widget _createHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Text(
        "FeePay",
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 16.0,
            color: Colors.green,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(text, style: TextStyle(fontSize: 14.0, color: Colors.white)),
        ],
      ),
      onTap: onTap,
    );
  }
}

Widget _showTappedPage({Widget currentpage}) {
  return currentpage;
}
