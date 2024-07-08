import 'package:flutter/widgets.dart'
    show
        Alignment,
        BoxDecoration,
        Container,
        EdgeInsets,
        AlignmentDirectional,
        AlignmentGeometry,
        EdgeInsetsGeometry,
        EdgeInsetsDirectional,
        debugPrint;

import 'package:flutter_to_pdf/args/alignment.dart';
import 'package:flutter_to_pdf/args/edge_insets_directional.dart';

import 'package:pdf/widgets.dart' as pw show Container, Widget;

import '../args/box_decoration.dart';
import '../args/color.dart';
import '../args/box_constraints.dart';
import '../args/edge_insets.dart';

/// Extension on [Container] to convert it to the pdf equivalent [pw.Container].
extension ContainerConverter on Container {
  /// Converts the [Container] to a [pw.Container].
  Future<pw.Container> toPdfWidget(pw.Widget? child) async => pw.Container(
        alignment: _convertAlignment(alignment),
        decoration: await (decoration as BoxDecoration?)?.toPdfBoxDecoration(),
        color: color?.toPdfColor(),
        constraints: constraints?.toPdfBoxConstraints(),
        foregroundDecoration: await (foregroundDecoration as BoxDecoration?)
            ?.toPdfBoxDecoration(),
        margin: _convertEdge(margin),
        padding: _convertEdge(padding),
        transform: transform,
        child: child,
      );

  _convertAlignment(AlignmentGeometry? alignment) {
    if (alignment is Alignment) return alignment.toPdfAlignment();
    if (alignment is AlignmentDirectional) return alignment.toPdfAlignment();
    debugPrint('Unsupported AlignmentGeometry: $this; defaulting to null');
    return null;
  }

  _convertEdge(EdgeInsetsGeometry? edge) {
    if (edge is EdgeInsetsDirectional) return edge.toPdfEdgeInsetsDirectional();
    if (edge is EdgeInsets) return edge.toPdfEdgeInsets();
    debugPrint('Unsupported EdgeInsetsGeometry: $this; defaulting to null');
    return null;
  }
}
