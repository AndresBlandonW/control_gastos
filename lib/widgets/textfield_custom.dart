import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  final String label;
  final String text;
  const TextFieldCustom({super.key, required this.label, required this.text});

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late final TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            enabled: false,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              disabledBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 1,
          ),
        ],
      );
  }
}