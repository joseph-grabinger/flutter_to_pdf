import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'options/export_options.dart';
import 'widgets/container.dart';
import 'widgets/center.dart';
import 'widgets/sized_box.dart';
import 'widgets/align.dart';
import 'widgets/padding.dart';
import 'widgets/positioned.dart';
import 'widgets/expanded.dart';
import 'widgets/flexible.dart';
import 'widgets/text.dart';
import 'widgets/text_field.dart';
import 'widgets/divider.dart';
import 'widgets/image.dart';
import 'widgets/checkbox.dart';
import 'widgets/column.dart';
import 'widgets/row.dart';
import 'widgets/stack.dart';
import 'widgets/list_view.dart';
import 'widgets/grid_view.dart';
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

/// Traverses the widget tree of the provided [context]
/// and returns the corresponding PDF widget tree.
Future<pw.Widget?> traverseWidgetTree(BuildContext context, ExportOptions options) async {
  Element? element;

  context.visitChildElements((Element e) async {
    print('Initial: $e');
    element = e;
  });

  pw.Widget? pdfWidget = (await matchWidget(element!, options)).first;

  print('initial PDF Widget: $pdfWidget');

  return pdfWidget;
}

/// Recursive helper to visit all child elements of the provided [element].
Future<List<pw.Widget>> visit(Element element, ExportOptions options) async {
  List<Element> elements = [];

  element.visitChildElements((Element element) async {
    print('Element ${element.depth}: ${element.widget}');
    elements.add(element);
  });

  List<pw.Widget> children = [];

  for (Element e in elements) {
    children.addAll(await matchWidget(e, options));
  }

  print('returned: $children');

  return children;
}

/// Matches the widget provided as [element]
/// and appends the corresponding [pw.Widget] to [children].
Future<List<pw.Widget>> matchWidget(Element element, ExportOptions options) async {
  final Widget widget = element.widget;

  switch (widget.runtimeType) {
    case MergeSemantics: //anchor: end of widget tree
      print('Reached Anchor');
      return [];
    case Container:
      final List childWidgets = await visit(element, options);
      return [await (widget as Container).toPdfWidget(
        childWidgets.isNotEmpty ? childWidgets.first : null
      )];
    case Center:
      final List childWidgets = await visit(element, options);
      return [(widget as Center).toPdfWidget(
        childWidgets.isNotEmpty ? childWidgets.first : null
      )];
    case SizedBox:
      final List childWidgets = await visit(element, options);
      return [(widget as SizedBox).toPdfWidget(
        childWidgets.isNotEmpty ? childWidgets.first : null
      )];
    case Padding:
      final List childWidgets = await visit(element, options);
      return [(widget as Padding).toPdfWidget(
        childWidgets.isNotEmpty ? childWidgets.first : null
      )];
    case Align:
      final List childWidgets = await visit(element, options);
      return [(widget as Align).toPdfWidget(
        childWidgets.isNotEmpty ? childWidgets.first : null
      )];
    case Positioned:
      return [(widget as Positioned).toPdfWidget((await visit(element, options)).first)];
    case Expanded:
      return[(widget as Expanded).toPdfWidget((await visit(element, options)).first)];
    case Flexible:
      return [(widget as Flexible).toPdfWidget((await visit(element, options)).first)];
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
    case Table:
      return [await (widget as Table).toPdfWidget(await visit(element, options))];
    default:
      print('Uncaught: ${widget.runtimeType}');
      return await visit(element, options);
  }
}