import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pdf/widgets.dart' as pw;

import 'capture_wrapper.dart';
import 'export_delegate.dart';
import 'utils.dart';
import 'widgets/container.dart';
import 'widgets/center.dart';
import 'widgets/sized_box.dart';
import 'widgets/fitted_box.dart';
import 'widgets/limited_box.dart';
import 'widgets/constrained_box.dart';
import 'widgets/clip.dart';
import 'widgets/transform.dart';
import 'widgets/opacity.dart';
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

/// The delegate handling the low-level export of the widget tree.
class ExportInstance {
  /// The delegate that is used to export the widget.
  final ExportDelegate delegate;

  /// The function to export a [Widget] to a [pw.Widget].
  final Future<pw.Widget> Function(Widget widget) exportFunc;

  const ExportInstance(this.delegate, this.exportFunc);

  /// Recursive helper to visit all child elements of the provided [element].
  Future<List<pw.Widget>> _visit(Element element, BuildContext? context) async {
    List<Element> elements = [];

    element.visitChildElements((Element e) async => elements.add(e));

    List<pw.Widget> children = [];
    for (Element e in elements) {
      children.addAll(await matchWidget(e, context));
    }

    return children;
  }

  /// Matches the widget provided as [element]
  /// and returns the corresponding [pw.Widget].
  /// The [context] is only null when called from [exportFunc].
  Future<List<pw.Widget>> matchWidget(
      Element element, BuildContext? context) async {
    final Widget widget = element.widget;

    switch (widget.runtimeType) {
      case const (MergeSemantics): //anchor: end of widget tree
        return [];
      case const (Container):
        final List children = await _visit(element, context);
        return [
          await (widget as Container)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (Center):
        final List children = await _visit(element, context);
        return [
          (widget as Center)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (SizedBox):
        final List children = await _visit(element, context);
        return [
          (widget as SizedBox)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (FittedBox):
        final List children = await _visit(element, context);
        return [
          (widget as FittedBox)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (LimitedBox):
        final List children = await _visit(element, context);
        return [
          (widget as LimitedBox)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (ConstrainedBox):
        final List children = await _visit(element, context);
        return [
          (widget as ConstrainedBox)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (ClipRect):
        final List children = await _visit(element, context);
        return [
          (widget as ClipRect)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (ClipRRect):
        final List children = await _visit(element, context);
        return [
          (widget as ClipRRect)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (ClipOval):
        final List children = await _visit(element, context);
        return [
          (widget as ClipOval)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (Transform):
        final List children = await _visit(element, context);
        return [
          (widget as Transform)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (Opacity):
        final List children = await _visit(element, context);
        return [
          (widget as Opacity)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (Padding):
        final List children = await _visit(element, context);
        return [
          (widget as Padding)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (Align):
        final List children = await _visit(element, context);
        return [
          (widget as Align)
              .toPdfWidget(children.isNotEmpty ? children.first : null)
        ];
      case const (Positioned):
        final List children = await _visit(element, context);
        return [
          (widget as Positioned).toPdfWidget(
            children.isNotEmpty ? children.first : pw.Container(),
          )
        ];
      case const (Expanded):
        final List children = await _visit(element, context);
        return [
          (widget as Expanded).toPdfWidget(
            children.isNotEmpty ? children.first : pw.Container(),
          )
        ];
      case const (Flexible):
        final List children = await _visit(element, context);
        return [
          (widget as Flexible).toPdfWidget(
            children.isNotEmpty ? children.first : pw.Container(),
          )
        ];
      case const (Placeholder):
        return [(widget as Placeholder).toPdfWidget()];
      case const (Text):
        return [await (widget as Text).toPdfWidget(this)];
      case const (TextField):
        TextField? contextWidget;
        if (context != null) {
          TextFormField? textFormField;
          if (widget.key == null) {
            textFormField =
                element.findAncestorWidgetOfExactType<TextFormField>();
            if (textFormField?.key == null) {
              throw Exception('TextField must have a key to be exported');
            }
          }

          if (textFormField == null) {
            Element? contextElement =
                findElement(context, (TextField e) => e.key == widget.key);
            contextWidget = contextElement!.widget as TextField;
          } else {
            Element? contextElement = findElement(
                context, (TextFormField e) => e.key == textFormField!.key);
            contextElement =
                findFirstDescendantElement<TextField>(contextElement!);
            contextWidget = contextElement!.widget as TextField;
          }
        }
        return [await (widget as TextField).toPdfWidget(this, contextWidget)];
      case const (Divider):
        return [(widget as Divider).toPdfWidget()];
      case const (Image):
        return [await (widget as Image).toPdfWidget()];
      case const (Checkbox):
        Checkbox? contextWidget;
        if (context != null) {
          if (widget.key == null) {
            throw Exception('Checkbox must have a key to be exported');
          }
          Element? contextElement =
              findElement(context, (Checkbox e) => e.key == widget.key);
          contextWidget = contextElement!.widget as Checkbox;
        }
        return [
          await (widget as Checkbox)
              .toPdfWidget(delegate.options.checkboxOptions, contextWidget)
        ];
      case const (TextButton):
      case const (ElevatedButton):
      case const (OutlinedButton):
      case const (FilledButton):
        return [
          (widget as ButtonStyleButton)
              .toPdfWidget((await _visit(element, context)).first)
        ];
      case const (Column):
        return [(widget as Column).toPdfWidget(await _visit(element, context))];
      case const (Row):
        return [(widget as Row).toPdfWidget(await _visit(element, context))];
      case const (Stack):
        return [(widget as Stack).toPdfWidget(await _visit(element, context))];
      case const (ListView):
        Element? contextElement = findElement(context!, (e) => e is SliverList);
        return [
          (widget as ListView)
              .toPdfWidget(await _visit(contextElement!, context))
        ];
      case const (GridView):
        final constraints = BoxConstraints(
          maxWidth: element.renderObject!.paintBounds.right,
          maxHeight: element.renderObject!.paintBounds.bottom,
        );
        return [
          (widget as GridView)
              .toPdfWidget(await _visit(element, context), constraints)
        ];
      case const (Wrap):
        return [(widget as Wrap).toPdfWidget(await _visit(element, context))];
      case const (Table):
        return [
          await (widget as Table).toPdfWidget(await _visit(element, context))
        ];
      case const (CaptureWrapper):
        if (widget.key == null) {
          throw Exception('Capture must have a key to be exported');
        }
        Element? contextElement =
            findElement(context!, (CaptureWrapper e) => e.key == widget.key);

        assert(contextElement != null);
        RenderRepaintBoundary? boundary;
        RenderObject? renderObject = contextElement!.renderObject;

        if (renderObject is RenderRepaintBoundary) {
          boundary = renderObject;
        } else {
          renderObject?.visitChildren((child) {
            if (child is RenderRepaintBoundary) {
              boundary = child;
            }
          });
        }

        assert(boundary != null);
        final ui.Image uiImage = await boundary!.toImage(pixelRatio: 2.0);

        final pngBytes =
            await uiImage.toByteData(format: ui.ImageByteFormat.png);
        debugPrint(
            'Captured image for ${widget.key}, with size: ${uiImage.width}x${uiImage.height}');
        return [
          await Image.memory(
            pngBytes!.buffer.asUint8List(),
            width: uiImage.width / 2.0,
            height: uiImage.height / 2.0,
          ).toPdfWidget(),
        ];

      default:
        return await _visit(element, context);
    }
  }
}
