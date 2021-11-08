import 'package:flutter/material.dart';

class SwitchCustom extends StatefulWidget {
  
  final String title;
  bool item;
  final Function onChange;
  
  SwitchCustom({
    Key key,
    @required this.title,
    @required this.item,
    @required this.onChange
  }) 
  : super( key: key);

  @override
  _SwitchCustomState createState() => _SwitchCustomState();
}

class _SwitchCustomState extends State<SwitchCustom> {

  @override
  Widget build( BuildContext context ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( this.widget.title ),
          Switch(
           value: this.widget.item,
           onChanged: _onChanged,
         )
       ],
      ) ,
    );
  }
  
  void _onChanged( bool valor ) {

    setState(() => this.widget.item = valor );
    if (this.widget.onChange != null) this.widget.onChange( valor );
  }
}