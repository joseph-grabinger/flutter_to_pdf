import 'package:flutter/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/page.dart';


class PfEdgeInsets{

  const PfEdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom);

  const PfEdgeInsets.all(double value)
    : left = value,
      top = value,
      right = value,
      bottom = value;

  const PfEdgeInsets.only({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  const PfEdgeInsets.symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) : left = horizontal,
      top = vertical,
      right = horizontal,
      bottom = vertical;

  EdgeInsets toFl() {
    return EdgeInsets.fromLTRB(left * pwToFlPx, top * pwToFlPx, right * pwToFlPx, bottom * pwToFlPx);
  }

    pw.EdgeInsets toPw() {
    return pw.EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  final double left;
  final double top;
  final double right;
  final double bottom;

}