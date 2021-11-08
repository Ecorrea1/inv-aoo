import 'package:flutter/material.dart';
class LogoScreen extends StatelessWidget {
  final String title;

  const LogoScreen({
    Key key, 
    @required this.title
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Image(image: AssetImage('assets/logo-iglesia.png'),),
            SizedBox(height: 10,),
            Text( title,style: TextStyle( fontSize: 30 ),)
          ],
        ),
      ),
    );
  }
}