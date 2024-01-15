import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/providers/usuario/usuario_box_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final detallesusuarioProvider = FutureProvider<DetallesUsuario>((ref) async {
  final box = await ref.watch(detallesUsuarioBoxProvider.future);
  return (box.isNotEmpty) ? box.values.first : DetallesUsuario(nombre: '', salario: 0, tipoPago: 1);
});