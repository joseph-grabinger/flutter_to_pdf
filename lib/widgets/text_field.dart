import 'package:flutter/material.dart' show TextField;

import 'package:pdf/widgets.dart' as pw show TextField, Text, Widget;

import '/options/text_field_options.dart';
import '/args/text_style.dart';
import '/args/input_decoration.dart';


extension TextFieldConverter on TextField {
  pw.Widget toPdfWidget({TextFieldOptions options = const TextFieldOptions.none()}) {
    print('TextFieldConverter: $this');

    if (options.interactive) {
      return pw.TextField(
        width: double.infinity,
        name: hashCode.toString(),
        defaultValue: controller?.value.text,
        textStyle: style?.toPdfTextStyle(), // TODO apply options´ textStyle
        maxLength: maxLength,
        child: decoration?.toPdfWidget(),
      );
    } else {
      return pw.Text(
        controller?.value.text ?? '',
        style: style?.toPdfTextStyle(), // TODO apply options´ textStyle
      );
    }
  }
}