<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[![codecov](https://codecov.io/gh/dunef-com/teaplates/branch/main/graph/badge.svg?token=5WIYFJ6VND)](https://codecov.io/gh/dunef-com/teaplates)

The [FlutterToPDF](https://dunef.io/de) package lets you export any Flutter view to PDF Documents and is written natively in Dart.

## Installing
### Depend on it 

Run this command:

```shell
$ flutter pub add flutter_to_pdf
```

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```yaml
dependencies:
    flutter_to_pdf: ^0.0.1
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

### Import it
Now in your Dart code, you can use:

```dart
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
```

## Features

- basic export to PDF by `BuildContext`
- export with options
    - Page format options
    - Text field options
    - Checkbox options


## Usage

Call the `exportToPDF` function with the `BuildContext` of the view you want to export to PDF. The function will return a `Document` object which can be used to save the PDF Document to a file or to display it in a PDF Viewer.

```dart
Builder(
  builder: (BuildContext context) => Column(
    children: [
        // any Flutter Widgets can be used here
    ],
  );
)

// export the view to a PDF Document
final Document pdf = await exportToPDF(context);
```

## Export Options

The `exportToPDF` function has an optional parameter `options` which can be used to customize the export process.

```dart
final ExportOptions options = ExportOptions(
  pageFormatOptions: PageFormatOptions.a3,
  textFieldOptions: TextFieldOptions.uniform(
    interactive: false,
  ),
  checkboxOptions: CheckboxOptions.uniform(
    interactive: false,
  ),
);

final Document pdf = await exportToPDF(context, options: options);
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
-   `PageFormatOptions.screenSize` - Screen size page format
    > The screen size page format will use the size of the screen to determine the page format. This is useful if you want to export a view to PDF which is displayed on the screen. <br> It therefore requires the `BuildContext`, and has following optional parameters: `width`, `height`, `marginTop`, `marginBottom`, `marginLeft`, `marginRight` and `marginAll`.
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
    > The text fields will be interactive and will not have any `TextStyle`.

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
    > The checkboxes will be interactive and will not have any `BoxDecoration`.
