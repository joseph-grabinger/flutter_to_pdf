import 'package:flutter/material.dart' show Divider;

import 'package:pdf/widgets.dart' as pw;

import '/args/color.dart';

/// Extension on [Divider] to convert it to the pdf equivalent [pw.Divider].
extension DividerConverter on Divider {
  /// Converts the [Divider] to a [pw.Divider].
  pw.Divider toPdfWidget() => pw.Divider(
        height: height,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: color?.toPdfColor(),
      );
}
