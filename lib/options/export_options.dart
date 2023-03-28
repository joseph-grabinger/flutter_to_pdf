import 'page_format_options.dart';
import 'text_field_options.dart';
import 'checkbox_options.dart';

/// Configuration options on how certain widgets are exported.
class ExportOptions {
  final TextFieldOptions textFieldOptions;
  final CheckboxOptions checkboxOptions;
  final PageFormatOptions pageFormatOptions;

  const ExportOptions({
    this.textFieldOptions = const TextFieldOptions.none(),
    this.checkboxOptions = const CheckboxOptions.none(),
    this.pageFormatOptions = const PageFormatOptions(),
  });
}
