import 'package:flutter/widgets.dart' show Size;

import 'package:pdf/pdf.dart' show PdfPageFormat;


/// Configuration options on how the page is formatted.
class PageFormatOptions {
  final PageFormat pageFormat;
  final double? width;
  final double? height;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double? marginAll;
  final bool clip;

  const PageFormatOptions({
    this.pageFormat = PageFormat.a4,
    this.width,
    this.height,
    this.marginTop = 0.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.marginAll,
    this.clip = false,
  });

  const PageFormatOptions.a3({
    this.clip = false,
  })  : pageFormat = PageFormat.a3,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;

  const PageFormatOptions.a4({
    this.clip = false,
  })  : pageFormat = PageFormat.a4,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;

  const PageFormatOptions.a5({
    this.clip = false,
  })  : pageFormat = PageFormat.a5,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;
  
  const PageFormatOptions.a6({
    this.clip = false,
  })  : pageFormat = PageFormat.a6,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;
  
  const PageFormatOptions.letter({
    this.clip = false,
  })  : pageFormat = PageFormat.letter,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;

  const PageFormatOptions.legal({
    this.clip = false,
  })  : pageFormat = PageFormat.legal,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;

  const PageFormatOptions.roll57({
    this.clip = false,
  })  : pageFormat = PageFormat.roll57,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;

  const PageFormatOptions.roll80({
    this.clip = false,
  })  : pageFormat = PageFormat.roll80,
        width = null,
        height = null,
        marginTop = 0.0,
        marginBottom = 0.0,
        marginLeft = 0.0,
        marginRight = 0.0,
        marginAll = null;

  PageFormatOptions.custom({
    required this.width,
    this.height,
    this.marginTop = 0.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.marginAll,
    this.clip = false,
  })  : assert(width != null && width > 0, 'width is null or less than 0'),
        pageFormat = PageFormat.custom;

  /// Returns the [PdfPageFormat].
  PdfPageFormat getPageFormat() {
    switch (pageFormat) {
      case PageFormat.a3:
        return PdfPageFormat.a3;
      case PageFormat.a4:
        return PdfPageFormat.a4;
      case PageFormat.a5:
        return PdfPageFormat.a5;
      case PageFormat.a6:
        return PdfPageFormat.a6;
      case PageFormat.letter:
        return PdfPageFormat.letter;
      case PageFormat.legal:
        return PdfPageFormat.legal;
      case PageFormat.roll57:
        return PdfPageFormat.roll57;
      case PageFormat.roll80:
        return PdfPageFormat.roll80;
      case PageFormat.custom:
        return PdfPageFormat(width!, height!,
          marginTop: marginTop,
          marginBottom: marginBottom,
          marginLeft: marginLeft,
          marginRight: marginRight,
          marginAll: marginAll,
        );
    }
  }

  /// Returns the available [Size] of the page.
  Size getAvailableSize() {
    final PdfPageFormat pageFormat = getPageFormat();

    return Size(pageFormat.availableWidth, pageFormat.availableHeight);
  }
}

enum PageFormat {
  a3,
  a4,
  a5,
  a6,
  letter,
  legal,
  roll57,
  roll80,
  custom,
}
