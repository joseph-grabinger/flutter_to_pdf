
import 'package:flutter/widgets.dart' show TextStyle, TextDecoration;

import 'package:pdf/widgets.dart' as pw show TextStyle, TextDecoration;

import 'color.dart';
import 'font_style.dart';
import 'font_weight.dart';


extension TextStyleConverter on TextStyle {
  pw.TextStyle toPdfTextStyle() => pw.TextStyle(
    color: color?.toPdfColor(),
    fontSize: fontSize,
    fontStyle: fontStyle?.toPdfFontStyle(),
    fontWeight: fontWeight?.toPdfFontWeight(),
    height: height,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    decoration: decoration?.toPdfTextDecoration(),
    decorationColor: decorationColor?.toPdfColor(),
    // TODO add remaining style options
  );
}

extension TextDecorationConverter on TextDecoration {
  pw.TextDecoration toPdfTextDecoration() {
    pw.TextDecoration textDecoration = pw.TextDecoration.none;
    if (contains(TextDecoration.underline)) {
      textDecoration.merge(pw.TextDecoration.underline);
    }
    if (contains(TextDecoration.overline)) {
      textDecoration.merge(pw.TextDecoration.overline);
    }
    if (contains(TextDecoration.lineThrough)) {
      textDecoration.merge(pw.TextDecoration.lineThrough);
    }

    return textDecoration;
  }
}