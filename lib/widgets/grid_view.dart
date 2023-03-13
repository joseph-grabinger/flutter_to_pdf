import 'package:flutter/widgets.dart' show EdgeInsets, GridView, SliverGridDelegate, SliverGridDelegateWithFixedCrossAxisCount, SliverGridDelegateWithMaxCrossAxisExtent, BoxConstraints;

import 'package:pdf/widgets.dart' as pw show GridView, Widget, EdgeInsets;

import '/args/edge_insets.dart';
import '/args/axis.dart';


extension GridViewConverter on GridView {
  pw.GridView toPdfWidget(List<pw.Widget> children, BoxConstraints constraints) => pw.GridView(
    crossAxisCount: gridDelegate.toPdfCrossAxisCount(constraints),
    crossAxisSpacing: gridDelegate.toPdfCrossAxisSpacing(),
    mainAxisSpacing: gridDelegate.toPdfMainAxisSpacing(),
    childAspectRatio: gridDelegate.toPdfChildAspectRatio(),
    padding: (padding as EdgeInsets?)?.toPdfEdgeInsets() ?? pw.EdgeInsets.zero,
    direction: scrollDirection.toPdfAxis(),
    children: children,
  );
}

extension SliverGridDelegateConverter on SliverGridDelegate {
  int toPdfCrossAxisCount(BoxConstraints constraints) {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount).crossAxisCount;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        final maxCrossAxisExtent = (this as SliverGridDelegateWithMaxCrossAxisExtent).maxCrossAxisExtent;
        return (constraints.maxWidth / maxCrossAxisExtent).ceil();
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }

  double toPdfCrossAxisSpacing() {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount).crossAxisSpacing;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        return (this as SliverGridDelegateWithMaxCrossAxisExtent).crossAxisSpacing;
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }

  double toPdfMainAxisSpacing() {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount).mainAxisSpacing;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        return (this as SliverGridDelegateWithMaxCrossAxisExtent).mainAxisSpacing;
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }

  double toPdfChildAspectRatio() {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount).childAspectRatio;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        return (this as SliverGridDelegateWithMaxCrossAxisExtent).childAspectRatio;
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }
}
