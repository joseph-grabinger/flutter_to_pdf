import 'package:flutter/widgets.dart' show BeveledRectangleBorder, BorderRadius, CircleBorder, ContinuousRectangleBorder, OutlinedBorder, RoundedRectangleBorder, StadiumBorder, debugPrint;

import 'package:pdf/widgets.dart' as pw show BoxShape, BorderRadius;

import '/args/border_radius.dart';


extension OutlinedBorderConverter on OutlinedBorder {
  pw.BoxShape toPdfBoxShape() {
    switch (runtimeType) {
      case CircleBorder:
        return pw.BoxShape.circle;
      case StadiumBorder:
        return pw.BoxShape.circle;
      case RoundedRectangleBorder:
        return pw.BoxShape.rectangle;
      case BeveledRectangleBorder:
        return pw.BoxShape.rectangle;
      case ContinuousRectangleBorder:
        return pw.BoxShape.rectangle;
      // unsupported by pdf package:
      // - StadiumBorder
      // - RoundedRectangleBorder
      // - BeveledRectangleBorder
      // - ContinuousRectangleBorder
      default:
        debugPrint('Unsupported OutlinedBorder: $this; defaulting to rectangle border shape');
        return pw.BoxShape.rectangle;
    }
  }

  pw.BorderRadius toPdfBorderRadius() {
    switch (runtimeType) {
      case CircleBorder:
        return pw.BorderRadius.circular(1000);
      case StadiumBorder:
        return pw.BorderRadius.circular(10);
      case RoundedRectangleBorder:
        return ((this as RoundedRectangleBorder).borderRadius as BorderRadius).toPdfBorderRadius();
      case BeveledRectangleBorder:
        return ((this as BeveledRectangleBorder).borderRadius as BorderRadius).toPdfBorderRadius();
      case ContinuousRectangleBorder:
        return ((this as ContinuousRectangleBorder).borderRadius as BorderRadius).toPdfBorderRadius();
      default:
        debugPrint('Unsupported OutlinedBorder: $this; defaulting to circular border radius');
        return pw.BorderRadius.circular(1000);
    }
  }
}