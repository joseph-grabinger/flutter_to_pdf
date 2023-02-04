import 'package:flutter/widgets.dart';

import 'package:rfw/rfw.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:example/dynamic_data.dart';
import 'package:example/rfw/pdf_argument_decoders.dart';
import 'package:example/rfw/create_widgets.dart';


class RfwCenter {
  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry() {
    return MapEntry('Center', (context, source) {
      return Center(
        widthFactor: source.v<double>(['widthFactor']),
        heightFactor: source.v<double>(['heightFactor']),
        child: source.optionalChild(['child']), 
      );
    });
  }

  static pw.Widget toPdf(curried, DynamicData dyDa) {
    final args = curried.arguments;

    return pw.Center(
      widthFactor: PdfArgumentDecoders.v<double>(args['widthFactor']),
      heightFactor: PdfArgumentDecoders.v<double>(args['heightFactor']),
      child: rfwToPdf(args['child'], dyDa),
    );
  }
}

