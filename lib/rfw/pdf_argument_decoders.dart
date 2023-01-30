// only import matrix4 from 'flutter/widgets.dart';
import 'package:flutter/widgets.dart' show Matrix4;
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

class PdfArgumentDecoders {
  const PdfArgumentDecoders._();

  /// This is a workaround for https://github.com/dart-lang/sdk/issues/47021
  static const PdfArgumentDecoders __ = PdfArgumentDecoders._(); // ignore: unused_field

  static T? v<T extends Object>(Object? obj) {
    return obj is T ? obj : null;
  }

  static PdfColor? color(Object? obj) {
    if (obj is! int) return null;
    return PdfColor.fromInt(obj);
  }

  static Matrix4? matrix(Object? obj) {
    if (obj is! List) return null;
    if (obj.length != 16) return null;
    return Matrix4(
      v<double>(obj[0]) ?? 0.0,
      v<double>(obj[1]) ?? 0.0,
      v<double>(obj[2]) ?? 0.0,
      v<double>(obj[3]) ?? 0.0,
      v<double>(obj[4]) ?? 0.0,
      v<double>(obj[5]) ?? 0.0,
      v<double>(obj[6]) ?? 0.0,
      v<double>(obj[7]) ?? 0.0,
      v<double>(obj[8]) ?? 0.0,
      v<double>(obj[9]) ?? 0.0,
      v<double>(obj[10]) ?? 0.0,
      v<double>(obj[11]) ?? 0.0,
      v<double>(obj[12]) ?? 0.0,
      v<double>(obj[13]) ?? 0.0,
      v<double>(obj[14]) ?? 0.0,
      v<double>(obj[15]) ?? 0.0,
    );
  }

  static Alignment? alignment(Object? obj) {
    if (obj is! Map) return null;

    final double? x = v<double>(obj['x']);
    final double? y = v<double>(obj['y']);
    if (x == null) {
      return null;
    }
    if (y == null) {
      return null;
    }
    return Alignment(x, y);
  }

  static EdgeInsets? edgeInsets(Object? obj) {
    if (obj is! List) return null;
    final double? a = v<double>(obj[0]);
    if (a == null) {
      return null;
    }
    final double? b = v<double>(obj[1]);
    final double? c = v<double>(obj[2]);
    final double? d = v<double>(obj[3]);
    return EdgeInsets.fromLTRB(
      a,
      b ?? a,
      c ?? a,
      d ?? (b ?? a),
    );
  }

  static BoxDecoration? decoration(Object? obj) {
    if (obj is! Map) return null;
    final String? type = v<String>(obj['type']);
    switch (type) {
      case null:
        return null;
      case 'box':
        return BoxDecoration(
          color: color(obj['color']),
          //image: decorationImage(source, [...key, 'image']),
          border: border(obj['border']),
          borderRadius: borderRadius(obj['borderRadius']),
          boxShadow: list<BoxShadow>(obj['boxShadow'], boxShadow),
          gradient: gradient(obj['gradient']),
          shape: enumValue<BoxShape>(BoxShape.values, obj['shape']) ?? BoxShape.rectangle,
        );
      default:
        return null;
    }
  }

  static TextStyle? textStyle(Object? obj) {
    if (obj is! Map) return null;
    return TextStyle(
      color: color(obj['color']),
      fontSize: v<double>(obj['fontSize']),
      fontWeight: enumValue<FontWeight>(FontWeight.values, obj['fontWeight']),
      fontStyle: enumValue<FontStyle>(FontStyle.values, obj['fontStyle']),
      letterSpacing: v<double>(['letterSpacing']),
      wordSpacing: v<double>(['wordSpacing']),
      height: v<double>(['height']),
      decoration: textDecoration(obj['decoration']),
      decorationColor: color(obj['decorationColor']),
      decorationStyle: enumValue<TextDecorationStyle>(TextDecorationStyle.values, obj['decorationStyle']),
      decorationThickness: v<double>(obj['decorationThickness']),
    );
  }

  static TextDecoration textDecoration(Object? obj) {
    final List<TextDecoration>? decorations = list<TextDecoration>(obj, textDecoration);
    if (decorations != null) {
      return TextDecoration.combine(decorations);
    }
    switch (v<String>(obj)) {
      case 'lineThrough':
        return TextDecoration.lineThrough;
      case 'overline':
        return TextDecoration.overline;
      case 'underline':
        return TextDecoration.underline;
      default:
        return TextDecoration.none;
    }
  }

  static BoxShadow boxShadow(Object? obj) {
    if (obj is! Map) return const BoxShadow();
    return BoxShadow(
      color: color(obj['color']) ?? const PdfColor.fromInt(0xFF000000),
      offset: offset(obj['offset']) ?? PdfPoint.zero,
      blurRadius: v<double>(obj['blurRadius']) ?? 0.0,
      spreadRadius: v<double>(obj['spreadRadius']) ?? 0.0,
    );
  }

