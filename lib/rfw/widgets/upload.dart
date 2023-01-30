import 'package:flutter/widgets.dart';
import 'package:rfw/rfw.dart';

class Upload extends StatelessWidget {
  const Upload({
    Key? key,
    required this.source
  }) : super(key: key);

  final DataSource source;

  static MapEntry<String, Widget Function(BuildContext, DataSource)> toEntry() {
    return MapEntry('Upload', (context, source) => Upload(
      source: source,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff888888),
      child: source.child(['child']),
    );
  }
}