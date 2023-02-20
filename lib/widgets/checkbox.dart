import 'package:flutter/material.dart' show Checkbox;

import 'package:pdf/pdf.dart' show PdfColors;
import 'package:pdf/widgets.dart' as pw show Checkbox, Widget;

import '/args/color.dart';


extension CheckboxConverter on Checkbox {
  pw.Widget toPdfWidget() => pw.Checkbox(
    name: hashCode.toString(),
    value: value!,
    tristate: tristate,
    activeColor: activeColor?.toPdfColor() ?? PdfColors.blue,
    checkColor: checkColor?.toPdfColor() ?? PdfColors.white,
  );
}
