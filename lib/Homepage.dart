import 'package:flutter/material.dart';
import 'package:kosh/widgets/Drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProfileDrawer(),
    );
  }
}