  static PdfPoint? offset(Object? obj) {
    if (obj is! Map) return null;
    final double? x = v<double>(obj['x']);
    if (x == null) {
      return null;
    }
    final double? y = v<double>(obj['y']);
    if (y == null) {
      return null;
    }
    return PdfPoint(x, y);
  }

  static List<T>? list<T>(Object? obj, T Function(Object?) decoder) {
    if (obj is! List) return null;
    final int count = obj.length;
    if (count == 0) {
      return null;
    }
    return List<T>.generate(count, (int index) {
      return decoder(obj[index]);
    });
  }

  static Gradient? gradient(Object? obj) {
    if (obj is! Map) return null;
    final String? type = v<String>(obj['type']);
    switch (type) {
      case null:
        return null;
      case 'linear':
        return LinearGradient(
          begin: alignment(obj['begin']) ?? Alignment.centerLeft,
          end: alignment(obj['end']) ?? Alignment.centerRight,
          colors: list<PdfColor>(obj['colors'], colorOrBlack) ?? const <PdfColor>[PdfColor.fromInt(0xFF000000), PdfColor.fromInt(0xFFFFFFFF)],
          stops: list<double>(obj['stops'], doubleOrZero),
          tileMode: enumValue<TileMode>(TileMode.values, obj['tileMode']) ?? TileMode.clamp,
          // transform: GradientTransformMatrix(matrix(source, [...key, 'transform'])), // blocked by https://github.com/flutter/flutter/issues/87208
        );
      case 'radial':
        return RadialGradient(
          center: alignment(obj['center']) ?? Alignment.center,
          radius: v<double>(obj['radius']) ?? 0.5,
          colors: list<PdfColor>(obj['colors'], colorOrBlack) ?? const <PdfColor>[PdfColor.fromInt(0xFF000000), PdfColor.fromInt(0xFFFFFFFF)],
          stops: list<double>(obj['stops'], doubleOrZero),
          tileMode: enumValue<TileMode>(TileMode.values, obj['tileMode']) ?? TileMode.clamp,
          focal: alignment(obj['focal']),
          focalRadius: v<double>(obj['focalRadius']) ?? 0.0,
          // transform: GradientTransformMatrix(matrix(source, [...key, 'transform'])), // blocked by https://github.com/flutter/flutter/issues/87208
        );
      default:
        return null;
    }
  }

  static PdfColor colorOrBlack(Object? obj) {
    return color(obj) ?? const PdfColor.fromInt(0xFF000000);
  }

  static double doubleOrZero(Object? obj) {
    return v<double>(obj) ?? 0.0;
  }

  static BoxConstraints? boxConstraints(Object? obj) {
    if (obj is! Map) return null;
    return BoxConstraints(
      minWidth: v<double>(obj['minWidth']) ?? 0.0,
      maxWidth: v<double>(obj['maxWidth']) ?? double.infinity,
      minHeight: v<double>(obj['minHeight']) ?? 0.0,
      maxHeight: v<double>(obj['maxHeight']) ?? double.infinity,
    );
  }

  static BorderRadius? borderRadius(Object? obj) {
    if (obj is! List) return null;
    final Radius? a = radius(obj[0]);
    if (a == null) {
      return null;
    }
    final Radius? b = radius(obj[1]);
    final Radius? c = radius(obj[2]);
    final Radius? d = radius(obj[3]);
    return BorderRadius.only(
      topLeft: a,
      topRight: b ?? a,
      bottomLeft: c ?? a,
      bottomRight: d ?? b ?? a,
    );
  }

  static Radius? radius(Object? obj) {
    if (obj is! Map) return null;

    final double? x = v<double>(obj['x']);
    if (x == null) {
      return null;
    }
    final double y = v<double>(obj['y']) ?? x;
    return Radius.elliptical(x, y);
  }

  static T? enumValue<T>(List<T> values, Object? obj) {
    final String? value = v<String>(obj);
    if (value == null) {
      return null;
    }
    for (int index = 0; index < values.length; index += 1) {
      if (value == values[index].toString().split('.').last) {
        return values[index];
      }
    }
    return null;
  }

  static BoxBorder? border(Object? obj) {
    if (obj is! List) return null;
    final BorderSide? a = borderSide(obj[0]);
    if (a == null) {
      return null;
    }
    final BorderSide? b = borderSide(obj[1]);
    final BorderSide? c = borderSide(obj[2]);
    final BorderSide? d = borderSide(obj[3]);
    return Border(
      left: a,
      top: b ?? a,
      right: c ?? a,
      bottom: d ?? b ?? a,
    );
  }

  static BorderSide? borderSide(Object? obj) {
    if (obj is! Map) return null;

    return BorderSide(
      color: color(obj['color']) ?? const PdfColor.fromInt(0xFF000000),
      width: v<double>(obj['width']) ?? 1.0,
      style: enumValue<BorderStyle>([
          BorderStyle.none,
          BorderStyle.solid,
          BorderStyle.dashed,
          BorderStyle.dotted,
        ],
        obj['style']
      ) ?? BorderStyle.solid,
    );
  }
}