
import 'dart:ui';

import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/common/utils.dart';
import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/models/historico.dart';
import 'package:control_gastos/models/productos.dart';
import 'package:control_gastos/providers/historico/add_historico_provider.dart';
import 'package:control_gastos/providers/productos/add_product_provider.dart';
import 'package:control_gastos/providers/productos/products_box_provider.dart';
import 'package:control_gastos/providers/productos/products_provider.dart';
import 'package:control_gastos/providers/usuario/set_usuario_provider.dart';
import 'package:control_gastos/widgets/dropbox_products.dart';
import 'package:control_gastos/widgets/radiobuttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AddHistorico extends HookConsumerWidget {

  TextEditingController prdNombre = TextEditingController();
  TextEditingController valor = TextEditingController();
  int tipo = 0;
  List _itemSelected = [];
  bool itemProduct = false;

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(addHistoricoViewModelProvider);
    final modelUsuario = ref.watch(setDetallesUsuarioViewModelProvider);
    final modelProduct = ref.watch(addProductViewModelProvider);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
      return Container (
          padding: EdgeInsets.only(
            top: 15,
            left: 25,
            right: 25,
            bottom: MediaQuery.of(context).viewInsets.bottom + 70, 
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
              Row(
                children: [
                  const Text('Nuevo Producto? '),
                  Switch(
                    value: itemProduct, 
                    onChanged: (bool value) {
                      setState(() => itemProduct = value);
                    } 
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Visibility(
                visible: !itemProduct,
                child: Row(
                  children: [
                    const Icon(Icons.payments),
                    const SizedBox(width: 15),
                    DropBoxProdct(onChanged: (value) {
                      _itemSelected = value;
                      valor.text = value[2].toString();
                    }),
                  ],
                )
              ),
              Visibility(
                visible: itemProduct,
                child: TextField(
                  controller: prdNombre,
                  decoration: const InputDecoration(label: Text('Producto'), icon: Icon(Icons.payments)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: valor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Valor'), icon: Icon(Icons.attach_money)),
              ),
              const SizedBox(height: 10),
              RadioButtons(radioText1: 'Ingreso', radioText2: 'Gasto', onChanged: (value) {
                  tipo = value;
              }),
              const SizedBox(height: 15),
              ElevatedButton(onPressed: () async {

                if (double.tryParse(valor.text) == null) {
                  return;
                }

                if (tipo == 0) {
                  return;
                }

                int valorh = int.parse(valor.text);
                DateTime fecha = DateTime.now();
                String prodct = '';
                int prdId = 0;

                if (itemProduct == false) {
                  // Habilitado dropbox
                  if (_itemSelected.isNotEmpty) {
                    prodct = _itemSelected[1];
                    prdId = _itemSelected[0] + 1;
                    await modelProduct.changeProductEstado(_itemSelected[0]);
                  }
                } else {
                  if (prdNombre.text.isNotEmpty) {
                    prodct = prdNombre.text;
                  }
                }

                
                if (prodct != '') {
                  print('valido');

                  prodct = capitalize(prodct);
                  Historico newHistorico = Historico(
                    prdId: prdId, 
                    producto: prodct, 
                    tipo: tipo, 
                    valor: valorh, 
                    fecha: fecha
                  );
      
                  await model.write(newHistorico);
                  
                  Navigator.pop(context);
                }

              }, child: Text('Agregar historico')),
          ],
        )
          );
          }
    );
  }
  
}
