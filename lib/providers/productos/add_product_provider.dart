import 'package:control_gastos/models/productos.dart';
import 'package:control_gastos/providers/productos/products_box_provider.dart';
import 'package:control_gastos/providers/productos/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final addProductViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => AddProductViewModel(ref));

    
class AddProductViewModel extends ChangeNotifier {
  final Ref _ref;

  AddProductViewModel(this._ref);
  
  Future<void> write(Productos products) async {
      try {
        final box = await _ref.read(productsBoxProvider.future);
        await box.add(products);
        _ref.refresh(productsProvider);

      } catch (e) {
        return Future.error(e);
      }
  }


  Future<void> changeProductEstado(int key) async {
    
      try {
        final boxProducts = _ref.read(productsProvider);
        final box = await _ref.read(productsBoxProvider.future);

        Productos editProduct = box.get(key)!;
        editProduct.estado = 1;
        box.put(editProduct.key, editProduct);
        _ref.refresh(productsBoxProvider);

      } catch (e) {
        return Future.error(e);
      }
  }


  Future<void> delete(key) async {
      try {
        final box = await _ref.read(productsBoxProvider.future);
        await box.delete(key);
        _ref.refresh(productsBoxProvider);
        _ref.refresh(productsProvider);

      } catch (e) {
        return Future.error(e);
      }
  }
}