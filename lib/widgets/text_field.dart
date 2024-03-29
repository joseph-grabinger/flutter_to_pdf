import 'package:flutter/material.dart'
    show
        TextField,
        InputBorder,
        OutlineInputBorder,
        UnderlineInputBorder,
        debugPrint;

import 'package:pdf/pdf.dart' show PdfColors, PdfFieldFlags;
import 'package:pdf/widgets.dart' as pw
    show
        TextField,
        Text,
        Widget,
        Container,
        EdgeInsets,
        Stack,
        Positioned,
        Transform,
        Alignment,
        ConstrainedBox,
        BoxConstraints,
        BoxDecoration,
        Border,
        BorderSide;

import '../export_instance.dart';
import '/args/text_style.dart';
import '/args/text_align.dart';
import '/args/text_direction.dart';
import '/args/border_radius.dart';
import '/args/border_side.dart';

/// Extension on [InputBorder] to convert it to the pdf equivalent [pw.BoxDecoration].
extension TextFieldConverter on TextField {
  /// Converts the [TextField] to a [pw.Widget].
  Future<pw.Widget> toPdfWidget(
      ExportInstance instance, TextField? contextWidget) async {
    final TextField textField = contextWidget ?? this;

    pw.Widget? label;

    if (textField.decoration?.label != null) {
      final pw.Widget labelWidget =
          await instance.exportFunc(textField.decoration!.label!);

      label = pw.Transform.scale(
        scale: 0.6,
        child: pw.Container(
          color: PdfColors.white,
          padding: const pw.EdgeInsets.symmetric(horizontal: 2.0),
          child: labelWidget,
        ),
      );
    }

    if (textField.decoration?.labelText != null) {
      label = pw.Transform.scale(
        scale: 0.6,
        child: pw.Container(
          color: PdfColors.white,
          padding: const pw.EdgeInsets.symmetric(horizontal: 2.0),
          child: pw.Text(
            textField.decoration!.labelText!,
          ),
        ),
      );
    }

    return pw.Stack(
      alignment: pw.Alignment.center,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(8.0),
          margin: const pw.EdgeInsets.all(8.0),
          decoration:
              !instance.delegate.options.textFieldOptions.ignoreDecoration
                  ? textField.decoration?.border?.toPdfInputBorder()
                  : null,
          child: instance.delegate.options.textFieldOptions.interactive
              ? pw.TextField(
                  width: double.infinity,
                  name: textField.hashCode.toString(),
                  defaultValue: textField.controller?.value.text,
                  textStyle: await (instance.delegate.options.textFieldOptions
                              .getTextStyle(textField.key) ??
                          textField.style)
                      ?.toPdfTextStyle(instance.delegate.fontData),
                  maxLength: textField.maxLength,
                  fieldFlags: {
                    if (textField.maxLines != null && textField.maxLines! > 1)
                      PdfFieldFlags.multiline,
                    if (textField.obscureText) PdfFieldFlags.password,
                  },
                )
              : pw.ConstrainedBox(
                  constraints: const pw.BoxConstraints(
                      minHeight: 13, minWidth: double.infinity),
                  child: pw.Text(
                    textField.controller?.value.text ?? '',
                    maxLines: textField.maxLines,
                    textAlign: textField.textAlign.toPdfTextAlign(),
                    textDirection:
                        textField.textDirection?.toPdfTextDirection(),
                    style: await (instance.delegate.options.textFieldOptions
                                .getTextStyle(textField.key) ??
                            textField.style)
                        ?.toPdfTextStyle(instance.delegate.fontData),
                  )),
        ),
        if (label != null)
          pw.Positioned(
            left: 10.0,
            top: 0.0,
            child: label,
          ),
      ],
    );
  }
}

/// Extension on [InputBorder] to convert it to the pdf equivalent [pw.BoxDecoration].
extension InputBorderConverter on InputBorder {
  /// Converts the [InputBorder] to a [pw.BoxDecoration].
  pw.BoxDecoration toPdfInputBorder() {
    switch (runtimeType) {
      case OutlineInputBorder:
        return (this as OutlineInputBorder).toPdfOutlineInputBorder();
      case UnderlineInputBorder:
        return (this as UnderlineInputBorder).toPdfUnderlineInputBorder();
      default:
        debugPrint(
            'Unsupported InputBorder: $this; defaulting to empty BoxDecoration');
        return const pw.BoxDecoration();
    }
  }
}

/// Extension on [OutlineInputBorder] to convert it to the pdf equivalent [pw.BoxDecoration].
extension OutlineInputBorderConverter on OutlineInputBorder {
  /// Converts the [OutlineInputBorder] to a [pw.BoxDecoration].
  pw.BoxDecoration toPdfOutlineInputBorder() {
    final pw.BorderSide pdfBorderSide = borderSide.toPdfBorderSide();

    return pw.BoxDecoration(
      borderRadius: borderRadius.toPdfBorderRadius(),
      border: pw.Border.all(
        color: pdfBorderSide.color,
        width: pdfBorderSide.width,
        style: pdfBorderSide.style,
      ),
    );
  }
}

/// Extension on [UnderlineInputBorder] to convert it to the pdf equivalent [pw.BoxDecoration].
extension UnderLineInputBorderConverter on UnderlineInputBorder {
  /// Converts the [UnderlineInputBorder] to a [pw.BoxDecoration].
  pw.BoxDecoration toPdfUnderlineInputBorder() {
    final pw.BorderSide pdfBorderSide = borderSide.toPdfBorderSide();

    return pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: pdfBorderSide.color,
          width: pdfBorderSide.width,
          style: pdfBorderSide.style,
        ),
      ),
    );
  }
}
