import 'package:flutter/widgets.dart';
import 'package:rfw/rfw.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:teaplates/rfw/models/dynamic_data.dart';
import 'package:teaplates/rfw/pdf_argument_decoders.dart';


class RfwText {
  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry() {
    return MapEntry('Text', (context, source) {

      String? text = source.v<String>(['text']);
      if (text == null) {
        final StringBuffer builder = StringBuffer();
        final int count = source.length(['text']);
        for (int index = 0; index < count; index += 1) {
          builder.write(source.v<String>(['text', index]) ?? '');
        }
        text = builder.toString();
      }

      return Text(
        text,
        style: ArgumentDecoders.textStyle(source, ['style']),
        textAlign: ArgumentDecoders.enumValue<TextAlign>(TextAlign.values, source, ['textAlign']),
        textDirection: ArgumentDecoders.enumValue<TextDirection>(TextDirection.values, source, ['textDirection']),
        softWrap: source.v<bool>(['softWrap']),
        overflow: ArgumentDecoders.enumValue<TextOverflow>(TextOverflow.values, source, ['overflow']),
        textScaleFactor: source.v<double>(['textScaleFactor']),
        maxLines: source.v<int>(['maxLines']),
      );

    });
  }

  static pw.Widget toPdf(CurriedLocalWidget curried, DynamicData dyDa) {
    final args = curried.arguments;

    String? text = dyDa.v<String>(args['text']);
    //print((args['text'] as DataReference).parts);
    if (text == null) {
      if (args['text'] is List) {
        final lst = args['text'] as List;
        final StringBuffer builder = StringBuffer();
        final int count = lst.length;
        for (int index = 0; index < count; index += 1) {
          builder.write(dyDa.v<String>(lst[index]) ?? '');
        }
        text = builder.toString();
      }
    }
    return pw.Text(
      text ?? '',
      style: PdfArgumentDecoders.textStyle(args['style']),
      textAlign: PdfArgumentDecoders.enumValue<pw.TextAlign>(pw.TextAlign.values, args['textAlign']),
      textDirection: PdfArgumentDecoders.enumValue<pw.TextDirection>(pw.TextDirection.values, args['textDirection']),
      softWrap: dyDa.v<bool>(args['softWrap']),
      overflow: PdfArgumentDecoders.enumValue<pw.TextOverflow>(pw.TextOverflow.values, args['overflow']),
      textScaleFactor: dyDa.v<double>(args['textScaleFactor']) ?? 1.0,
      maxLines: dyDa.v<int>(args['maxLines']),
    );
  }
}