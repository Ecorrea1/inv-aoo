import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

platformDialog2Buttons(
    BuildContext context,
    String title,
    String message,
    String btn1Label,
    Function btn1Function,
    String btn2Label,
    Function btn2Function) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? new CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btn1Label),
                  onPressed: btn1Function,
                ),
                TextButton(
                  child: Text(btn2Label),
                  onPressed: btn2Function,
                )
              ],
            )
          : new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btn1Label),
                  onPressed: btn1Function,
                ),
                TextButton(
                  child: Text(btn2Label),
                  onPressed: btn2Function,
                ),
              ],
            );
    },
  );
}


platformDialog1Button(
    BuildContext context,
    String title,
    String message,
    String btn1Label,
    Function btn1Function) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? new CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btn1Label),
                  onPressed: btn1Function,
                )
              ],
            )
          : new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btn1Label),
                  onPressed: () { 
                    Navigator.pop(context);
                    btn1Function();
                  },
                )
              ],
            );
    },
  );
}

platformInfoDialog(
    BuildContext context,
    String title,
    String message,
    String btn1Label) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? new CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btn1Label),
                  onPressed: ()=>  Navigator.pop(context),
                )
              ],
            )
          : new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btn1Label),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
    },
  );
}

platformBlockDialog(
    BuildContext context,
    String title,
    String message,
    String btn1Label) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? new CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              // actions: <Widget>[
              //   FlatButton(
              //     child: Text(btn1Label),
              //     onPressed: ()=>  Navigator.pop(context),
              //   )
              // ],
            )
          : new AlertDialog(
              title: Text(title),
              content: Text(message),
              // actions: <Widget>[
              //   FlatButton(
              //     child: Text(btn1Label),
              //     onPressed: () => Navigator.pop(context),
              //   )
              // ],
            );
    },
  );
}