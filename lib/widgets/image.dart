import 'package:flutter/widgets.dart' show Alignment, Image;

import 'package:pdf/widgets.dart' as pw show Image, BoxFit;

import '/args/image_provider.dart';
import '/args/box_fit.dart';
import '/args/alignment.dart';


extension ImageConverter on Image {
  Future<pw.Image> toPdfWidget() async => pw.Image(
    await image.toPdfImageProvider(),
    width: width,
    height: height,
    fit: fit?.toPdfBoxFit() ?? pw.BoxFit.contain,
    alignment: (alignment as Alignment).toPdfAlignment(),
  );
}
