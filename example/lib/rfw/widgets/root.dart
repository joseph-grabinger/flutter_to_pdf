import 'package:flutter/widgets.dart';

import 'package:rfw/rfw.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:example/rfw/create_widgets.dart';
import 'package:example/dynamic_data.dart';


class RfwRoot {
  final BuildContext context;
  final DataSource source;

  RfwRoot({
    Key? key,
    required this.context,
    required this.source,
    required dynamic state,
  });

  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry(dynamic state) {
    return MapEntry('Root', (context, source) {

      final root = Container(
        color: const Color(0xff888888),
        child: source.child(['child']),
      );

      state['context'] = context;
      state['source'] = source;

      return root;
    });
  }

  static pw.Widget toPdf(curried, DynamicData dyDa) {
    final args = curried.arguments;

    return pw.Container(
      child: rfwToPdf(args['child'], dyDa),
    );
  }
}