import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/widgets.dart' show ImageConfiguration, ImageProvider, ImageStreamListener;

import 'package:pdf/widgets.dart' as pw show ImageProvider, RawImage;

import '/types/tuple.dart';


extension ImageProviderConverter on ImageProvider {
  Future<pw.ImageProvider> toPdfImageProvider() async {
    final Tuple<Uint8List?, Size> tuple = await getBytes();

    return pw.RawImage(
      bytes: tuple.fst!,
      width: tuple.snd.width.toInt(),
      height: tuple.snd.height.toInt(),
    );
  }
  
  Future<Tuple<Uint8List?, Size>> getBytes({ImageByteFormat format = ImageByteFormat.rawRgba}) async {
    Size? size;
    final imageStream = resolve(ImageConfiguration.empty);
    final Completer<Uint8List?> completer = Completer<Uint8List?>();
    final ImageStreamListener listener = ImageStreamListener(
      (imageInfo, synchronousCall) async {
        size = Size(imageInfo.image.width.toDouble(), imageInfo.image.height.toDouble());
        final bytes = await imageInfo.image.toByteData(format: format);
        if (!completer.isCompleted) {
          completer.complete(bytes?.buffer.asUint8List());
        }
      },
    );

    imageStream.addListener(listener);
    final imageBytes = await completer.future;
    imageStream.removeListener(listener);

    return Tuple(imageBytes, size!);
  }
}