import 'package:control_gastos/common/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HistoricoItemModel {
  final String title;
  final int amount;
  final int tipoH;
  final DateTime date;

  const HistoricoItemModel({
    required this.title,
    required this.amount,
    required this.tipoH,
    required this.date
  });
}

class HistoricoItem extends StatelessWidget {
  final HistoricoItemModel transaction;

  const HistoricoItem({
    required this.transaction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (transaction.tipoH == 2)
            SvgPicture.asset(mooneyOutIcon)
          else
            SvgPicture.asset(mooneyInIcon),
          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w400),
                ),
                Text(
                  DateFormat('EEEE, d MMM yyyy', 'es').format(transaction.date),
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
                Text(
                    NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0)
                    .format(transaction.amount),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: (transaction.tipoH == 2) ? Color.fromARGB(255, 180, 19, 8) : Color.fromARGB(255, 6, 180, 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
