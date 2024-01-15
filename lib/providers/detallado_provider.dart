import 'package:control_gastos/providers/historico/historicos_provider.dart';
import 'package:control_gastos/providers/usuario/usuario_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final detalladoProvider = FutureProvider<Map>((ref) async {
  final modelHistorico = await ref.watch(historicoProvider.future);
  final modelUsuario = await ref.watch(detallesusuarioProvider.future);

  Map details = {'periodo': '01/06/2023 - 30/06/2023', 'restante': 0, 'ingresos': 0, 'gastos': 0};

  int ingresos = 0;
  int gastos = 0;
  int salario = modelUsuario.salario;
  int restante = 0;

  for (var hist in modelHistorico) {
    if (hist.tipo == 2) {
      gastos += hist.valor;
    } else {
      ingresos += hist.valor;
    }
  }

  // GET PERIODO
  DateTime now = DateTime.now();
  DateTime ld = DateTime(now.year, now.month + 1, 0);
  String fLastDate = "${ld.day.toString().padLeft(2,'0')}/${ld.month.toString().padLeft(2,'0')}/${ld.year.toString()}";
  String periodo = "01/${now.month.toString().padLeft(2,'0')}/${now.year.toString()} - ${fLastDate}";

  if (modelUsuario.tipoPago == 2 && now.day >= 1 && now.day < 15) {
    salario = (salario / 2).round();
    periodo = "01/${now.month.toString().padLeft(2,'0')}/${now.year.toString()} - 15/${now.month.toString().padLeft(2,'0')}/${now.year.toString()}";
  }

  restante = (salario + ingresos) - gastos;

  details['restante'] = restante;
  details['ingresos'] = ingresos;
  details['gastos'] = gastos;
  details['periodo'] = periodo;

  return details;
});