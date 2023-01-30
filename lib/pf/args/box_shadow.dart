import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:teaplates/pf/page.dart';

import 'color.dart';
import 'point.dart';

class PfBoxShadow {
  const PfBoxShadow({
    this.color = const PfColor(0xff000000),
    this.offset = PfPoint.zero,
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
  });

  final PfColor color;
  final PfPoint offset;
  final double blurRadius;
  final double spreadRadius;

  BoxShadow toFl() {
    return BoxShadow(
      color: color.toFl(),
      offset: offset.toFl(),
      blurRadius: blurRadius * pwToFlPx,
      spreadRadius: spreadRadius * pwToFlPx,
    );
  }

  pw.BoxShadow toPw() {
    return pw.BoxShadow(
      color: color.toPw(),
      offset: offset.toPw(),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }
}