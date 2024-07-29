import 'package:flutter/material.dart';
import '../components/svg.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class CardCustom extends StatelessWidget {
  final BuildContext parentContext;
  final String teks;
  final bool isCenter;

  const CardCustom(
      {super.key,
      required this.parentContext,
      required this.teks,
      required this.isCenter});

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(parentContext).size;
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
              color: lightbrown,
              borderRadius: const BorderRadius.all(Radius.circular(45)),
              border: Border.all(color: black, width: 2)),
          width: (screenSizes.width / 2) + screenSizes.width / 3,
          child: Text(
            teks,
            style: Styles.bRegular12,
            textAlign: (isCenter) ? TextAlign.center : TextAlign.justify,
          ),
        ),
        Positioned(left: 10, top: -5, child: SVG.quotes1Icon),
        Positioned(right: 10, bottom: -5, child: SVG.quotes2Icon),
      ],
    );
  }
}
