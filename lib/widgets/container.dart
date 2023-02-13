import 'package:flutter/widgets.dart' show Alignment, BoxDecoration, Container, EdgeInsets;

import 'package:pdf/widgets.dart' as pw show Container, Widget;

import '../args/box_decoration.dart';
import '../args/alignment.dart';
import '../args/color.dart';
import '../args/box_constraints.dart';
import '../args/edge_insets.dart';


extension ContainerConverter on Container {
  Future<pw.Container> toPdfWidget(pw.Widget? child) async => pw.Container(
    alignment: (alignment as Alignment?)?.toPdfAlignment(),
    decoration: await (decoration as BoxDecoration?)?.toPdfBoxDecoration(),
    color: color?.toPdfColor(),
    constraints: constraints?.toPdfBoxConstraints(),
    foregroundDecoration: await (foregroundDecoration as BoxDecoration?)?.toPdfBoxDecoration(),
    margin: (margin as EdgeInsets?)?.toPdfEdgeInsets(),
    padding: (padding as EdgeInsets?)?.toPdfEdgeInsets(),
    transform: transform,
    child: child,
  );
}