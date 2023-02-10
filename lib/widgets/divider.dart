import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/args/color.dart';
import 'package:teaplates/teaplates.dart';


class PfDivider extends PfWidget {
  const PfDivider({
    Key? key,
    this.height = 16.0,
    this.thickness = 0.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  }) : super(key: key);

  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final PfColor? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color?.toFl(),
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color?.toPw(),
    );
  }
}