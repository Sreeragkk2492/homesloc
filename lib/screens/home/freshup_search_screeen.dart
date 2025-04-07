import 'package:flutter/material.dart';
import 'package:homesloc/core/colors/colors.dart';

class FreshUpSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fresh Up Search'),
        backgroundColor: blue,
      ),
      body: Center(
        child: Text('Fresh Up Search Screen'),
      ),
    );
  }
}