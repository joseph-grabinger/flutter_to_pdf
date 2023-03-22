import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class DocumentExample extends StatefulWidget {
  const DocumentExample({super.key});

  @override
  State<DocumentExample> createState() => _DocumentExampleState();
}

class _DocumentExampleState extends State<DocumentExample> {
  final TextEditingController controller = TextEditingController();

  bool checked = false;
  bool imageHover = false;

  @override
  Widget build(BuildContext context) => Column(
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
            color: MediaQuery.of(context).size.width > 700 
              ? Colors.grey : Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey)
          ),
        ),
      ),
      Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onHover: (value) {
              debugPrint('hover : $value');
              setState(() => imageHover = value);
            },
            onTap: () {},
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: !imageHover ? const DecorationImage(
                  image: NetworkImage('http://i.pravatar.cc/300'),
                ) : null,
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          SizedBox(
            width: 200,
            height: 50,
            child: TextField(
              key: const Key('name'),
              controller: controller,
              decoration: const InputDecoration(
                label: Text('Name'), border: OutlineInputBorder(),
              ),
            ),
          ),
          Checkbox(
            key: const Key('checkbox'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            value: checked,
            onChanged: (newValue) => setState(() {
              checked = newValue ?? false;
            }),
          ),
        ],
      ),
    ],
  );
}
