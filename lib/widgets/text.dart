import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/teaplates.dart';
import 'package:teaplates/args/text_style.dart';


class PfText extends PfWidget {
  const PfText(this.text, {
    Key? key,
    this.style,
  }) : super(key: key);

  final String text;
  final PfTextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style?.toFl() ?? PfTextStyle.flStandard,
    );
  }

  @override
  pw.Widget toPw() {
    return pw.Text(
      text,
      style: style?.toPw() ?? PfTextStyle.pwStandard,
    );
  }
}