import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/screens/register_user.dart';
import 'package:control_gastos/widgets/app_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ControlGastosUIApp extends StatelessWidget {
  const ControlGastosUIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Gastos',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: const ColorScheme.dark().copyWith(primary: coral),
      ),
      debugShowCheckedModeBanner: false,
      home: checkUserRegister(),
    );
  }
}


Widget checkUserRegister() {
  
  var box = Hive.box<DetallesUsuario>("detallesusuario");
  
  if (box.isNotEmpty) {
    return const AppBottomBar();
  }

  return const RegisterUser();  
}

