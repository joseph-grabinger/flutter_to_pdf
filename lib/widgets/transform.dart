import 'package:flutter/widgets.dart' show Transform, Alignment;

import 'package:pdf/pdf.dart' show PdfPoint;
import 'package:pdf/widgets.dart' as pw show Transform, Widget;

import '/args/alignment.dart';

/// Extension on [Transform] to convert it to the pdf equivalent [pw.Transform].
extension TransformConverter on Transform {
  /// Converts the [Transform] to a [pw.Transform].
  pw.Transform toPdfWidget(pw.Widget? child) => pw.Transform(
        transform: transform,
        origin: origin != null ? PdfPoint(origin!.dx, origin!.dy) : null,
        alignment: (alignment as Alignment?)?.toPdfAlignment(),
        child: child,
      );
}
