import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'export_frame.dart';
import 'export_instance.dart';
import 'utils.dart';
import 'options/export_options.dart';


const Key exportFrameKey = Key('FlutterToPDF.exportFrameKey');
class ExportDelegate {
  final ExportOptions options;

  ExportDelegate({this.options = const ExportOptions()});

  final Map<String, ExportFrame> _registeredFrames = {};

  /// Registers a new [ExportFrame] to the [ExportDelegate].
  void registerFrame(ExportFrame frame) {
    _registeredFrames[frame.frameId] = frame;
  }

  /// Returns the [ExportFrame] with the given [frameId].
  /// Throws an [Exception] if no [ExportFrame] is found.
  ExportFrame getFrame(String frameId) {
    final ExportFrame? frame = _registeredFrames[frameId];

    if (frame == null) {
      throw Exception('No frame with id $frameId found');
    }

    return frame;
  }

  /// Copies the [ExportDelegate] with the given [options].
  ExportDelegate copyWith({ExportOptions? options}) {
    return ExportDelegate(options: options ?? this.options);
  }

  /// Exports the [ExportFrame] with the given [frameId] to a [pw.Document].
  Future<pw.Document> exportFrame(String frameId, {ExportOptions? overrideOptions}) async {
    final ExportFrame? frame = _registeredFrames[frameId];

    if (frame == null) {
      throw Exception('No frame with id $frameId found');
    }

    if (overrideOptions != null) {
      ExportDelegate delegate = copyWith(options: overrideOptions);
      return await delegate.exportToPdfDocument(frame.exportChild, frame.exportContext!);
    }

    return await exportToPdfDocument(frame.exportChild, frame.exportContext!);
  }

  Future<pw.Page> exportFrameToPdfPage(String frameId, {ExportOptions? overrideOptions}) async {
    final ExportFrame frame = getFrame(frameId);

    if (overrideOptions != null) {
      ExportDelegate delegate = copyWith(options: overrideOptions);
      return await delegate.exportToPdfPage(frame.exportChild, frame.exportContext!);
    }

    return await exportToPdfPage(frame.exportChild, frame.exportContext!);
  }

  /// Exports the given [widget] to a [pw.Widget].
  /// If [context] is not null, the widgets´ state is provided.
  Future<pw.Widget> exportToPdfWidget(Widget widget, BuildContext? context) async {
    List<pw.Widget> children = [];

    final ExportInstance exportInstance = ExportInstance(this);

    await layoutWidget(widget, const Size(600, 400)).then(
      (Element? element) async => children = await exportInstance.matchWidget(element!, context));

    if (children.isEmpty) {
      throw Exception('No children found');
    }

    return children.first;
  }

  /// Exports the given [widget] to a [pw.Page].
  /// If [context] is not null, the widgets´ state is provided.
  Future<pw.Page> exportToPdfPage(Widget widget, BuildContext? context) async {
    final pw.Widget pdfWidget = await exportToPdfWidget(widget, context);

    return pw.Page(
      pageFormat: options.pageFormatOptions.getPageFormat(),
      clip: options.pageFormatOptions.clip,
      build: (pw.Context context) => pdfWidget,
    );
  }

  /// Exports the given [widget] to a [pw.Document].
  /// If [context] is not null, the widgets´ state is provided.
  Future<pw.Document> exportToPdfDocument(Widget widget, BuildContext? context) async {
    final pw.Page pdfPage = await exportToPdfPage(widget, context);

    final pw.Document pdf = pw.Document();

    pdf.addPage(pdfPage);

    return pdf;
  }
}
