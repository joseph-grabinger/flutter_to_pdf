import 'package:flutter/widgets.dart' show Key, BoxDecoration;


/// Configuration options on how Checkbxes are exported.
class CheckboxOptions {
  /// [Key] used wihin the decorationMap if it only contains one item.
  static const _standardKey = Key('');

  /// A map of [Key] to [BoxDecoration] to apply to the checkbox.
  final Map<Key, BoxDecoration>? decorationMap;

  /// If false, the checkbox will be rendered as a static (non-interactive) box.
  final bool interactive;

  const CheckboxOptions({
    this.decorationMap,
    this.interactive = true,
  });

  const CheckboxOptions.none() : decorationMap = null, interactive = true;

  CheckboxOptions.uniform({
    final BoxDecoration? boxDecoration,
    this.interactive = true,
  }) : decorationMap = boxDecoration != null 
        ? {_standardKey: boxDecoration} 
        : null;

  const CheckboxOptions.individual({
    this.decorationMap,
    this.interactive = true,
  });

  /// Returns the [BoxDecoration] for the given [key].
  /// If [key] is null, the standard key will be used.
  /// If [key] still is not found, null is returned.
  BoxDecoration? getBoxDecoration(Key? key) {
    key ??= _standardKey;

    if (decorationMap != null && decorationMap!.containsKey(key)) {
      return decorationMap![key];
    } else {
      print('getBoxDecoration retruned null');
      return null;
    }
  }
}