import 'package:flutter/widgets.dart' show Text, TextOverflow;

import 'package:pdf/widgets.dart' as pw show Text, TextOverflow;

import '/args/text_style.dart';
import '/args/text_align.dart';
import '/args/text_direction.dart';

/// Extension on [Text] to convert it to the pdf equivalent [pw.Text].
extension TextConverter on Text {
  /// Converts the [Text] to a [pw.Text].
  pw.Text toPdfWidget() => pw.Text(
        data!,
        maxLines: maxLines,
        textAlign: textAlign?.toPdfTextAlign(),
        textDirection: textDirection?.toPdfTextDirection(),
        softWrap: softWrap,
        overflow: overflow?.toPdfTextOverflow(),
        textScaleFactor: textScaleFactor ?? 1.0,
        style: style?.toPdfTextStyle(),
      );
}

/// Extension on [TextOverflow] to convert it to the pdf equivalent [pw.TextOverflow].
extension TextOverlfowConverter on TextOverflow {
  /// Converts the [TextOverflow] to a [pw.TextOverflow].
  pw.TextOverflow toPdfTextOverflow() {
    switch (this) {
      case TextOverflow.clip:
        return pw.TextOverflow.clip;
      case TextOverflow.visible:
        return pw.TextOverflow.visible;
      // not supported in pdf package:
      // - TextOverflow.ellipsis
      // - TextOverflow.fade
      default:
        return pw.TextOverflow.span;
    }
  }
}
