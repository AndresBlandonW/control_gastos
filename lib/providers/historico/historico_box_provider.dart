
import 'package:control_gastos/models/historico.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive/hive.dart';

final historicoBoxProvider = FutureProvider<Box<Historico>>(
  (ref) => Hive.box<Historico>("historico"),
);