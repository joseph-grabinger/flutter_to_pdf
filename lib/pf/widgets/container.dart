import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:teaplates/pf/args/edge_insets.dart';


import '../pf_arg_decoder.dart';
import '../pf_widget.dart';

class PfContainer extends PfWidget {
  const PfContainer({
    Key? key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final PfAlignment? alignment;
  final PfEdgeInsets? padding;
  final PfColor? color;
  final PfBoxDecoration? decoration;
  final double? width;
  final double? height;
  final PfWidget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment?.toFl(),
      padding: padding?.toFl(),
      color: color?.toFl(),
      decoration: decoration?.toFl(),
      width: width,
      height: height,
      child: child,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Container(
      alignment: alignment?.toPw(),
      padding: padding?.toPw(),
      color: color?.toPw(),
      decoration: decoration?.toPw(),
      width: width,
      height: height,
      child: child?.toPw(),
    );
  }
}

/*
  alignment: PdfArgumentDecoders.alignment(args['alignment']),
      padding: PdfArgumentDecoders.edgeInsets(args['padding']),
      color: PdfArgumentDecoders.color(args['color']),
      decoration: PdfArgumentDecoders.decoration(args['decoration']),
      foregroundDecoration: PdfArgumentDecoders.decoration(args['foregroundDecoration']),
      width: PdfArgumentDecoders.v<double>(args['width']),
      height: PdfArgumentDecoders.v<double>(args['height']),
      constraints: PdfArgumentDecoders.boxConstraints(args['constraints']),
      margin: PdfArgumentDecoders.edgeInsets(args['margin']),
      transform: PdfArgumentDecoders.matrix(args['transform']),
*/