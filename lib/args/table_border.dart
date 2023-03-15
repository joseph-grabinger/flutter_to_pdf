import 'package:flutter/widgets.dart' show TableBorder;

import 'package:pdf/widgets.dart' as pw show TableBorder;

import '/args/border_side.dart';


extension TableBorderConverter on TableBorder {
  pw.TableBorder toPdfTableBorder() => pw.TableBorder(
    horizontalInside: horizontalInside.toPdfBorderSide(),
    verticalInside: verticalInside.toPdfBorderSide(),
    top: top.toPdfBorderSide(),
    right: right.toPdfBorderSide(),
    bottom: bottom.toPdfBorderSide(),
    left: left.toPdfBorderSide(),
  );
}
