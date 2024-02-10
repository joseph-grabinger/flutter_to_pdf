import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'export_frame.dart';
import 'export_instance.dart';
import 'utils.dart';
import 'options/export_options.dart';

/// The delegate handling the high-level export of the widget tree.
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
  ExportDelegate copyWith({ExportOptions? options}) => ExportDelegate(
        options: options ?? this.options,
      );

  /// Exports the [ExportFrame] with the given [frameId] to a [pw.Document].
  Future<pw.Document> exportToPdfDocument(String frameId,
      {ExportOptions? overrideOptions}) async {
    final ExportFrame? frame = _registeredFrames[frameId];

    if (frame == null) {
      throw Exception('No frame with id $frameId found');
    }

    if (overrideOptions != null) {
      ExportDelegate delegate = copyWith(options: overrideOptions);
      return await delegate._exportDocument(
          frame.exportWidget, frame.exportContext!);
    }

    return await _exportDocument(frame.exportWidget, frame.exportContext!);
  }
    Future<pw.Document> exportWidgetToPdf(Widget widget, BuildContext context) async {
    return await _exportDocument(widget, context);
  }

  /// Exports the [ExportFrame] with the given [frameId] to a [pw.Page].
  Future<pw.Page> exportToPdfPage(String frameId,
      {ExportOptions? overrideOptions}) async {
    final ExportFrame frame = getFrame(frameId);

    if (overrideOptions != null) {
      ExportDelegate delegate = copyWith(options: overrideOptions);
      return await delegate._exportPage(
          frame.exportWidget, frame.exportContext!);
    }

    return await _exportPage(frame.exportWidget, frame.exportContext!);
  }

  /// Exports the [ExportFrame] with the given [frameId] to a [pw.Widget].
  Future<pw.Widget> exportToPdfWidget(String frameId,
      {ExportOptions? overrideOptions}) async {
    final ExportFrame frame = getFrame(frameId);

    if (overrideOptions != null) {
      ExportDelegate delegate = copyWith(options: overrideOptions);
      return await delegate._exportWidget(
          frame.exportWidget, frame.exportContext!);
    }

    return await _exportWidget(frame.exportWidget, frame.exportContext!);
  }

  /// Exports the given [widget] to a [pw.Widget].
  /// If [context] is not null, the widgets´ state is provided.
  Future<pw.Widget> _exportWidget(Widget widget, BuildContext? context) async {
    final ExportInstance exportInstance =
        ExportInstance(this, (Widget widget) => _exportWidget(widget, null));

    final Size layoutSize = options.pageFormatOptions.getAvailableSize();

    double? pixelRatio;
    if (context != null) {
      pixelRatio = MediaQuery.of(context).devicePixelRatio;
    }

    Element? element = layoutWidget(widget, layoutSize, pixelRatio);

    final List<pw.Widget> children =
        await exportInstance.matchWidget(element!, context);

    if (children.isEmpty) {
      throw Exception('No children found');
    }

    return children.first;
  }

  /// Exports the given [widget] to a [pw.Page].
  /// If [context] is not null, the widgets´ state is provided.
  Future<pw.Page> _exportPage(Widget widget, BuildContext? context) async {
    final pw.Widget pdfWidget = await _exportWidget(widget, context);

    return pw.Page(
      pageFormat: options.pageFormatOptions.getPageFormat(),
      clip: options.pageFormatOptions.clip,
      build: (pw.Context context) => pdfWidget,
    );
  }

  /// Exports the given [widget] to a [pw.Document].
  /// If [context] is not null, the widgets´ state is provided.
  Future<pw.Document> _exportDocument(
      Widget widget, BuildContext? context) async {
    final pw.Page pdfPage = await _exportPage(widget, context);

    final pw.Document pdf = pw.Document();

    pdf.addPage(pdfPage);

    return pdf;
  }
}
