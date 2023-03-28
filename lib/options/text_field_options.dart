import 'package:flutter/widgets.dart' show Key, TextStyle;

/// Configuration options on how TextFields are exported.
class TextFieldOptions {
  /// [Key] used wihin the styleMap if it only contains one item.
  static const _standardKey = Key('');

  /// A map of [Key] to [TextStyle] to apply to the text field.
  final Map<Key, TextStyle>? styleMap;

  /// If false, the text field will be rendered as a static text.
  final bool interactive;

  /// If true, the text fields InputDecoration will be ignored.
  final bool ignoreDecoration;

  const TextFieldOptions({
    this.styleMap,
    this.interactive = true,
    this.ignoreDecoration = false,
  });

  const TextFieldOptions.none()
      : styleMap = null,
        interactive = true,
        ignoreDecoration = false;

  TextFieldOptions.uniform({
    final TextStyle textStyle = const TextStyle(),
    this.interactive = true,
    this.ignoreDecoration = false,
  }) : styleMap = {_standardKey: textStyle};

  const TextFieldOptions.individual({
    this.styleMap,
    this.interactive = true,
    this.ignoreDecoration = false,
  });

  /// Returns the [TextStyle] for the given [key].
  /// If [key] is null, the standard key will be used.
  /// If [key] still is not found, null is returned.
  TextStyle? getTextStyle(Key? key) {
    key ??= _standardKey;

    if (styleMap != null && styleMap!.containsKey(key)) {
      return styleMap![key];
    } else {
      return null;
    }
  }
}
