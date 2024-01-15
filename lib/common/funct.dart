import 'package:control_gastos/models/productos.dart';
import 'package:control_gastos/providers/detallado_provider.dart';
import 'package:control_gastos/providers/historico/historico_box_provider.dart';
import 'package:control_gastos/providers/historico/historicos_provider.dart';
import 'package:control_gastos/providers/productos/products_box_provider.dart';
import 'package:control_gastos/providers/productos/products_provider.dart';
import 'package:control_gastos/providers/usuario/usuario_box_provider.dart';
import 'package:riverpod/riverpod.dart';


void checkMonthProducts() async {
  final container = ProviderContainer();
  String mesA = DateTime.now().month.toString();

  final box = await container.read(productsBoxProvider.future);

  if (box.isNotEmpty) {
    print(box.values.first.mes + ' - ' + mesA);
    if (box.values.first.mes != mesA) {
      print('diferente');
      for (var element in box.values) {
        box.put(element.key, Productos(nombre: element.nombre, estado: 0, mes: mesA, valor: element.valor));
        print(element);
      }
      container.refresh(historicoBoxProvider);
      container.refresh(historicoProvider);
      container.refresh(productsBoxProvider);
      container.refresh(productsProvider);
      container.refresh(detallesUsuarioBoxProvider);
      container.refresh(detalladoProvider);
    } else {
      print('mismo mes');
    }
  }
}