import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/providers/usuario/set_usuario_provider.dart';
import 'package:control_gastos/widgets/app_bottom_bar.dart';
import 'package:control_gastos/widgets/radiobuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController nombre = TextEditingController();
  TextEditingController salario = TextEditingController();
  int tipo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        padding: EdgeInsets.only(left: 30, right: 30, top: 30),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text('Registrarse', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            const SizedBox(height: 40),
            TextField(
                controller: nombre,
                decoration: const InputDecoration(label: Text('Nombre'), icon: Icon(Icons.person)),
            ),
            const SizedBox(height: 10),
            TextField(
                controller: salario,
                decoration: const InputDecoration(label: Text('Salario'), icon: Icon(Icons.payment)),
            ),
            const SizedBox(height: 10),
            RadioButtons(radioText1: 'Mensual', radioText2: 'Quincenal', onChanged: (value) {
                tipo = value;
            }),
            const SizedBox(height: 15),
            Consumer(builder: (context, ref, child) {
              return ElevatedButton(onPressed: () async {
                if (nombre.text.length < 3) {
                  return;
                }

                if (double.tryParse(salario.text) == null) {
                  return;
                }

                if (tipo == 0) {
                  return;
                }

                int regSalario = int.parse(salario.text);
                DetallesUsuario updateUser = DetallesUsuario(nombre: nombre.text, salario: regSalario, tipoPago: tipo);
                await ref.read(setDetallesUsuarioViewModelProvider).update(updateUser);

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppBottomBar()));
                
              }, child: const Text('Actualizar'));
            })
          ],
        )
        ),
    );
  }
}