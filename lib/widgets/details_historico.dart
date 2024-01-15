  import 'dart:ui';
  import 'package:control_gastos/providers/historico/add_historico_provider.dart';
  import 'package:control_gastos/providers/historico/historicos_provider.dart';
  import 'package:control_gastos/providers/productos/products_provider.dart';
  import 'package:control_gastos/widgets/historico_item.dart';
  import 'package:flutter/material.dart';
  import 'package:hooks_riverpod/hooks_riverpod.dart';

  import '../common/assets.dart';

  class DetailsSliver extends ConsumerWidget {
    const DetailsSliver({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final screenSize = MediaQuery.of(context).size;


      return SliverToBoxAdapter(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: whiteBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Historial',  
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Divider(
                        color: Colors.grey.withOpacity(0.3),
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),
                      
                      ref.watch(historicoProvider).when(
                        data: (items) => ListView(
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
                                      content: const Text('Desea eliminar el historial seleccionado?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () { 
                                            ref.read(addHistoricoViewModelProvider).deleteItem(item.key);
                                            Navigator.of(context).pop(); 
                                          }, child: const Text('Eliminar')),
                                        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar'))
                                      ],
                                    );
                                  });
                                }
                                //ref.read(productsProvider).deleteItem(item.key);
                              },
                              child: HistoricoItem(
                                transaction: HistoricoItemModel(
                                  title: item.producto,
                                  amount: item.valor,
                                  tipoH: item.tipo,
                                  date: item.fecha
                                ),
                              )
                            );
                          }).toList(),
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
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
