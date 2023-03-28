import 'package:flutter/widgets.dart'
    show
        EdgeInsets,
        GridView,
        SliverGridDelegate,
        SliverGridDelegateWithFixedCrossAxisCount,
        SliverGridDelegateWithMaxCrossAxisExtent,
        BoxConstraints;

import 'package:pdf/widgets.dart' as pw show GridView, Widget, EdgeInsets;

import '/args/edge_insets.dart';
import '/args/axis.dart';

/// Extension on [GridView] to convert it to the pdf equivalent [pw.GridView].
extension GridViewConverter on GridView {
  /// Converts the [GridView] to a [pw.GridView].
  pw.GridView toPdfWidget(
          List<pw.Widget> children, BoxConstraints constraints) =>
      pw.GridView(
        crossAxisCount: gridDelegate.toPdfCrossAxisCount(constraints),
        crossAxisSpacing: gridDelegate.toPdfCrossAxisSpacing(),
        mainAxisSpacing: gridDelegate.toPdfMainAxisSpacing(),
        childAspectRatio: gridDelegate.toPdfChildAspectRatio(),
        padding:
            (padding as EdgeInsets?)?.toPdfEdgeInsets() ?? pw.EdgeInsets.zero,
        direction: scrollDirection.toPdfAxis(),
        children: children,
      );
}

/// Extension on [SliverGridDelegate] to convert it to the pdf equivalent [int].
extension SliverGridDelegateConverter on SliverGridDelegate {
  /// Gets the cross axis count of the [SliverGridDelegate].
  int toPdfCrossAxisCount(BoxConstraints constraints) {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount)
            .crossAxisCount;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        final maxCrossAxisExtent =
            (this as SliverGridDelegateWithMaxCrossAxisExtent)
                .maxCrossAxisExtent;
        return (constraints.maxWidth / maxCrossAxisExtent).ceil();
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }

  /// Gets the cross axis spacing of the [SliverGridDelegate].
  double toPdfCrossAxisSpacing() {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount)
            .crossAxisSpacing;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        return (this as SliverGridDelegateWithMaxCrossAxisExtent)
            .crossAxisSpacing;
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }

  /// Gets the main axis spacing of the [SliverGridDelegate].
  double toPdfMainAxisSpacing() {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount)
            .mainAxisSpacing;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        return (this as SliverGridDelegateWithMaxCrossAxisExtent)
            .mainAxisSpacing;
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }

  /// Gets the child aspect ratio of the [SliverGridDelegate].
  double toPdfChildAspectRatio() {
    switch (runtimeType) {
      case SliverGridDelegateWithFixedCrossAxisCount:
        return (this as SliverGridDelegateWithFixedCrossAxisCount)
            .childAspectRatio;
      case SliverGridDelegateWithMaxCrossAxisExtent:
        return (this as SliverGridDelegateWithMaxCrossAxisExtent)
            .childAspectRatio;
      default:
        throw Exception('Unsupported SliverGridDelegate: $runtimeType');
    }
  }
}
