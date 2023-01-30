import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import '../pf_widget.dart';

class PfCenter extends PfWidget {
  const PfCenter({
    Key? key,
    this.child,
  }) : super(key: key);

  final PfWidget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Center(
      child: child?.toPw(),
    );
  }
}