import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/providers/productos/add_product_provider.dart';
import 'package:control_gastos/providers/productos/products_box_provider.dart';
import 'package:control_gastos/providers/productos/products_provider.dart';
import 'package:control_gastos/screens/add_producto.dart';
import 'package:control_gastos/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/assets.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void _showForm() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
        ),
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AddProducto();
        }
      );
    }


    return Scaffold(
      //backgroundColor: whiteBg,
      floatingActionButton: FloatingActionButton(onPressed: () => _showForm(), child: Icon(Icons.add),),
      body:
      Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [purple, deepBlue],
            transform: GradientRotation(gradientRotation),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text('Productos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            const SizedBox(height: 15),
            ref.watch(productsProviderAll).when(
                        data: (items) => Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: items.map((item) {
                              return Dismissible(
                                background: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Center(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                key: ValueKey(item.key),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  if (direction == DismissDirection.endToStart) {
                                    return await showDialog(context: context, 
                                    builder: (context) {
                                      return  AlertDialog(
                                        title: const Text('Advertencia'),
                                        content: const Text('Desea eliminar el producto seleccionado?'),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                                          TextButton(
                                            onPressed: () { 
                                              ref.read(addProductViewModelProvider).delete(item.key);
                                              Navigator.of(context).pop();
                                            }, child: const Text('Eliminar')),
                                        ],
                                      );
                                    });
                                  }
                                  return null;
                                  //ref.read(productsProvider).deleteItem(item.key);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                  child: ProductItem(
                                    producto: ProductItemModel(
                                      nombre: item.nombre,
                                      valor: item.valor,
                                      estado: item.estado,
                                      mes: item.mes
                                    ),
                                  ),
                                )
                              );
                            }).toList(),
                          ),
                        ),
                        error: (e, s) => Center(
                          child: Text(
                            e.toString(),
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
          ],
        ),
    ));
  }
}
