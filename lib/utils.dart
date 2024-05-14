import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// The key used to identify the ExportFrame in the widget tree.
const Key exportFrameKey = Key('FlutterToPDF.exportFrameKey');

/// Extracts the ExportFrame as [Element] from the provided [element].
/// ExportFrame is identified by checking if the widget contains the [exportFrameKey].
Element? extractExportFrame(Element element) {
  if (element.widget.key == exportFrameKey) {
    return element;
  }

  List<Element> children = [];
  element.visitChildren((Element e) {
    children.add(e);
  });

  for (Element child in children) {
    Element? found = extractExportFrame(child);
    if (found != null) {
      return found;
    }
  }
  return null;
}

/// Finds the first [Element] in the provided [context]
/// that matches the provided [compare] function.
Element? findElement<T>(BuildContext context, bool Function(T) compare) {
  Element? element;

  context.visitChildElements((Element e) => element = e);

  return _findByElement(element!, compare);
}

/// Recursive helper function for [findElement].
Element? _findByElement<T>(Element element, bool Function(T) compare) {
  if (element.widget is T && compare(element.widget as T)) {
    return element;
  }

  List<Element> children = [];
  element.visitChildren((Element e) {
    children.add(e);
  });

  for (Element child in children) {
    Element? found = _findByElement(child, compare);
    if (found != null) {
      return found;
    }
  }
  return null;
}

/// Finds the first descendant [Element] of the provided [element] of type [T].
Element? findFirstDescendantElement<T>(Element element) {
  return _findByElement(element, (T _) => true);
}

/// Lays out the provided [widget] in a view of [size] and returns it as [Element].
Element? layoutWidget(Widget widget, Size size, double? pixelRatio) {
  RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

  RenderView renderView = RenderView(
    configuration: ViewConfiguration(
      logicalConstraints: BoxConstraints.tight(size),
      physicalConstraints: BoxConstraints.tight(size * (pixelRatio ?? 1.0)),
      devicePixelRatio: pixelRatio ?? 1.0,
    ),
    view: WidgetsBinding.instance.platformDispatcher.views.first,
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: repaintBoundary,
    ),
  );

  PipelineOwner pipelineOwner = PipelineOwner();
  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  widget = MediaQuery(
    data: MediaQueryData(size: size),
    child: MaterialApp(
      home: Material(
        child: Directionality(
          key: exportFrameKey,
          textDirection: TextDirection.ltr,
          child: widget,
        ),
      ),
    ),
  );

  BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
  RenderObjectToWidgetElement rootElement = RenderObjectToWidgetAdapter(
    container: repaintBoundary,
    child: widget,
  ).attachToRenderTree(buildOwner);
  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  Element? element;

  rootElement.visitChildren((Element child) => element = child);

  Element? exportFrameElement = extractExportFrame(element!);

  return exportFrameElement;
}
