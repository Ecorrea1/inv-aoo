import 'package:flutter/material.dart';

class DropdownCustom extends StatefulWidget {
  final List<String> items;
  final int defaultItem;
  final Function onChange;
  final Widget underline;
  final bool outlined;
  final bool center;
  const DropdownCustom( { Key key, this.items, this.onChange, this.defaultItem, this.underline, this.center = false, this.outlined = true}) : super(key: key);

  @override
  DropdownCustomState createState() => DropdownCustomState();
}

class DropdownCustomState extends State<DropdownCustom> {
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String currentOption;

  @override
  void initState() {
    _dropdownMenuItems = _getItems();
    currentOption = _dropdownMenuItems[(this.widget.defaultItem != null) ? this.widget.defaultItem : 0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.075 ,
      decoration: BoxDecoration(
        border: Border.all(style: (this.widget.outlined) ? BorderStyle.solid : BorderStyle.none, color: Colors.grey),
        borderRadius: BorderRadius.circular(25.0),
        
      ),
      padding: EdgeInsets.only( left: 30.0, right: 10.0, top: 10, bottom: 1.0 ),
      child: DropdownButton(
        underline: this.widget.underline,
        isExpanded: true,
        isDense: true,
        // icon: Icon(Icons.add),
        hint: Text('Seleccione una categoria'),
        // disabledHint: Text('Categoria desabilitada'),
        value: currentOption,
        items: _dropdownMenuItems,
        onChanged: _onChanged,
      ),
    );
  }

  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String item in this.widget.items) {
      items.add(DropdownMenuItem(value: item, child: (this.widget.center) ? Center(child: Text(item)) : Text(item)));
    }
    return items;
  }

  void _onChanged(String item) {
    setState(() {
      currentOption = item;
    });
    if (this.widget.onChange != null) {
      this.widget.onChange(item);
    }
  }
}
