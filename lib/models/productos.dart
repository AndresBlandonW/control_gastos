

import 'package:hive/hive.dart';

part 'productos.g.dart';

@HiveType(typeId: 3)
class Productos extends HiveObject {

  @HiveField(0)
  String nombre;

  @HiveField(1)
  int valor;

  @HiveField(2)
  int estado;

  @HiveField(3)
  String mes;

  Productos({required this.nombre, this.valor = 0, required this.estado, required this.mes});
}