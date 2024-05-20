import 'package:flutter/widgets.dart'
    show
        Alignment,
        Color,
        Gradient,
        LinearGradient,
        RadialGradient,
        TileMode,
        debugPrint;

import 'package:pdf/pdf.dart' show PdfColor;
import 'package:pdf/widgets.dart' as pw
    show Gradient, LinearGradient, RadialGradient, TileMode;

import 'alignment.dart';
import 'color.dart';

extension GradientConverter on Gradient {
  pw.Gradient toPdfGradient() {
    debugPrint('GradientConverter: $this');
    switch (runtimeType) {
      case const (LinearGradient):
        return (this as LinearGradient).toPdfLinearGradient();
      case const (RadialGradient):
        return (this as RadialGradient).toPdfRadialGradient();
      // not supported by pdf package:
      // - SweepGradient
      default:
        throw Exception('Unsupported Gradient: $this');
    }
  }
}

extension LinearGradientConverter on LinearGradient {
  pw.LinearGradient toPdfLinearGradient() => pw.LinearGradient(
        colors:
            colors.map<PdfColor>((Color color) => color.toPdfColor()).toList(),
        begin: (begin as Alignment).toPdfAlignment(),
        end: (end as Alignment).toPdfAlignment(),
        stops: stops,
        tileMode: tileMode.toPdfTileMode(),
      );
}

extension RadialGradientConverter on RadialGradient {
  pw.RadialGradient toPdfRadialGradient() => pw.RadialGradient(
        colors:
            colors.map<PdfColor>((Color color) => color.toPdfColor()).toList(),
        center: (center as Alignment).toPdfAlignment(),
        radius: radius,
        stops: stops,
        focal: (focal as Alignment).toPdfAlignment(),
        focalRadius: focalRadius,
        tileMode: tileMode.toPdfTileMode(),
      );
}

extension TileModeConverter on TileMode {
  pw.TileMode toPdfTileMode() {
    switch (this) {
      case TileMode.clamp:
        return pw.TileMode.clamp;
      // not supported by pdf package:
      // - TileMode.mirror:
      // - TileMode.repeated:
      default:
        debugPrint('Unsupported TileMode: $this; defaulting to TileMode.clamp');
        return pw.TileMode.clamp;
    }
  }
}
