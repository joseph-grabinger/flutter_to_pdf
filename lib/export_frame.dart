import 'package:flutter/material.dart';

import 'export_delegate.dart';

/// A widget that can be used to export a specific part of the widget tree.
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

  Widget get exportWidget => child;

  @override
  Widget build(BuildContext context) {
    _exportContext = context;
    exportDelegate.registerFrame(this);
    return child;
  }
}
