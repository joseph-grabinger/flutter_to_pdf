import 'package:flutter/material.dart';

import 'traversal.dart';


// class ExportFrame extends StatefulWidget implements ExportCallback {
//   final ExportDelegate exportDelegate;
//   final Widget child;

  // const ExportFrame({
  //   required this.exportDelegate, 
  //   required this.child, 
  //   super.key,
  // });

//   @override
//   State<ExportFrame> createState() => _ExportFrameState();
// }

// class _ExportFrameState extends State<ExportFrame> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

class ExportFrame extends StatelessWidget implements ExportCallback {
  final String id;
  final ExportDelegate exportDelegate;
  final Widget child;

  const ExportFrame({
    required this.id,
    required this.exportDelegate, 
    required this.child, 
    super.key,
  });

  static BuildContext? _exportContext;

  @override
  BuildContext? get exportContext => _exportContext;

  @override
  Widget get exportChild => child;

  @override
  Widget build(BuildContext context) {
    _exportContext = context;
    exportDelegate.registerFrame(this);
    return child;
  }
}

abstract class ExportCallback {
  BuildContext? get exportContext;
  Widget get exportChild;
}