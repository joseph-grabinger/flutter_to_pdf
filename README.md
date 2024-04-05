[![codecov](https://codecov.io/gh/joseph-grabinger/flutter_to_pdf/branch/main/graph/badge.svg?token=5WIYFJ6VND)](https://codecov.io/gh/joseph-grabinger/flutter_to_pdf)
[![Pub](https://img.shields.io/pub/v/flutter_to_pdf.svg)](https://pub.dev/packages/flutter_to_pdf)


The [FlutterToPDF](https://pub.dev/packages/flutter_to_pdf) package lets you export any Flutter widget to PDF Documents and is written natively in Dart.

## Installing
### Depend on it 

Run this command:

```shell
$ flutter pub add flutter_to_pdf
```

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```yaml
dependencies:
    flutter_to_pdf: ^0.2.0
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

### Import it
Now in your Dart code, you can use:

```dart
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
```

## Features

- export to PDF Document
- export to PDF Page
- export to PDF Widget
- export with options
    - Page format options
    - Text field options
    - Checkbox options


## Usage

Create an instance of the `ExportDelegate`, wrap your widget with a `ExportFrame` widget and provide a `frameId`, as well as the `exportDelegate`.

When you want to export the widget call the desired export function (either `exportToPdfDocument`, `exportToPdfPage` or `exportToPdfWidget`) and pass in the `frameId`.

```dart
// create instance of ExportDelegate
final ExportDelegate exportDelegate = ExportDelegate();

ExportFrame(
  frameId: 'someFrameId',
  child: SomeWidget(), // the widget you want to export
)

// export the frame to a PDF Document
final pdf = await exportDelegate.exportToPdfDocument('someFrameId');

// export the frame to a PDF Page
final page = await exportDelegate.exportToPdfPage('someFrameId');

// export the frame to a PDF Widget
final widget = await exportDelegate.exportToPdfWidget('someFrameId');
```

**Note:** If you wish to use types on the variables `pdf`, `page` and `widget`, you can use the `Document`, `Page` and `Widget` classes provided by [PDF-package](https://pub.dev/packages/pdf).

### Custom TTF Fonts

If the widget you want to export contains any custom TTF fonts, you **must** provide the used `ttfFonts` to the `ExportDelegate`.

```dart
final ExportDelegate exportDelegate = ExportDelegate(
  ttfFonts: {
    'SomeFontFamily': 'assets/fonts/someFont.ttf',
  },
);
```

### TextFields and Checkboxes

If the widget you want to export contains any `TextField`, `TextFormField` or `Checkbox`, a **unique** `Key` must be provided to each `TextField`, `TextFormField` and `Checkbox`.

```dart
TextField(
  key: Key('someUniqueTextFieldKey'),
  controller: TextEditingController(),
  ...
)

Checkbox(
  key: Key('someUniqueCheckboxKey'),
  value: false,
  ...
)
```
## Export Options

The `ExportDelegate`´s constructor has a named optional parameter `options` which can be used to customize the export process.

```dart
final ExportOptions options = ExportOptions(
  pageFormatOptions: PageFormatOptions.a3(),
  textFieldOptions: TextFieldOptions.uniform(
    interactive: false,
  ),
  checkboxOptions: CheckboxOptions.uniform(
    interactive: false,
  ),
);

final ExportDelegate exportDelegate = ExportDelegate(options: options);
```

The  `ExportDelegate`´s `options` can also be overriden using the named optional parameter `overrideOptions` in the export function.
```dart
final ExportOptions options = ExportOptions(
  pageFormatOptions: PageFormatOptions.a3(),
  textFieldOptions: TextFieldOptions.uniform(
    interactive: false,
  ),
  checkboxOptions: CheckboxOptions.uniform(
    interactive: false,
  ),
);

final ExportDelegate exportDelegate = ExportDelegate(options: options);

final ExportOptions overrideOptions = ExportOptions(
  pageFormatOptions: PageFormatOptions.a4(),
  textFieldOptions: TextFieldOptions.uniform(
    interactive: true,
  ),
  checkboxOptions: CheckboxOptions.uniform(
    interactive: true,
  ),
);

// export the frame to a PDF Document, using the override options
final pdf = await exportDelegate.exportToPdfDocument('someFrameId', overrideOptions: overrideOptions);

// export the frame to a PDF Page, using the override options
final page = await exportDelegate.exportToPdfPage('someFrameId', overrideOptions: overrideOptions);

// export the frame to a PDF Widget, using the override options
final widget = await exportDelegate.exportToPdfWidget('someFrameId', overrideOptions: overrideOptions);
```

### Page Format Options
The `PageFormatOptions` class can be used to customize the page format of the exported PDF Document.

All constructors have an optional parameter `clip` which can be used to define if the content of the page should be clipped to the page format. The default value is `true`.

For the `PageFormatOptions` class there are several predefined constructors available:

-   `PageFormatOptions.a3` - A3 page format
-   `PageFormatOptions.a4` - A4 page format
-   `PageFormatOptions.a5` - A5 page format
-   `PageFormatOptions.a6` - A6 page format
-   `PageFormatOptions.letter` - Letter page format
-   `PageFormatOptions.legal` - Legal page format
-   `PageFormatOptions.roll57` - Roll57 page format
-   `PageFormatOptions.roll80` - Roll80 page format
-   `PageFormatOptions.custom` - Custom page format
    > The custom page format can be used to define a custom page format. <br> It therefore requires at least the `width` parameter, and has the following optional parameters: `height`, `marginTop`, `marginBottom`, `marginLeft`, `marginRight` and `marginAll`.

### Text Field Options
The `TextFieldOptions` class can be used to customize the text fields of the exported PDF Document.

All constructors have an optional parameter `interactive` which can be used to define if the text fields should be interactive. The default value is `true`.
If `interactive` is set to `false`, the text fields will be rendered as Text.

For the `TextFieldOptions` class there are several predefined constructors available:

-   `TextFieldOptions.uniform` - Uniform text field options
    > The uniform text field options can be used to define a uniform `TextStyle` for **all** text fields. <br> It therefore has an optional parameter `textstyle` which can be used to define a custom `TextStyle` for **all** text fields.

-  `TextFieldOptions.individual` - Individual text field options
    > The individual text field options can be used to define an individual `TextStyle` for **each** text field. <br> It has an optional parameter `styleMap` which maps the textfield´s `Key` to a `TextStyle`.  <br> **Note:** The TextField therefore requires a `Key` to be able to map the `TextStyle` to the text field.

-  `TextFieldOptions.none` - No text field options
    > The text fields will be interactive and will be styled as found in the widget tree.

### Checkbox Options
The `CheckboxOptions` class can be used to customize the checkboxes of the exported PDF Document.

All constructors have an optional parameter `interactive` which can be used to define if the checkboxes should be interactive. The default value is `true`.
If `interactive` is set to `false`, the checkboxes will be rendered as a Container and will **not** be clickable.

For the `CheckboxOptions` class there are several predefined constructors available:

-   `CheckboxOptions.uniform` - Uniform checkbox options
    > The uniform checkbox options can be used to define a uniform `BoxDecoration` for **all** checkboxes. <br> It therefore has an optional parameter `boxDecoration` which can be used to define a custom `BoxDecoration` for **all** checkboxes.

-  `CheckboxOptions.individual` - Individual checkbox options
    > The individual checkbox options can be used to define an individual `BoxDecoration` for **each** checkbox. <br> It has an optional parameter `decorationMap` which maps the checkbox´s `Key` to a `BoxDecoration`.  <br> **Note:** The Checkbox therefore requires a `Key` to be able to map the `BoxDecoration` to the checkbox.

-  `CheckboxOptions.none` - No checkbox options
    > The checkboxes will be interactive and will be styled as found in the widget tree.
