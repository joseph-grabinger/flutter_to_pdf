


import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PfArgDecoder {
  const PfArgDecoder._();

  /// This is a workaround for https://github.com/dart-lang/sdk/issues/47021
  static const PfArgDecoder __ = PfArgDecoder._(); // ignore: unused_field

  static PdfColor? color(Color? color) {
    if (color == null) return null;
    return PdfColor.fromInt(color.value);
  }

  static pw.Alignment? alignment(Alignment? alignment) {
    if (alignment == null) return null;
    return pw.Alignment(alignment.x, alignment.y);
  }

  static pw.EdgeInsets? edgeInsets(EdgeInsets? edgeInsets) {
    if (edgeInsets == null) return null;
    return pw.EdgeInsets.fromLTRB(
      edgeInsets.left,
      edgeInsets.top,
      edgeInsets.right,
      edgeInsets.bottom,
    );
  }

  static T? enumValue<T>(List<T> values, String key) {
    for (final value in values) {
      if (value.toString().split('.').last == key) {
        return value;
      }
    }
    return null;
  }
}