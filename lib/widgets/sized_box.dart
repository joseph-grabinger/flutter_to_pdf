import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/teaplates.dart';


class PfSizedBox extends PfWidget {
  const PfSizedBox({
    Key? key,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final double? width;
  final double? height;
  final PfWidget? child;

  /// Creates a box that will become as large as its parent allows.
  const PfSizedBox.expand({ super.key, this.child })
    : width = double.infinity,
      height = double.infinity;

  /// Creates a box that will become as small as its parent allows.
  const PfSizedBox.shrink({ super.key, this.child })
    : width = 0.0,
      height = 0.0;

  /// Creates a box with the specified size.
  PfSizedBox.fromSize({ super.key, this.child, Size? size })
    : width = size?.width,
      height = size?.height;

  /// Creates a box whose [width] and [height] are equal.
  const PfSizedBox.square({super.key, this.child, double? dimension})
    : width = dimension,
      height = dimension;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.SizedBox(
      width: width,
      height: height,
      child: child?.toPw(),
    );
  }
}