import 'package:flutter/widgets.dart'
    show EdgeInsets, EdgeInsetsDirectional, EdgeInsetsGeometry, debugPrint;

import 'package:pdf/widgets.dart' as pw show EdgeInsets;

extension EdgeInsetsGeometryConverter on EdgeInsetsGeometry {
  pw.EdgeInsets? toPdfEdgeInsets() {
    switch (runtimeType) {
      case const (EdgeInsets):
        return (this as EdgeInsets).toPdfEdgeInsets();
      case const (EdgeInsetsDirectional):
        return (this as EdgeInsetsDirectional).toPdfEdgeInsetsDirectional();
      default:
        debugPrint('Unsupported EdgeInsetsGeometry: $this; defaulting to null');
        return null;
    }
  }
}

extension EdgeInsetsConverter on EdgeInsets {
  pw.EdgeInsets toPdfEdgeInsets() => pw.EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      );
}

extension EdgeInsetsDirectionalConverter on EdgeInsetsDirectional {
  pw.EdgeInsets toPdfEdgeInsetsDirectional() => pw.EdgeInsets.only(
        left: start,
        top: top,
        right: end,
        bottom: bottom,
      );
}
