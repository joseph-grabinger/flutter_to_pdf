import 'package:flutter/widgets.dart';
import 'package:rfw/rfw.dart';

import 'package:pdf/widgets.dart' as pw;

class RfwColumn extends StatelessWidget {
  const RfwColumn({
    Key? key,
    required this.source,
  }) : super(key: key);

  final DataSource source;

  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry() {
    return MapEntry('Column', (context, source) => RfwColumn(
      source: source,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: ArgumentDecoders.enumValue<MainAxisAlignment>(MainAxisAlignment.values, source, ['mainAxisAlignment']) ?? MainAxisAlignment.start,
      mainAxisSize: ArgumentDecoders.enumValue<MainAxisSize>(MainAxisSize.values, source, ['mainAxisSize']) ?? MainAxisSize.max,
      crossAxisAlignment: ArgumentDecoders.enumValue<CrossAxisAlignment>(CrossAxisAlignment.values, source, ['crossAxisAlignment']) ?? CrossAxisAlignment.center,
      verticalDirection: ArgumentDecoders.enumValue<VerticalDirection>(VerticalDirection.values, source, ['verticalDirection']) ?? VerticalDirection.down,
      children: source.childList(['children']),
    );
  }

  /*
  @override
  toPdfWidget() {
    return pw.Column(
      mainAxisAlignment: ArgumentDecoders.enumValue<pw.MainAxisAlignment>(pw.MainAxisAlignment.values, source, ['mainAxisAlignment']) ?? pw.MainAxisAlignment.start,
      mainAxisSize: ArgumentDecoders.enumValue<pw.MainAxisSize>(pw.MainAxisSize.values, source, ['mainAxisSize']) ?? pw.MainAxisSize.max,
      crossAxisAlignment: ArgumentDecoders.enumValue<pw.CrossAxisAlignment>(pw.CrossAxisAlignment.values, source, ['crossAxisAlignment']) ?? pw.CrossAxisAlignment.center,
      verticalDirection: ArgumentDecoders.enumValue<pw.VerticalDirection>(pw.VerticalDirection.values, source, ['verticalDirection']) ?? pw.VerticalDirection.down,
      children: source.childList(['children']).map((child) => child.toPdfWidget()).toList(),
    );
  }
  */
}