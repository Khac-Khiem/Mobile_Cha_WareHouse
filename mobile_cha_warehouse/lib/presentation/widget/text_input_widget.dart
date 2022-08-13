import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/function.dart';

class TextInput extends StatelessWidget {
  String contentTextField;
  TextInput(this.contentTextField);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5 * SizeConfig.ratioHeight),
        alignment: Alignment.centerRight,
        width: 200 * SizeConfig.ratioWidth,
        height: 55 * SizeConfig.ratioHeight,
        //color: Colors.grey[200],
        child: TextField(
          enabled: true,
          //    readOnly: true,
          controller: contentTextField == ''
              ? TextEditingController()
              : TextEditingController(text: contentTextField),
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20 * SizeConfig.ratioFont),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10 * SizeConfig.ratioHeight),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.0 * SizeConfig.ratioWidth, color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.0 * SizeConfig.ratioWidth, color: Colors.black)),
          ),
        ));
  }
}