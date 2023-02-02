
import 'package:flutter/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/page.dart';
import 'package:teaplates/args/font.dart';
import 'package:teaplates/args/color.dart';
import 'package:teaplates/args/font_style.dart';
import 'package:teaplates/args/font_weight.dart';



class PfTextStyle {
  PfTextStyle({
    this.color,
    PfFont? font,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.lineSpacing,
    this.height,
  }) : font = font ?? PfFont.helvetica;

  static TextStyle flStandard = const TextStyle(
    fontFamily: 'Helvetica',
    fontSize: 12.0 * pwToFlPx,
    fontWeight: FontWeight.normal,
  );

  static pw.TextStyle pwStandard = pw.TextStyle(
    font: pw.Font.helvetica(),
    fontSize: 12.0,
    fontWeight: pw.FontWeight.normal,
  );

  final PfColor? color;
  final PfFont font;
  final double? fontSize;
  final PfFontWeight? fontWeight;
  final PfFontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? lineSpacing;
  final double? height;

  TextStyle toFl() {
    return TextStyle(
      color: color?.toFl(),
      fontFamily: font.toFl(),
      fontSize: fontSize != null ? (fontSize! * pwToFlPx) : null,
      fontWeight: fontWeight?.toFl(),
      fontStyle: fontStyle?.toFl(),
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,

    );
  }

  pw.TextStyle toPw() {
    return pw.TextStyle(
      color: color?.toPw(),
      font: font.toPw(),
      fontSize: fontSize,
      fontWeight: fontWeight?.toPw(),
      fontStyle: fontStyle?.toPw(),
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
    );
  }
}