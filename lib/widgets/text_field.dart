import 'package:flutter/material.dart' show TextField;

import 'package:pdf/widgets.dart' as pw show TextField, Text, Widget;

import '/options/text_field_options.dart';
import '/args/text_style.dart';
import '/args/input_decoration.dart';
import '/args/text_align.dart';
import '/args/text_direction.dart';


extension TextFieldConverter on TextField {
  pw.Widget toPdfWidget(TextFieldOptions options) {
    print('TextFieldConverter: $this');

    if (options.interactive) {
      return pw.TextField(
        width: double.infinity,
        name: hashCode.toString(),
        defaultValue: controller?.value.text,
        textStyle: (options.getTextStyle(key) ?? style)?.toPdfTextStyle(),
        maxLength: maxLength,
        child: decoration?.toPdfWidget(),
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