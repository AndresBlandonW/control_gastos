import 'package:control_gastos/common/funct.dart';
import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/providers/card_carousel_offset_provider.dart';
import 'package:control_gastos/providers/historico/add_historico_provider.dart';
import 'package:control_gastos/screens/historial_pagos.dart';
import 'package:control_gastos/widgets/details_historico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


import '../common/assets.dart';
import '../providers/scroll_controller_provider.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/card_sliver.dart';
import 'add_historico.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es-ES', '');
  }

  void _showForm() {
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
        return AddHistorico();
      }
    );
  }

  void _pagarProductos() {
      showDialog(context: context, builder: (context) {
        return Consumer(builder: (context, ref, child) { 
          final model = ref.watch(addHistoricoViewModelProvider);

          return AlertDialog(
          title: const Text('Pagar productos'),
          content: const Text('Deseas pagar todos los productos este mes?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
            TextButton(
              onPressed: () async { 
                //pagarProductosMes();
                await model.payAll();
                Navigator.of(context).pop(); 
              }, child: const Text('Pagar')),
          ],
        );
      });
    },);

    
  }

  @override
  Widget build(BuildContext context) {
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
        child: Consumer(
          builder: (context, ref, child) {
            final carouselOffset = ref.watch(cardCarouselOffsetProvider);
            final height = MediaQuery.of(context).size.height;
            return Stack(
              children: [
                Positioned(
                  top: getTopOffsetOfBigNode(height, carouselOffset),
                  left: getLeftOffsetOfBigNode(carouselOffset),
                  child: Transform.rotate(
                    angle: -carouselOffset * 0.7,
                    child: Image.asset(bigCircleNode, scale: 0.7),
                  ),
                ),
                Positioned(
                  top: getTopOffsetOfSmallNode(height, carouselOffset),
                  right: getRightOffsetOfSmallNode(carouselOffset),
                  child: Image.asset(circleNode, scale: 1.2),
                ),
                child ?? const SizedBox.shrink(),
              ],
            );
          },
          child: SafeArea(
            child: Consumer(builder: (context, ref, _) {
              return const Padding(
                padding: EdgeInsets.only(top: 0),
                child: CustomScrollView(
                  //controller: ref.watch(scrollControllerProvider),
                  //physics: const ClampingScrollPhysics(),
                  slivers: [CardSliver(), DetailsSliver()],
                ),
              );
            }),
          ),
        ),
      ),
      extendBody: true,
      floatingActionButton: SpeedDial(
        spacing: 12,
        overlayOpacity: 0.4,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.receipt),
            label: 'Agregar',
            onTap: () => _showForm()
          ),
          SpeedDialChild(
            child: const Icon(Icons.payment),
            label: 'Pagar productos',
            onTap: () => _pagarProductos(),
          ),
        ],
      )
      //FloatingActionButton(onPressed: () => _showForm(), child: Icon(Icons.add),),
    );
  }
}
