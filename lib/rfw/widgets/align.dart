import 'package:flutter/widgets.dart';
import 'package:rfw/rfw.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:teaplates/rfw/pdf_argument_decoders.dart';

class RfwAlign extends StatelessWidget {
  const RfwAlign({
    Key? key,
    required this.source,
  }) : super(key: key);

  final DataSource source;

  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry() {
    return MapEntry('Align', (context, source) => RfwAlign(
      source: source,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: ArgumentDecoders.alignment(source, ['alignment']) ?? Alignment.center,
      widthFactor: source.v<double>(['widthFactor']),
      heightFactor: source.v<double>(['heightFactor']),
      child: source.optionalChild(['child']),
    );
  }

  /*
  @override
  pw.Widget toPdfWidget() {
    return pw.Align(
      alignment: PdfArgumentDecoders.alignment(source, ['alignment']) ?? pw.Alignment.center,
      widthFactor: source.v<double>(['widthFactor']),
      heightFactor: source.v<double>(['heightFactor']),
      child: source.optionalChild(['child'])?.toPdfWidget(),
    );
  }
  */
}