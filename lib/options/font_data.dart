import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Data class for loading TTF font data.
class FontData {
  final Map<String, String> ttfFonts;
  AssetBundle assetBundle = rootBundle;

  FontData(this.ttfFonts);

  void setAssetBundleByContext(BuildContext context) {
    assetBundle = DefaultAssetBundle.of(context);
  }
}
