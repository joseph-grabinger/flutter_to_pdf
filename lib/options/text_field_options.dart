import 'package:flutter/widgets.dart' show Key, TextStyle;


class TextFieldOptions {
  /// The default [TextStyle] to apply to the text field.
  final TextStyle? textStyle;

  /// A map of [Key] to [TextStyle] to apply to the text field.
  final Map<Key, TextStyle>? styleMap;

  /// If false, the text field will be rendered as a static text.
  final bool interactive;

  const TextFieldOptions({
    this.textStyle,
    this.styleMap,
    this.interactive = true,
  });

  const TextFieldOptions.none() : textStyle = null, styleMap = null, interactive = true;

  const TextFieldOptions.uniform({
    this.textStyle, 
    this.interactive = true,
  }) : styleMap = null;

  const TextFieldOptions.individual({
    this.styleMap, 
    this.interactive = true,
  }) : textStyle = null;

  /// Returns the [TextStyle] for the given [key].
  /// If [key] is not found, returns null.
  TextStyle? getTextStyle(Key key) {
    if (styleMap != null && styleMap!.containsKey(key)) {
      return styleMap![key];
    } else {
      return null;
    }
  }
}