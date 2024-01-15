

import 'package:hive/hive.dart';

part 'historico.g.dart';

@HiveType(typeId: 1)
class Historico extends HiveObject {

  @HiveField(0)
  int prdId;

  @HiveField(1)
  String producto;

  @HiveField(2)
  int tipo;

  @HiveField(3)
  int valor;

  @HiveField(4)
  DateTime fecha;

  Historico({required this.prdId, required this.producto, required this.tipo, required this.valor, required this.fecha});
}