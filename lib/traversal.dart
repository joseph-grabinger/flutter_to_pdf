import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'options/export_options.dart';
import 'widgets/container.dart';
import 'widgets/center.dart';
import 'widgets/sized_box.dart';
import 'widgets/fitted_box.dart';
import 'widgets/limited_box.dart';
import 'widgets/constrained_box.dart';
import 'widgets/transform.dart';
import 'widgets/padding.dart';
import 'widgets/align.dart';
import 'widgets/positioned.dart';
import 'widgets/expanded.dart';
import 'widgets/flexible.dart';
import 'widgets/placeholder.dart';
import 'widgets/text.dart';
import 'widgets/text_field.dart';
import 'widgets/divider.dart';
import 'widgets/image.dart';
import 'widgets/checkbox.dart';
import 'widgets/button.dart';
import 'widgets/column.dart';
import 'widgets/row.dart';
import 'widgets/stack.dart';
import 'widgets/list_view.dart';
import 'widgets/grid_view.dart';
import 'widgets/wrap.dart';
import 'widgets/table.dart';


/// Exports the provided [context] to a PDF file
/// and applies the [options].
Future<pw.Document> exportToPDF(BuildContext context, {
  ExportOptions options = const ExportOptions(),
}) async {
  final pw.Widget? pdfWidget = await traverseWidgetTree(context, options);

  final pw.Document pdf = pw.Document();

  pdf.addPage(pw.Page(
    pageFormat: options.pageFormatOptions.getPageFormat(),
    clip: options.pageFormatOptions.clip,
    build: (pw.Context context) => pdfWidget!,
  ));

  return pdf;
}

/// Exports the provided [context] to a [pw.Page]
/// and applies the [options].
Future<pw.Page> exportToPdfPage(BuildContext context, {
  ExportOptions options = const ExportOptions(),
}) async {
  final pw.Widget? pdfWidget = await traverseWidgetTree(context, options);

  return pw.Page(
    pageFormat: options.pageFormatOptions.getPageFormat(),
    clip: options.pageFormatOptions.clip,
    build: (pw.Context context) => pdfWidget!,
  );
}

/// Traverses the widget tree of the provided [context]
/// and returns the corresponding PDF widget tree.
Future<pw.Widget?> traverseWidgetTree(BuildContext context, ExportOptions options) async {
  Element? element;

  context.visitChildElements((Element e) async {
    debugPrint('Initial: $e');
    element = e;
  });

  pw.Widget? pdfWidget = (await matchWidget(element!, options)).first;

  debugPrint('initial PDF Widget: $pdfWidget');

  return pdfWidget;
}

/// Recursive helper to visit all child elements of the provided [element].
Future<List<pw.Widget>> visit(Element element, ExportOptions options) async {
  List<Element> elements = [];

  element.visitChildElements((Element element) async {
    debugPrint('Element ${element.depth}: ${element.widget}');
    elements.add(element);
  });

  List<pw.Widget> children = [];

  for (Element e in elements) {
    children.addAll(await matchWidget(e, options));
  }

  debugPrint('returned: $children');

  return children;
}

/// Matches the widget provided as [element]
/// and returns the corresponding [pw.Widget].
Future<List<pw.Widget>> matchWidget(Element element, ExportOptions options) async {
  final Widget widget = element.widget;

  switch (widget.runtimeType) {
    case MergeSemantics: //anchor: end of widget tree
      debugPrint('Reached Anchor');
      return [];
    case Container:
      final List children = await visit(element, options);
      return [await (widget as Container).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case Center:
      final List children = await visit(element, options);
      return [(widget as Center).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case SizedBox:
      final List children = await visit(element, options);
      return [(widget as SizedBox).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case FittedBox:
      final List children = await visit(element, options);
      return [(widget as FittedBox).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case LimitedBox:
      final List children = await visit(element, options);
      return [(widget as LimitedBox).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case ConstrainedBox:
      final List children = await visit(element, options);
      return [(widget as ConstrainedBox).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case Transform:
      final List children = await visit(element, options);
      return [(widget as Transform).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case Padding:
      final List children = await visit(element, options);
      return [(widget as Padding).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case Align:
      final List children = await visit(element, options);
      return [(widget as Align).toPdfWidget(
        children.isNotEmpty ? children.first : null
      )];
    case Positioned:
      return [(widget as Positioned).toPdfWidget((await visit(element, options)).first)];
    case Expanded:
      return[(widget as Expanded).toPdfWidget((await visit(element, options)).first)];
    case Flexible:
      return [(widget as Flexible).toPdfWidget((await visit(element, options)).first)];
    case Placeholder:
      return [(widget as Placeholder).toPdfWidget()];
    case Text:
      return [(widget as Text).toPdfWidget()];
    case TextField:
      return [(widget as TextField).toPdfWidget(options.textFieldOptions)];
    case Divider:
      return [(widget as Divider).toPdfWidget()];
    case Image:
      return [await (widget as Image).toPdfWidget()];
    case Checkbox:
      return [await (widget as Checkbox).toPdfWidget(options.checkboxOptions)];
    case TextButton:
    case ElevatedButton:
    case OutlinedButton:
    case FilledButton:
      return [(widget as ButtonStyleButton).toPdfWidget((await visit(element, options)).first)];
    case Column:
      return [(widget as Column).toPdfWidget(await visit(element, options))];
    case Row:
      return [(widget as Row).toPdfWidget(await visit(element, options))];
    case Stack:
      return [(widget as Stack).toPdfWidget(await visit(element, options))];
    case ListView:
        return [(widget as ListView).toPdfWidget(await visit(element, options))];
    case GridView:
      return [(widget as GridView).toPdfWidget(await visit(element, options))];
    case Wrap:
      return [(widget as Wrap).toPdfWidget(await visit(element, options))];
    case Table:
      return [await (widget as Table).toPdfWidget(await visit(element, options))];
    default:
      debugPrint('Uncaught: ${widget.runtimeType}');
      return await visit(element, options);
  }
}
