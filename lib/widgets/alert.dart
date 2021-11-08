import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle){
  if( Platform.isAndroid ){
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text( title),
        content: Text( subtitle ),
        actions: [
          MaterialButton(
            child: Text('OK'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context, true ),
          )
        ],
      )
    );
  }

  showCupertinoDialog(
    context: context,
     builder: (_) => CupertinoAlertDialog(
       title: Text( title ),
       content: Text( subtitle ),
       actions: [
         CupertinoDialogAction(
          isDefaultAction: true, 
          child: Text( 'OK' ),
          onPressed: () => Navigator.pop(context, true) )
       ],
     )
  );
}