import 'package:flutter/widgets.dart'
    show
        EdgeInsets,
        EdgeInsetsDirectional,
        Padding,
        EdgeInsetsGeometry,
        debugPrint;

import 'package:flutter_to_pdf/args/edge_insets_directional.dart';

import 'package:pdf/widgets.dart' as pw show Padding, Widget;

import '/args/edge_insets.dart';

/// Extension on [Padding] to convert it to the pdf equivalent [pw.Padding].
extension PaddingConverter on Padding {
  /// Converts the [Padding] to a [pw.Padding].
  pw.Padding toPdfWidget(pw.Widget? child) => pw.Padding(
        padding: _convertEdge(padding),
        child: child,
      );

  _convertEdge(EdgeInsetsGeometry? edge) {
    if (edge is EdgeInsetsDirectional) return edge.toPdfEdgeInsetsDirectional();
    if (edge is EdgeInsets) return edge.toPdfEdgeInsets();
    debugPrint(
      'Unsupported EdgeInsetsGeometry: $this; defaulting to EdgeInsets.all(8.0)',
    );
    return const EdgeInsets.all(8.0);
  }
}
