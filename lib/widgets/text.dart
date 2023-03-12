import 'package:flutter/widgets.dart' show Text;

import 'package:pdf/widgets.dart' as pw show Text;

import '/args/text_style.dart';
import '/args/text_align.dart';
import '/args/text_direction.dart';
import '/args/text_overflow.dart';


extension TextConverter on Text {
  pw.Text toPdfWidget() => pw.Text(data!,
    maxLines: maxLines,
    textAlign: textAlign?.toPdfTextAlign(),
    textDirection: textDirection?.toPdfTextDirection(),
    softWrap: softWrap,
    overflow: overflow?.toPdfTextOverflow(),
    textScaleFactor: textScaleFactor ?? 1.0,
    style: style?.toPdfTextStyle(),
  );
}
