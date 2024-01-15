import 'package:flutter/material.dart';

class TextContainer extends StatefulWidget {
  const TextContainer({super.key});

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 3),),
      padding: EdgeInsets.all(5),
      child: Text('Total gastado: ')//${NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(total[0])}'),
    );
  }
}