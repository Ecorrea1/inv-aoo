import 'package:flutter/material.dart';

class LabelsLogin extends StatelessWidget {
  final String route;
  final String title;
  final String subtitle;
  const LabelsLogin({
    Key key, 
    @required this.route,
    @required this.title,
    @required this.subtitle
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Text( title, style: TextStyle(color: Colors.black54,fontSize: 15, fontWeight: FontWeight.w300),), 
            GestureDetector(
              child: Text( subtitle, style: TextStyle(color: Colors.blue[600],fontSize: 18, fontWeight: FontWeight.bold )),
              onTap: () => Navigator.pushReplacementNamed(context, route )
            ),
          ],
        ),
      ),
    );
  }
}