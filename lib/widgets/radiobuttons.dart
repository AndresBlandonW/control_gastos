

import 'package:flutter/material.dart';

class RadioButtons extends StatefulWidget {
  final String radioText1;
  final String radioText2;
  final Function(int) onChanged;
  const RadioButtons({super.key, required this.onChanged, required this.radioText1, required this.radioText2});

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  int tipo = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: RadioListTile(
                title: Text(widget.radioText1),
                value: 1, 
                groupValue: tipo, 
                onChanged: (value){
                    widget.onChanged(value!);
                    setState(() => tipo = value);
                },
            ),
          ),
          Expanded(
            child: RadioListTile(
                title: Text(widget.radioText2),
                value: 2, 
                groupValue: tipo, 
                onChanged: (value){
                    widget.onChanged(value!);
                    setState(() => tipo = value);
                },
            ),
          ),
        ],
      );
  }
}