import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DropDownBtn extends StatefulWidget {
  const DropDownBtn() : super();

  @override
  _DropDownBtnState createState() => _DropDownBtnState();
}

class _DropDownBtnState extends State<DropDownBtn> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:10.0),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down,color: Colors.blue,),
        iconSize: 24,
        elevation: 0,
        style: const TextStyle(color: Colors.blue),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['One', 'Two ', 'Three', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,overflow: TextOverflow.ellipsis,),
          );
        }).toList(),
      ),
    );
  }
}