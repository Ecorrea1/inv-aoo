import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {

  final String title;
  final Color colorB;
  final int fontSize;
  final Function onPressed;

  const CustomButtom ({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.fontSize = 18,
    this.colorB = Colors.blue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: colorB,
      shape: StadiumBorder(),
      child:Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text( title , style: TextStyle( color: Colors.white, fontSize: 18 ))
        )
      ),
      onPressed: this.onPressed
    );
  }
}