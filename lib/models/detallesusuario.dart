

import 'package:hive/hive.dart';

part 'detallesusuario.g.dart';

@HiveType(typeId: 2)
class DetallesUsuario extends HiveObject {

  @HiveField(0)
  String nombre;

  @HiveField(1)
  int salario;

  @HiveField(2)
  int tipoPago;

  DetallesUsuario({required this.nombre, required this.salario, required this.tipoPago});
}