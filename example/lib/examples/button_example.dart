import 'package:flutter/material.dart';


final Widget buttonExample = Column(
  children: [
    Padding(padding: const EdgeInsets.all(5.0),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        child: const Text('Text Button'),
      ),
    ),
    Padding(padding: const EdgeInsets.all(5.0),
      child: FilledButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        child: const Text('Filled Button'),
      ),
    ),
  ],
);
