
import 'package:control_gastos/models/historico.dart';
import 'package:control_gastos/providers/historico/historico_box_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final historicoProvider = FutureProvider<List<Historico>>((ref) async {
  final box = await ref.watch(historicoBoxProvider.future);
  return box.values.where((element) => element.fecha.month == DateTime.now().month).toList();
});


final historicoProviderXDate = FutureProvider.autoDispose.family<List<Historico>, int>((ref, mes) async {
  final box = await ref.watch(historicoBoxProvider.future);
  return box.values.where((element) => element.fecha.month == mes).toList();
});