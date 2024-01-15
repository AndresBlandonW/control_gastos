import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/providers/usuario/set_usuario_provider.dart';
import 'package:control_gastos/providers/usuario/usuario_box_provider.dart';
import 'package:control_gastos/providers/usuario/usuario_provider.dart';
import 'package:control_gastos/screens/update_detalles.dart';
import 'package:control_gastos/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//TextEditingController salarioEdit = TextEditingController();

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final modelProduct = ref.watch(setDetallesUsuarioViewModelProvider);
      //String salario = NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(model.value!.salario);
      //String tipoPago = (model.value!.tipoPago == 1) ? 'Mensual' : 'Quincenal';

      return Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [purple, deepBlue],
              transform: GradientRotation(gradientRotation),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
            const Text('Perfil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            const SizedBox(height: 15),
            ref.watch(detallesusuarioProvider).when(data: (detalles) {

              String salario = NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(detalles.salario);
              String tipoPago = (detalles.tipoPago == 1) ? 'Mensual' : 'Quincenal';

              return Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 24),
                    TextFieldCustom(label: 'Nombre', text: detalles.nombre),
                    const SizedBox(height: 24),
                    TextFieldCustom(label: 'Salario', text: salario),
                    const SizedBox(height: 24),
                    TextFieldCustom(label: 'Tipo pago', text: tipoPago),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      child: const Text('Cambiar datos'),
                      onPressed: () async {
                        
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                            ),
                          context: context,
                          elevation: 5,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return UpdateDetalles(nombre: detalles.nombre);
                          }
                        ).then((value) {
                          ref.refresh(detallesUsuarioBoxProvider);
                        });

                        print('actualizado');
                      },
                    )
                  ]
                ),
              ); 
            },
              error: (e, s) => Center(
                child: Text(
                  e.toString(),
                ),
              ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      );
    }
}