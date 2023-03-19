import 'package:flutter/material.dart';

import 'traversal.dart';


class ExportFrame extends StatelessWidget {
  final String frameId;
  final ExportDelegate exportDelegate;
  final Widget child;

  const ExportFrame({
    required this.frameId,
    required this.exportDelegate, 
    required this.child, 
    super.key,
  });

  static BuildContext? _exportContext;

  BuildContext? get exportContext => _exportContext;

  Widget get exportChild => child;

  @override
  Widget build(BuildContext context) {
    _exportContext = context;
    exportDelegate.registerFrame(this);
    return child;
  }
}
