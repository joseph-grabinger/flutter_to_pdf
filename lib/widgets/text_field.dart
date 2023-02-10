import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:teaplates/teaplates.dart';


class PfTextField extends PfWidget {
  PfTextField({
    required String initialText,
    Key? key,
  }) : super(key: key) {
    _controller.text = initialText;
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        isCollapsed: true,
        border: InputBorder.none,
      ),
    );
  }

  @override
  pw.Widget toPw() {
    return pw.SizedBox(
      width: double.infinity,
      child: pw.Text(
        _controller.text,
      ),
    );
  }
}