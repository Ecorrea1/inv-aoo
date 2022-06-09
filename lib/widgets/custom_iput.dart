import 'package:flutter/material.dart';

class CustomImput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final String labelText;
  final String errorText;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final Function onChanged;
  final int maxLines;
  final int maxLength;
  final bool isPass;
  final bool enabled;

  const CustomImput({
    Key key, 
    this.icon, 
    @required this.placeholder, 
    @required this.textController, 
    this.labelText, 
    this.errorText, 
    this.keyboardType = TextInputType.text, 
    this.textCapitalization = TextCapitalization.none, 
    this.maxLines = 1, 
    this.maxLength, 
    this.isPass = false,
    this.enabled = true,
    this.onChanged,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only( top: 5, bottom: 5, left: 5, right: 20 ),
      margin: EdgeInsets.only( bottom: 10 ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular( 50 ),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black.withOpacity( 0.05 ),
            offset: Offset( 0, 5 ),
            blurRadius: 5
          ),
        ]
      ),
      child: TextField(
        controller: textController,
        autocorrect: false,
        obscureText: this.isPass,
        keyboardType: keyboardType,
        textCapitalization: this.textCapitalization,
        maxLines: this.maxLines,
        maxLength: this.maxLength,
        enabled: this.enabled,
        onChanged: this.onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: true,
          errorText: this.errorText,
          // errorMaxLines: ,
          // prefixText: 'Hola Mundo',
          prefixIcon: Icon( icon ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeholder
        ),
      )
    );
  }
}