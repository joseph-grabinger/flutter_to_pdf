import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import '../pf_widget.dart';

class PfAlign extends PfWidget {
  const PfAlign({
    Key? key,
    this.alignment = PfAlignment.center,
    this.widthFactor,
    this.heightFactor,
    this.child
  }): super(key: key);

  /// How to align the child.
  final PfAlignment alignment;

  /// If non-null, sets its width to the child's width multiplied by this factor.
  final double? widthFactor;

  /// If non-null, sets its height to the child's height multiplied by this factor.
  final double? heightFactor;

  final PfWidget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment.toFl(),
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: child,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Align(
      alignment: alignment.toPw(),
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: child?.toPw(),
    );
  }
}