import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart'
    show
        TextDecoration,
        TextDecorationStyle,
        TextStyle,
        FontStyle,
        FontWeight,
        debugPrint;

import 'package:pdf/widgets.dart' as pw
    show
        TextStyle,
        TextDecoration,
        TextDecorationStyle,
        Font,
        BoxDecoration,
        FontStyle,
        FontWeight;

import 'color.dart';

extension TextStyleConverter on TextStyle {
  Future<pw.TextStyle> toPdfTextStyle(Map<String, String> ttfFonts) async =>
      pw.TextStyle(
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
        font: fontFamily != null
            ? await resolveFont(fontFamily!, ttfFonts)
            : null,
        fontFallback: fontFamilyFallback != null
            ? await Future.wait(fontFamilyFallback!
                .map((String font) => resolveFont(font, ttfFonts)))
            : [],
        background: backgroundColor != null
            ? pw.BoxDecoration(
                color: backgroundColor!.toPdfColor(),
              )
            : null,
      );

  Future<pw.Font> resolveFont(String font, Map<String, String> ttfFonts) async {
    switch (font) {
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
        if (!ttfFonts.containsKey(font)) {
          throw Exception('Unsupported Font: $font');
        }
        return await resolveCustomFont(ttfFonts[font]!);
    }
  }

  Future<pw.Font> resolveCustomFont(String ttfFontPath) async {
    final bytes = await rootBundle.load(ttfFontPath);
    if (bytes.buffer.asInt8List().isEmpty) {
      throw Exception('Font file $ttfFontPath is empty');
    }
    return pw.Font.ttf(bytes);
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
        debugPrint(
            'Unsupported TextDecorationStyle: $this; defaulting to TextDecorationStyle.solid');
        return pw.TextDecorationStyle.solid;
    }
  }
}

extension FontStyleConverter on FontStyle {
  pw.FontStyle toPdfFontStyle() {
    switch (this) {
      case FontStyle.normal:
        return pw.FontStyle.normal;
      case FontStyle.italic:
        return pw.FontStyle.italic;
    }
  }
}

extension FontWeightConverter on FontWeight {
  pw.FontWeight toPdfFontWeight() {
    switch (this) {
      case FontWeight.normal:
        return pw.FontWeight.normal;
      case FontWeight.bold:
        return pw.FontWeight.bold;
      default:
        debugPrint(
            'Unsupported FontWeight: $this; defaulting to FontWeight.normal');
        return pw.FontWeight.normal;
    }
  }
}
