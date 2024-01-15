import 'package:control_gastos/common/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ProductItemModel {
  final String nombre;
  final int valor;
  final int estado;
  final String mes;

  const ProductItemModel({
    required this.nombre,
    required this.valor,
    required this.estado,
    required this.mes
  });
}

class ProductItem extends StatelessWidget {
  final ProductItemModel producto;

  const ProductItem({
    required this.producto,
    Key? key,
  }) : super(key: key);

  String getEstado(int est) {
    if (est == 1) {
      return "Pagado";
    }
    return 'Por pagar';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteBg,
      shadowColor: Colors.white,
      child: ListTile(
        leading: Container(
                height: double.infinity,
                child: const Icon(Icons.payments, color: Color.fromARGB(255, 50, 40, 72)),
              ),
        contentPadding: const EdgeInsets.only(left: 15, right: 25, top: 3, bottom: 3),
        title: Text(producto.nombre, style: TextStyle(color: Colors.black),),
        subtitle: Text('Pago: ${NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(producto.valor)}', style: TextStyle(color: Color.fromARGB(255, 82, 82, 82))),
        trailing: Text(getEstado(producto.estado), 
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: (producto.estado == 1) ? Color.fromARGB(255, 25, 138, 29) : Colors.red, fontWeight: FontWeight.bold)),
      ),
    );
    
    /*
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.nombre,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Text(
                  'mes: ${producto.mes}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black26,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getEstado(producto.estado), 
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: (producto.estado == 1) ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                Text(
                    ,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );*/
  }
}
