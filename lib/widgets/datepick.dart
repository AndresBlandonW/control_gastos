
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';

class DatePickHistorial extends StatefulWidget {
  final String textInput;
  final Function(String) onChanged;
  const DatePickHistorial({super.key, this.textInput = '', required this.onChanged});

  @override
  State<DatePickHistorial> createState() => _DatePickHistorialState();
}

class _DatePickHistorialState extends State<DatePickHistorial> {
  TextEditingController dateinput = TextEditingController(); 

  @override
  void initState() {
    dateinput.text = widget.textInput;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
          controller: dateinput, //editing controller of this TextField
          decoration: const InputDecoration( 
              icon: Icon(Icons.calendar_today), //icon of text field
              labelText: "Seleccione fecha" //label text of field
          ),
          readOnly: true,  //set it true, so that user will not able to edit text
          onTap: () async {
            final selected = await showMonthPicker(
              context: context,
              initialDate: (dateinput.text == '') ? DateTime.now() : DateFormat('MM-yyyy').parse(dateinput.text),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );

            if(selected != null ){
              String formattedDate = DateFormat('MM-yyyy').format(selected); 

              setState(() {
                  dateinput.text = formattedDate; //set output date to TextField value. 
              });

              widget.onChanged(formattedDate);
            }
          },
        );
  }
}