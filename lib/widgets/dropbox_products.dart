

import 'package:control_gastos/providers/productos/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropBoxProdct extends ConsumerWidget {
  final Function(List) onChanged;
  DropBoxProdct({Key? key, required this.onChanged});

  var dropdownvalue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elements = ref.watch(productsProvider);
    
    return StatefulBuilder(
      builder: (context, setState) {
        if (elements.hasValue) {
          final selectedValueExists = elements.value!.any((value) => value.nombre == dropdownvalue);

          // Si el valor seleccionado no está disponible, establecer el primer elemento como valor predeterminado
          if (!selectedValueExists) {
            dropdownvalue = null;
          }

          return DropdownButton<String>(
                hint: const Text('Producto'),
                value: dropdownvalue,
                items: elements.value!.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.nombre,
                    child: Text(value.nombre),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => dropdownvalue = value);
                    var first = elements.value!.firstWhere((element) => element.nombre == value);
                    int key = first.key;
                    String producto = value;
                    int valorPago = first.valor;

                    onChanged([key, producto, valorPago]);
                  }
                },
              );
        }
        return Container();
      }
    );
  }
  
}