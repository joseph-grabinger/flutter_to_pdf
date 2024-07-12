import 'package:flutter/widgets.dart' show BoxDecoration, Container;

import 'package:flutter_to_pdf/args/alignment.dart';
import 'package:pdf/widgets.dart' as pw show Container, Widget;

import '../args/box_decoration.dart';
import '../args/color.dart';
import '../args/box_constraints.dart';
import '../args/edge_insets.dart';

/// Extension on [Container] to convert it to the pdf equivalent [pw.Container].
extension ContainerConverter on Container {
  /// Converts the [Container] to a [pw.Container].
  Future<pw.Container> toPdfWidget(pw.Widget? child) async => pw.Container(
        alignment: alignment?.toPdfAlignment(),
        decoration: await (decoration as BoxDecoration?)?.toPdfBoxDecoration(),
        color: color?.toPdfColor(),
        constraints: constraints?.toPdfBoxConstraints(),
        foregroundDecoration: await (foregroundDecoration as BoxDecoration?)
            ?.toPdfBoxDecoration(),
        margin: margin?.toPdfEdgeInsets(),
        padding: padding?.toPdfEdgeInsets(),
        transform: transform,
        child: child,
      );
}
