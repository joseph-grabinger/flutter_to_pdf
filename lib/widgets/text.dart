import 'package:flutter/widgets.dart' show Text;

import 'package:pdf/widgets.dart' as pw show Text;

import '/args/text_style.dart';


extension TextConverter on Text {
  pw.Text toPdfWidget() => pw.Text(data!,
    maxLines: maxLines,
    softWrap: softWrap,
    textScaleFactor: textScaleFactor ?? 1.0,
    style: style?.toPdfTextStyle(),
  );
}