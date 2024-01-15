
import 'package:control_gastos/models/productos.dart';
import 'package:control_gastos/providers/productos/products_box_provider.dart';
import 'package:riverpod/riverpod.dart';

final productsProvider = FutureProvider<List<Productos>>((ref) async {
  final box = await ref.watch(productsBoxProvider.future);
  return box.values.where((element) => element.estado == 0).toList();
});

final productsProviderAll = FutureProvider<List<Productos>>((ref) async {
  final box = await ref.watch(productsBoxProvider.future);
  return box.values.toList();
});