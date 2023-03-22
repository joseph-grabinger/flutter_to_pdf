
import 'package:flutter/widgets.dart' show TextDecoration, TextDecorationStyle, TextStyle, debugPrint;

import 'package:pdf/widgets.dart' as pw show TextStyle, TextDecoration, TextDecorationStyle, Font, BoxDecoration;

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
    decorationStyle: decorationStyle?.toPdfTextDecorationStyle(),
    decorationThickness: decorationThickness,
    inherit: inherit,
    font: fontFamily != null ? resolveFont(fontFamily!) : null,
    fontFallback: fontFamilyFallback?.map<pw.Font>(
      (String font) => resolveFont(font)).toList() ?? [],
    background: backgroundColor != null ? pw.BoxDecoration(
      color: backgroundColor!.toPdfColor(),
    ) : null,
  );

  pw.Font resolveFont(String font) {
    switch (fontFamily) {
      case 'Courier':
        return pw.Font.courier();
      case 'Helvetica':
        return pw.Font.helvetica();
      case 'Times':
        return pw.Font.times();
      case 'ZapfDingbats':
        return pw.Font.zapfDingbats();
      case 'Symbol':
        return pw.Font.symbol();
      default:
        throw Exception('Unsupported Font: $font');
    }
  }
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

extension TextDecorationStyleConverter on TextDecorationStyle {
  pw.TextDecorationStyle toPdfTextDecorationStyle() {
    switch (this) {
      case TextDecorationStyle.solid:
        return pw.TextDecorationStyle.solid;
      case TextDecorationStyle.double:
        return pw.TextDecorationStyle.double;
      // not supported by pdf package:
      // - TextDecorationStyle.dotted
      // - TextDecorationStyle.dashed
      // - TextDecorationStyle.wavy
      default:
        debugPrint('Unsupported TextDecorationStyle: $this; defaulting to TextDecorationStyle.solid');
        return pw.TextDecorationStyle.solid;
    }
  }
}
