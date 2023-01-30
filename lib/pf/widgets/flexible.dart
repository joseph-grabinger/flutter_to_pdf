import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import '../pf_widget.dart';

class PfFlexible extends PfWidget {
  const PfFlexible({
    Key? key,
    this.fit = PfFlexFit.loose,
    this.flex = 1,

    required this.child,
  }) : super(key: key);

  final int flex;
  final PfFlexFit fit;
  final PfWidget child;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      fit: fit.toFl(),
      child: child,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Flexible(
      flex: flex,
      fit: fit.toPw(),
      child: child.toPw(),
    );
  }
}