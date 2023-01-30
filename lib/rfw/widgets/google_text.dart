


import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:rfw/rfw.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:teaplates/rfw/create_widgets.dart';
import 'package:teaplates/rfw/pdf_argument_decoders.dart';


class RfwGoogleText {
  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry() {
    return MapEntry('GoogleText', (context, source) {
      final w = (source as RFWWidgetState).widget;

      return Container(
        alignment: ArgumentDecoders.alignment(source, ['alignment']),
        padding: ArgumentDecoders.edgeInsets(source, ['padding']),
        color: ArgumentDecoders.color(source, ['color']),
        decoration: ArgumentDecoders.decoration(source, ['decoration']),
        //foregroundDecoration: ArgumentDecoders.decoration(source, ['foregroundDecoration']),
        width: source.v<double>(['width']),
        height: source.v<double>(['height']),
        constraints: ArgumentDecoders.boxConstraints(source, ['constraints']),
        margin: ArgumentDecoders.edgeInsets(source, ['margin']),
        transform: ArgumentDecoders.matrix(source, ['transform']),
        child: source.optionalChild(['child']),
      );
    });
  }

  /*

  static pw.Widget toPdf(CurriedLocalWidget curried) async {
    final args = curried.arguments;

    final font = await PdfGoogleFonts;

    return pw.Container(
      alignment: PdfArgumentDecoders.alignment(args['alignment']),
      padding: PdfArgumentDecoders.edgeInsets(args['padding']),
      color: PdfArgumentDecoders.color(args['color']),
      decoration: PdfArgumentDecoders.decoration(args['decoration']),
      foregroundDecoration: PdfArgumentDecoders.decoration(args['foregroundDecoration']),
      width: PdfArgumentDecoders.v<double>(args['width']),
      height: PdfArgumentDecoders.v<double>(args['height']),
      constraints: PdfArgumentDecoders.boxConstraints(args['constraints']),
      margin: PdfArgumentDecoders.edgeInsets(args['margin']),
      transform: PdfArgumentDecoders.matrix(args['transform']),
      child: rfwToPdf(args['child'] as CurriedLocalWidget?),
    );
  }

  */
  
}

