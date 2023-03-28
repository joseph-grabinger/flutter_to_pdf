import 'package:flutter/widgets.dart' show Transform, Alignment;

import 'package:pdf/pdf.dart' show PdfPoint;
import 'package:pdf/widgets.dart' as pw show Transform, Widget;

import '/args/alignment.dart';

extension TransformConverter on Transform {
  pw.Transform toPdfWidget(pw.Widget? child) => pw.Transform(
        transform: transform,
        origin: origin != null ? PdfPoint(origin!.dx, origin!.dy) : null,
        alignment: (alignment as Alignment?)?.toPdfAlignment(),
        child: child,
      );
}
