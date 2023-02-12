import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/widgets.dart' show BuildContext, ImageProvider, ImageStreamListener, createLocalImageConfiguration;

import 'package:pdf/widgets.dart' as pw show ImageProvider, MemoryImage;


extension ImageProviderConverter on ImageProvider {
  Future<pw.ImageProvider> toPdfImageProvider(BuildContext context) async {
    final Uint8List? bytes = await getBytes(context);
    return pw.MemoryImage(bytes!);
  }
  
  Future<Uint8List?> getBytes(BuildContext context, {ImageByteFormat format = ImageByteFormat.rawRgba}) async {
    final imageStream = resolve(createLocalImageConfiguration(context));
    final Completer<Uint8List?> completer = Completer<Uint8List?>();
    final ImageStreamListener listener = ImageStreamListener(
      (imageInfo, synchronousCall) async {
        final bytes = await imageInfo.image.toByteData(format: format);
        if (!completer.isCompleted) {
          completer.complete(bytes?.buffer.asUint8List());
        }
      },
    );

    imageStream.addListener(listener);
    final imageBytes = await completer.future;
    imageStream.removeListener(listener);

    return imageBytes;
  }
}