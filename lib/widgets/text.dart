import 'package:flutter/widgets.dart' show Text, TextOverflow, TextSpan, InlineSpan;

import 'package:pdf/widgets.dart' as pw show Text, TextOverflow, TextSpan, RichText;

import '../export_instance.dart';
import '/args/text_style.dart';
import '/args/text_align.dart';
import '/args/text_direction.dart';

/// Extension on [Text] to convert it to the pdf equivalent [pw.Text].
extension TextConverter on Text {
  /// Converts the [Text] to a [pw.RichText] or its [pw.Text] subtype, 
  /// dependent on the [Text]'s configuration.
  Future<pw.RichText> toPdfWidget(ExportInstance instance) async => (data != null)
    ? await toPdfText(instance)
    : await toPdfRichText(instance);

  /// Converts the [Text] to a [pw.Text].
  Future<pw.Text> toPdfText(ExportInstance instance) async => pw.Text(
      data!,
      maxLines: maxLines,
      textAlign: textAlign?.toPdfTextAlign(),
      textDirection: textDirection?.toPdfTextDirection(),
      softWrap: softWrap,
      overflow: overflow?.toPdfTextOverflow(),
      // ignore: deprecated_member_use
      textScaleFactor: textScaleFactor ?? 1.0,
      style: await style?.toPdfTextStyle(instance.delegate.fontData),
    );

    /// Converts the [Text] to a [pw.RichText].
    Future<pw.RichText> toPdfRichText(ExportInstance instance) async => pw.RichText(
        text: await (textSpan as TextSpan).toPdfWidget(instance),
        textAlign: textAlign?.toPdfTextAlign(),
        textDirection: textDirection?.toPdfTextDirection(),
        softWrap: softWrap,
        overflow: overflow?.toPdfTextOverflow(),
        maxLines: maxLines,
      );
}

/// Extension on [TextSpan] to convert it to the pdf equivalent [pw.TextSpan].
extension TextSpanConverter on TextSpan {
  /// Converts the [TextSpan] to a [pw.TextSpan].
  Future<pw.TextSpan> toPdfWidget(ExportInstance instance) async => pw.TextSpan(
      text: text,
      style: await style?.toPdfTextStyle(instance.delegate.fontData),
      children: await Future.wait(children?.map(
        (InlineSpan e) async => await (e as TextSpan).toPdfWidget(instance)
      ) ?? []),
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
