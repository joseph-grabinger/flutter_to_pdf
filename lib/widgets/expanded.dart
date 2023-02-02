import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/teaplates.dart';


class PfExpanded extends PfWidget {
  const PfExpanded({
    Key? key,
    this.flex = 1,
    required this.child,
  }) : super(key: key);

  final int flex;
  final PfWidget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: child,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Expanded(
      flex: flex,
      child: child.toPw(),
    );
  }
}