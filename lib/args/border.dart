import 'package:flutter/widgets.dart' show Border;

import 'package:pdf/widgets.dart' as pw show Border;

import 'border_side.dart';


extension BorderConverter on Border {
  pw.Border toPdfBorder() {
    print('BorderConverter: $this');
    
    return pw.Border(
    top: top.toPdfBorderSide(),
    right: right.toPdfBorderSide(),
    bottom: bottom.toPdfBorderSide(),
    left: left.toPdfBorderSide(),
  );
  }
}
