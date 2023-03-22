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
  TextEditingController countryOfBirthController = TextEditingController();

  bool acceptLorem = false;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
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
                  image: NetworkImage('http://i.pravatar.cc/100'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            buildNameFields(MediaQuery.of(context).size.width),
          ],
        ),
        const SizedBox(height: 16),
        buildBirthFields(MediaQuery.of(context).size.width),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(),
        ),
        const Text('Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',),
        const SizedBox(height: 8),
        Row(
          children: [
            Checkbox(
              value: acceptLorem, 
              onChanged: (newValue) => setState(() {
                acceptLorem = newValue ?? false;
              }),
            ),
            const SizedBox(width: 8),
            const Text('I hereby accept the terms of the Lorem Ipsum.'),
          ],
        ),
      ],
    ),
  );

  Widget buildNameFields(double screenWidth) {
    List<Widget> children = [
      SizedBox(
        width: 180,
        height: 50,
        child: TextField(
          key: const Key('firstName'),
          controller: firstNameController,
          decoration: const InputDecoration(
            labelText: 'First name',
            border: OutlineInputBorder()
          ),
        ),
      ),
      const SizedBox(width: 10, height: 10),
      SizedBox(
        width: 180,
        height: 50,
        child: TextField(
          key: const Key('lastName'),
          controller: lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last name',
            border: OutlineInputBorder()
          ),
        ),
      ),
    ];

    if (screenWidth > 480) {
      return Row(children: children);
    } else {
      return Column(children: children);
    }
  }

  Widget buildBirthFields(double screenWidth) {
    List<Widget> children = [
      SizedBox(
        width: 100,
        height: 50,
        child: TextField(
          key: const Key('dateOfBirth'),
          controller: dateOfBirthController,
          decoration: const InputDecoration(
            labelText: 'DateOfBirth',
            border: OutlineInputBorder()
          ),
        ),
      ),
      const SizedBox(width: 10, height: 10),
      SizedBox(
        width: 180,
        height: 50,
        child: TextField(
          key: const Key('placeOfBrith'),
          controller: placeOfBirthController,
          decoration: const InputDecoration(
            labelText: 'Place of birth',
            border: OutlineInputBorder()
          ),
        ),
      ),
      const SizedBox(width: 10, height: 10),
      SizedBox(
        width: 180,
        height: 50,
        child: TextField(
          key: const Key('countryOfBirth'),
          controller: countryOfBirthController,
          decoration: const InputDecoration(
            labelText: 'Country of birth',
            border: OutlineInputBorder()
          ),
        ),
      ),
    ];

    if (screenWidth > 480) {
      return Row(children: children);
    } else {
      return Column(children: children);
    }
  }
}