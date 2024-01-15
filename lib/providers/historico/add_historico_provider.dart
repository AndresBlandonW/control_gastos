

import 'package:control_gastos/models/historico.dart';
import 'package:control_gastos/models/productos.dart';
import 'package:control_gastos/providers/historico/historico_box_provider.dart';
import 'package:control_gastos/providers/historico/historicos_provider.dart';
import 'package:control_gastos/providers/productos/products_box_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final addHistoricoViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => AddHistoricoViewModel(ref));

    
class AddHistoricoViewModel extends ChangeNotifier {
  final Ref _ref;

  AddHistoricoViewModel(this._ref);

  Future<void> write(Historico historico) async {
      try {
        final box = await _ref.read(historicoBoxProvider.future);
        await box.add(historico);
        _ref.refresh(historicoProvider);

      } catch (e) {
        return Future.error(e);
      }
  }

  Future<void> deleteItem(dynamic key) async {
    final box = await _ref.read(historicoBoxProvider.future);

    // Valida si el historico a eliminar esta asociado a un producto
    final hist = box.get(key);
    if (hist!.prdId != 0) {
      int keyPrd = hist.prdId-1;
      final boxPrd = await _ref.read(productsBoxProvider.future);
      final prd = boxPrd.get(keyPrd);

      if (prd != null) {
        boxPrd.put(keyPrd, Productos(nombre: prd.nombre, estado: 0, mes: prd.mes, valor: prd.valor));
        _ref.refresh(productsBoxProvider);
      }
    }

    await box.delete(key);
    _ref.refresh(historicoProvider);
  }

  Future<void> payAll() async {
      DateTime fecha = DateTime.now();

      try {
        final box = await _ref.read(historicoBoxProvider.future);
        final boxPro = await _ref.read(productsBoxProvider.future);
        
        for (var element in boxPro.values.where((element) => element.estado == 0)) {
          print(element.key);
          

          Historico newHistorico = Historico(
            prdId: element.key + 1,
            producto: element.nombre, 
            tipo: 2, 
            valor: element.valor, 
            fecha: fecha
          );
          
          boxPro.put(element.key, Productos(nombre: element.nombre, estado: 1, mes: element.mes, valor: element.valor));
          await write(newHistorico);
        }

        _ref.refresh(productsBoxProvider);
        

      } catch (e) {
        return Future.error(e);
      }
  }

}