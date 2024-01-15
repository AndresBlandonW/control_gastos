import 'package:control_gastos/models/detallesusuario.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive/hive.dart';

final detallesUsuarioBoxProvider = FutureProvider<Box<DetallesUsuario>>(
  (ref) => Hive.box<DetallesUsuario>("detallesusuario"),
);