import 'package:flutter/widgets.dart' show Alignment, DecorationImage;

import 'package:pdf/widgets.dart' as pw show DecorationImage, BoxFit;

import '/args/image_provider.dart';
import '/args/alignment.dart';
import '/args/box_fit.dart';


extension DecorationImageConverter on DecorationImage {
  Future<pw.DecorationImage> toPdfDecorationImage() async => pw.DecorationImage(
    image: await image.toPdfImageProvider(),
    fit: fit?.toPdfBoxFit() ?? pw.BoxFit.cover,
    alignment: (alignment as Alignment).toPdfAlignment(),
  );
}