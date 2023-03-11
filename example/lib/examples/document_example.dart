import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class DocumentExample extends StatefulWidget {
  const DocumentExample({super.key});

  @override
  State<DocumentExample> createState() => _DocumentExampleState();
}

class _DocumentExampleState extends State<DocumentExample> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text('Dunef UG (haftungsbeschränkt)'),
                Text('Mock-Document',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Date: ',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(DateFormat('MM.dd.yyyy').format(DateTime.now())),
              ],
            ),
            SizedBox(
              height: 50,
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 100,
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey)
            ),
          ),
        ),
        Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('http://i.pravatar.cc/300'),
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            SizedBox(
              width: 200,
              height: 50,
              child: TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  label: Text('Name'), border: OutlineInputBorder(),
                ),
              ),
            ),
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              value: checked,
              onChanged: (newValue) {
                setState(() {
                  checked = newValue ?? false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
