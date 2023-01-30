import 'package:flutter/widgets.dart';
import 'package:rfw/rfw.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:teaplates/rfw/create_widgets.dart';
import 'package:teaplates/rfw/models/dynamic_data.dart';
import 'package:teaplates/rfw/pdf_argument_decoders.dart';

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

  static pw.Widget toPdf(CurriedLocalWidget curried, DynamicData dyDa) {
    final args = curried.arguments;

    return pw.Center(
      widthFactor: PdfArgumentDecoders.v<double>(args['widthFactor']),
      heightFactor: PdfArgumentDecoders.v<double>(args['heightFactor']),
      child: rfwToPdf(args['child'] as CurriedLocalWidget?, dyDa),
    );
  }
}

