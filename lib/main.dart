import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/models/historico.dart';
import 'package:control_gastos/models/productos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HistoricoAdapter());
  Hive.registerAdapter(DetallesUsuarioAdapter());
  Hive.registerAdapter(ProductosAdapter());
  await Hive.openBox<Historico>('historico');
  await Hive.openBox<DetallesUsuario>('detallesusuario');
  await Hive.openBox<Productos>('productos');
  //await Hive.deleteFromDisk();
  runApp(const ProviderScope(child: ControlGastosUIApp()));
}
