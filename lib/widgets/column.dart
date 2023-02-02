import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/teaplates.dart';
import 'package:teaplates/args/cross_axis_alignment.dart';
import 'package:teaplates/args/main_axis_alignment.dart';
import 'package:teaplates/args/main_axis_size.dart';
import 'package:teaplates/args/vertical_direction.dart';


class PfColumn extends PfWidget {
  const PfColumn({
    Key? key,
    this.mainAxisAlignment = PfMainAxisAlignment.start,
    this.mainAxisSize = PfMainAxisSize.max,
    this.crossAxisAlignment = PfCrossAxisAlignment.center,
    this.verticalDirection = PfVerticalDirection.down,
    this.children = const <PfWidget>[],
  }) : super(key: key);

  final PfMainAxisAlignment mainAxisAlignment;
  final PfMainAxisSize mainAxisSize;
  final PfCrossAxisAlignment crossAxisAlignment;
  final PfVerticalDirection verticalDirection;
  final List<PfWidget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment.toFl(),
      mainAxisSize: mainAxisSize.toFl(),
      crossAxisAlignment: crossAxisAlignment.toFl(),
      verticalDirection: verticalDirection.toFl(),
      children: children,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Column(
      mainAxisAlignment: mainAxisAlignment.toPw(),
      mainAxisSize: mainAxisSize.toPw(),
      crossAxisAlignment: crossAxisAlignment.toPw(),
      verticalDirection: verticalDirection.toPw(),
      children: children.map((e) => e.toPw()).toList(),
    );
  }
}