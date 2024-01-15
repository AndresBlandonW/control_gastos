import 'dart:ui';
import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/providers/detallado_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../common/utils.dart';

class DetallesCard extends ConsumerWidget {

  Map details = {'periodo': '01/06/2023 - 30/06/2023', 'restante': 0, 'ingresos': 0, 'gastos': 0};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detallado = ref.watch(detalladoProvider);
    detallado.whenData((value) => details = value);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 250,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15),
            border: Border.all(color: Colors.white.withAlpha(30)),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Saldo actual',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withAlpha(130),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(details['restante']),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Periodo: \n'
                 + details['periodo'],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(child: Row(
                      children: [

                        SvgPicture.asset(mooneyInIcon),
                        const SizedBox(width: 10),
                        //INGRESOS
                        Text('Ingresos: \n${NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(details['ingresos'])}',
                          style: TextStyle(
                            letterSpacing: 3,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 60, 255, 0).withOpacity(0.15),
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),


                    //GASTOS
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(mooneyOutIcon),
                          const SizedBox(width: 10),
                          Text('Gastos: \n${NumberFormat.simpleCurrency(locale: 'es_US', decimalDigits: 0).format(details['gastos'])}',
                            style: TextStyle(
                              letterSpacing: 3,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 255, 0, 0).withOpacity(0.15),
                                  offset: const Offset(0, 2),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
