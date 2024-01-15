import 'package:control_gastos/common/assets.dart';
import 'package:control_gastos/common/magic_numbers.dart';
import 'package:control_gastos/common/utils.dart';
import 'package:control_gastos/providers/scroll_offset_provider.dart';
import 'package:control_gastos/widgets/details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/card_carousel_offset_provider.dart';


class CardSliver extends StatelessWidget {
  const CardSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final offset = ref.watch(scrollOffsetProvider);
        return SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              background: Transform.scale(
                scale: offsetToScale(offset),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: child,
                ),
              ),
            ));
      },
      child: Consumer(
        builder: (context, ref, child) {
          final carouselOffset = ref.watch(cardCarouselOffsetProvider);
          return Stack(
            children: [
              child ?? const SizedBox.shrink(),
              Positioned(
                top: getTopOffsetOfFrontUpperNode(carouselOffset),
                left: getLeftOffsetOfFrontUpperNode(carouselOffset),
                child: Image.asset(circleNode ,scale: 3),
              ),
              Positioned(
                bottom: 5,
                right: getRightOffsetOfFrontLowerNode(carouselOffset),
                child: Image.asset(circleNode,scale: 3),
              ),
            ],
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Detalles',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 44),
            DetallesCard(),
          ],
        ),
      ),
    );
  }
}
