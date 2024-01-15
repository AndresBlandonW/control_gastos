import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/providers/usuario/set_usuario_provider.dart';
import 'package:control_gastos/providers/usuario/usuario_box_provider.dart';
import 'package:control_gastos/widgets/radiobuttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class UpdateDetalles extends HookConsumerWidget {

  TextEditingController salario = TextEditingController();
  TextEditingController valor = TextEditingController();
  int tipo = 0;
  bool itemProduct = false;
  final String nombre;

  UpdateDetalles({super.key, required this.nombre});

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelUsuario = ref.watch(setDetallesUsuarioViewModelProvider);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
      return Container (
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 120, 
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextField(
                  controller: salario,
                  decoration: const InputDecoration(label: Text('Salario'), icon: Icon(Icons.payments)),
                ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              RadioButtons(radioText1: 'Mensual', radioText2: 'Quincenal', onChanged: (value) {
                  tipo = value;
              }),
              const SizedBox(height: 15),
              ElevatedButton(onPressed: () async {

                if (double.tryParse(salario.text) == null) {
                  return;
                }

                if (tipo == 0) {
                  return;
                }

                int newSalario = int.parse(salario.text);
                DetallesUsuario updateUser = DetallesUsuario(nombre: nombre, salario: newSalario, tipoPago: tipo);
                await modelUsuario.update(updateUser);

                Navigator.pop(context);
                
              }, child: const Text('Actualizar')),
          ],
        )
          );
          }
    );
  }
  
}
