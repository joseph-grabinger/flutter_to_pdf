import 'package:flutter/widgets.dart' show BoxShape;

import 'package:pdf/widgets.dart' as pw show BoxShape;


extension BoxShapeConverter on BoxShape {
  pw.BoxShape toPdfBoxShape() {
    switch (this) {
      case BoxShape.circle:
        return pw.BoxShape.circle;
      case BoxShape.rectangle:
        return pw.BoxShape.rectangle;
    }
  }
}