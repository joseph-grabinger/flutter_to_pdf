import 'package:flutter/material.dart' show TextField;

import 'package:pdf/widgets.dart' as pw show TextField, Widget;

import '/args/text_style.dart';
import '/args/input_decoration.dart';


extension TextFieldConverter on TextField {
  pw.Widget toPdfWidget() {
    print('TextFieldConverter: $this');

    return pw.TextField(
      width: double.infinity,
      name: hashCode.toString(),
      defaultValue: controller?.value.text,
      textStyle: style?.toPdfTextStyle(),
      maxLength: maxLength,
      child: decoration?.toPdfWidget(),
      // child: pw.Container(
      //   height: 30,
      //   decoration: const pw.BoxDecoration(
      //     border: pw.Border(bottom: pw.BorderSide(width: 1.0)),
      //   ),
      // ),
    );
  }
}