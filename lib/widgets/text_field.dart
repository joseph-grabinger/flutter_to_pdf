import 'package:flutter/material.dart' show TextField;

import 'package:pdf/pdf.dart' show PdfFieldFlags;
import 'package:pdf/widgets.dart' as pw show TextField, Text, Widget, Container, EdgeInsets;

import '/options/text_field_options.dart';
import '/args/text_style.dart';
import '/args/input_decoration.dart';
import '/args/text_align.dart';
import '/args/text_direction.dart';


extension TextFieldConverter on TextField {
  pw.Widget toPdfWidget(TextFieldOptions options) {
    print('TextFieldConverter: $this');

    if (options.interactive) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(4.0),
        margin: const pw.EdgeInsets.all(8.0),
        decoration: decoration?.border?.toPdfInputBorder(),
        child: pw.TextField(
          width: double.infinity,
          name: hashCode.toString(),
          defaultValue: controller?.value.text,
          textStyle: (options.getTextStyle(key) ?? style)?.toPdfTextStyle(), // TODO textStyle not applied within pdf package
          maxLength: maxLength,
          fieldFlags: { // TODO flags not applied by pdf package
            if (maxLines != null && maxLines! > 1) PdfFieldFlags.multiline,
            if (obscureText) PdfFieldFlags.password,
          },
        ),
      );
    } else {
      return pw.Text(
        controller?.value.text ?? '',
        maxLines: maxLines,
        textAlign: textAlign.toPdfTextAlign(),
        textDirection: textDirection?.toPdfTextDirection(),
        style: (options.getTextStyle(key) ?? style)?.toPdfTextStyle(),
      );
    }
  }
}
