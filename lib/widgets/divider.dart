import 'package:flutter/material.dart' show Divider;

import 'package:pdf/widgets.dart' as pw;

import '/args/color.dart';

extension DividerConverter on Divider {
  pw.Divider toPdfWidget() => pw.Divider(
        height: height,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: color?.toPdfColor(),
      );
}
