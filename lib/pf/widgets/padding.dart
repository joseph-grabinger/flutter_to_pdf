import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import '../pf_widget.dart';

class PfPadding extends PfWidget {
  const PfPadding({
    Key? key,
    this.padding = const PfEdgeInsets.all(0.0),
    this.child,
  }) : super(key: key);

  final PfEdgeInsets padding;
  final PfWidget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding.toFl(),
      child: child,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Padding(
      padding: padding.toPw(),
      child: child?.toPw(),
    );
  }
}