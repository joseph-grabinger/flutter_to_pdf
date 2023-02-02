import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/widgets.dart';

enum PfTileMode {
  /// Edge is clamped to the final color.
  clamp,

  /// Edge is repeated from first color to last.
  // repeated,

  /// Edge is mirrored from last color to first.
  // mirror,
}

extension PfTileModeExt on PfTileMode {
  TileMode toFl() {
    switch (this) {
      case PfTileMode.clamp:
        return TileMode.clamp;
      // case TileMode.repeated:
      //   return TileMode.repeated;
      // case TileMode.mirror:
      //   return TileMode.mirror;
    }
  }
  
  pw.TileMode toPw() {
    switch (this) {
      case PfTileMode.clamp:
        return pw.TileMode.clamp;
      // case TileMode.repeated:
      //   return pw.TileMode.repeated;
      // case TileMode.mirror:
      //   return pw.TileMode.mirror;
    }
  }
}