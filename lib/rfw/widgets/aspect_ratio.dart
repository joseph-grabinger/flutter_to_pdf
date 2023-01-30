import 'package:flutter/widgets.dart';
import 'package:rfw/rfw.dart';

import 'package:pdf/widgets.dart' as pw;

class RfwAspectRatio extends StatelessWidget {
  const RfwAspectRatio({
    Key? key,
    required this.source,
  }) : super(key: key);

  final DataSource source;

  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry() {
    return MapEntry('AspectRatio', (context, source) => RfwAspectRatio(
      source: source,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: source.v<double>(['aspectRatio']) ?? 1.0,
      child: source.optionalChild(['child']),
    );
  }

  /*
  @override
  pw.Widget toPdfWidget() {
    return pw.AspectRatio(
      aspectRatio: source.v<double>(['aspectRatio']) ?? 1.0,
      child: source.optionalChild(['child'])?.toPdfWidget(),
    );
  }
  */
}