import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class QuestionnaireExample extends StatefulWidget {
  const QuestionnaireExample({super.key});

  @override
  State<QuestionnaireExample> createState() => _QuestionnaireExampleState();
}

class _QuestionnaireExampleState extends State<QuestionnaireExample> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();

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
              Text('Questionnaire',
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
      const SizedBox(height: 16),
      Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image:  DecorationImage(
                image: NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
          ),
          const SizedBox(width: 16),
          buildNameFields(MediaQuery.of(context).size.width),
        ],
      ),
    ],
  );

  Widget buildNameFields(double screenWidth) {
    List<Widget> children = [
      SizedBox(
        width: 200,
        height: 50,
        child: TextField(
          controller: firstNameController,
          decoration: const InputDecoration(
            labelText: 'First name',
            border: OutlineInputBorder()
          ),
        ),
      ),
      const SizedBox(width: 10, height: 10),
      SizedBox(
        width: 200,
        height: 50,
        child: TextField(
          controller: lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last name',
            border: OutlineInputBorder()
          ),
        ),
      ),
    ];

    if (screenWidth > 550) {
      return Row(children: children);
    } else {
      return Column(children: children);
    }
  }
}