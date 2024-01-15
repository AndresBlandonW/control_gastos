
import 'package:control_gastos/models/productos.dart';
import 'package:hive/hive.dart';
import 'package:riverpod/riverpod.dart';

final productsBoxProvider = FutureProvider<Box<Productos>>(
  (ref) => Hive.box<Productos>("productos")
);