import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/common/utils.dart';
import 'package:control_gastos/models/productos.dart';
import 'package:control_gastos/providers/productos/add_product_provider.dart';
import 'package:control_gastos/providers/productos/products_box_provider.dart';
import 'package:control_gastos/providers/productos/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AddProducto extends HookConsumerWidget {

  TextEditingController prdNombre = TextEditingController();
  TextEditingController valor = TextEditingController();
  int tipo = 0;
  bool itemProduct = false;

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelProduct = ref.watch(addProductViewModelProvider);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
      return Container (
          padding: EdgeInsets.only(
            top: 15,
            left: 25,
            right: 25,
            bottom: MediaQuery.of(context).viewInsets.bottom + 120, 
          ),
          decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [purple, deepBlue],
            transform: GradientRotation(gradientRotation),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextField(
                  controller: prdNombre,
                  decoration: const InputDecoration(label: Text('Producto'), icon: Icon(Icons.payments)),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: valor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Valor pago'), icon: Icon(Icons.attach_money)),
              ),
              const SizedBox(height: 20),
              // BUTTON PRODUCTO
              ElevatedButton(onPressed: () async {
                if (double.tryParse(valor.text) == null) {
                  return;
                }

                if (prdNombre.text.isEmpty) {
                  return;
                }

                String nombrePrd = capitalize(prdNombre.text);

                String mesA = DateTime.now().month.toString();
                Productos newProducto = Productos(nombre: nombrePrd, valor: int.parse(valor.text), estado: 0, mes: mesA);
    
                await modelProduct.write(newProducto);
                ref.refresh(productsBoxProvider);

                print('añadido');
    
                Navigator.pop(context);
                
              }, child: const Text('Añadir Producto')),
          ],
        )
      );
      }
    );
  }
  
}
