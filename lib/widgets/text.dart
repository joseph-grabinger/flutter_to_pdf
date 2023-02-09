import 'package:flutter/widgets.dart' show Text;

import 'package:pdf/widgets.dart' as pw show Text, TextStyle;

import 'package:teaplates/args/color.dart';
import 'package:teaplates/args/font_style.dart';
import 'package:teaplates/args/font_weight.dart';


extension TextConverter on Text {
  pw.Text toPDFWidget() => pw.Text(data!,
    style: style != null ? pw.TextStyle(
      color: style!.color != null ? style!.color!.toPdfColor() : null,
      fontSize: style!.fontSize,
      fontStyle: style!.fontStyle != null ? style!.fontStyle!.toPdfFontStyle() : null,
      fontWeight: style!.fontWeight != null ? style!.fontWeight!.toPdfFontWeight() : null,
      height: style!.height,
      letterSpacing: style!.letterSpacing,
      wordSpacing: style!.wordSpacing,
      // TODO add remaining style options
    ) : null,
  );
}