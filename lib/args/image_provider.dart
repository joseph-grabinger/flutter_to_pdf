import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/widgets.dart' show ImageConfiguration, ImageProvider, ImageStreamListener;

import 'package:pdf/widgets.dart' as pw show ImageProvider, RawImage;


extension ImageProviderConverter on ImageProvider {
  Future<pw.ImageProvider> toPdfImageProvider() async {
    final MapEntry<Uint8List?, Size> tuple = await getBytes();

    return pw.RawImage(
      bytes: tuple.key!,
      width: tuple.value.width.toInt(),
      height: tuple.value.height.toInt(),
    );
  }
  
  /// Resolves the [ImageProvider]´s bytes
  /// and returns the bytes together with their [Size].
  Future<MapEntry<Uint8List?, Size>> getBytes({
    ImageByteFormat format = ImageByteFormat.rawRgba,
  }) async {
    Size? size;
    final imageStream = resolve(ImageConfiguration.empty);
    final Completer<Uint8List?> completer = Completer<Uint8List?>();
    final ImageStreamListener listener = ImageStreamListener(
      (imageInfo, synchronousCall) async {
        size = Size(
          imageInfo.image.width.toDouble(),
          imageInfo.image.height.toDouble(),
        );

        final bytes = await imageInfo.image.toByteData(format: format);

        if (!completer.isCompleted) {
          completer.complete(bytes?.buffer.asUint8List());
        }
      },
    );

    imageStream.addListener(listener);
    final imageBytes = await completer.future;
    imageStream.removeListener(listener);

    return MapEntry(imageBytes, size!);
  }
}
