import 'package:flutter/widgets.dart' show BorderSide;

import 'package:pdf/widgets.dart' as pw show BorderSide;

import 'border_style.dart';
import 'color.dart';


extension BorderSideConverter on BorderSide {
  pw.BorderSide toPdfBorderSide() => pw.BorderSide(
    color: color.toPdfColor(),
    width: width,
    style: style.toPdfBorderStyle(),
  );
}