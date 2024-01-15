
import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/models/detallesusuario.dart';
import 'package:control_gastos/models/historico.dart';
import 'package:control_gastos/providers/historico/historicos_provider.dart';
import 'package:control_gastos/widgets/datepick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HistorialPagos extends StatefulWidget {
  const HistorialPagos({super.key});

  @override
  State<HistorialPagos> createState() => _HistorialPagosState();
}

class _HistorialPagosState extends State<HistorialPagos> {
  late int mesConsulta;
  late String consulta;

  @override
  void initState() {
    mesConsulta = DateTime.now().month;
    consulta = DateFormat('MM-yyyy').format(DateTime.now());
    super.initState();
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text('Historial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              const SizedBox(height: 20),
              DatePickHistorial(
                textInput: consulta,
                onChanged: (value) {
                  print(value);
                  int mess = int.parse(value.split('-')[0]);
                  setState(() {
                    consulta = value;
                    mesConsulta = mess;
                  });
                }
              ),

              Consumer(builder: (context, ref, child) {
                final consulta = ref.watch(historicoProviderXDate(mesConsulta));
                return consulta.when(data: (historial) { 
                  
                  List total = calculeTotal(historial);

                  return Expanded(
                  child: Column(children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Gastos: \n${NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(total[0])}'),
                        Text('Ingresos: \n${NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(total[1])}'),
                        Text('Restante: \n${NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(total[2])}'),
                      ],),
                      const SizedBox(height: 20),

                      Expanded(
                      child: ListView(  
                        children: historial.map((item) {
                          return Card(
                            child: ListTile(
                              leading: Container(
                                height: double.infinity,
                                child: (item.tipo == 2) ? SvgPicture.asset(mooneyOutIcon) : SvgPicture.asset(mooneyInIcon),
                              ),
                              contentPadding: const EdgeInsets.only(right: 20, left: 13, top: 5, bottom: 5),
                              title: Text(item.producto, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              trailing: Text(NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(item.valor), 
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: (item.tipo == 2) ? Color.fromARGB(255, 255, 17, 0) : Color.fromARGB(255, 6, 180, 12))),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text('Hora: ${DateFormat('HH:mm').format(item.fecha)}', style: TextStyle(color: Colors.white)),
                              ],),
                            ),
                          );
                        }).toList(),
                      )
                    )
                    ],),
                );},
                error: (e, s) => Center(
                  child: Text(
                    e.toString(),
                  ),
                ), 
                loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

List<int> calculeTotal(List<Historico> historial) {

  int totalG = 0;
  int totalI = 0;

  for (var element in historial) {
    if (element.tipo == 2) {
      totalG += element.valor;
    } else {
      totalI += element.valor;
    }
  }

  final box = Hive.box<DetallesUsuario>("detallesusuario");
  int restante = box.values.first.salario - totalG;

  return [totalG, totalI, restante];
}


