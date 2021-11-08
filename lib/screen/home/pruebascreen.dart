import 'package:flutter/material.dart';

class PruebaScreen extends StatelessWidget {
  const PruebaScreen ({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alabama'),
      ),
      body: Center(
        child: Text('Alabama'),
      ),
    );
  }
}