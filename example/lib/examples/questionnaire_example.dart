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
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Expanded(child: buildNameFields(MediaQuery.of(context).size.width)),
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
                key: const Key('acceptLorem'),
                value: acceptLorem, 
                onChanged: (newValue) => setState(() {
                  acceptLorem = newValue ?? false;
                }),
              ),
              const SizedBox(width: 8),
              const Text('I hereby accept the terms of the Lorem Ipsum.'),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          const Padding(
            padding:  EdgeInsets.only(bottom:8.0),
            child: Text('Please select your availability:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Table(
            children: [
              const TableRow(
                children: [
                  Center(child: Text('Monday', maxLines: 1)),
                  Center(child: Text('Tuesday', maxLines: 1)),
                  Center(child: Text('Wednesday', maxLines: 1)),
                  Center(child: Text('Thursday', maxLines: 1)),
                  Center(child: Text('Friday', maxLines: 1)),
                  Center(child: Text('Saturday', maxLines: 1)),
                  Center(child: Text('Sunday', maxLines: 1)),
                ],
              ),
              TableRow(
                children: [
                  Checkbox(
                    key: const Key('monday'),
                    value: monday,
                    onChanged: (newValue) => setState(() {
                      monday = newValue ?? false;
                    }),
                  ),
                  Checkbox(
                    key: const Key('tuesday'),
                    value: tuesday,
                    onChanged: (newValue) => setState(() {
                      tuesday = newValue ?? false;
                    }),
                  ),
                  Checkbox(
                    key: const Key('wednesday'),
                    value: wednesday,
                    onChanged: (newValue) => setState(() {
                      wednesday = newValue ?? false;
                    }),
                  ),
                  Checkbox(
                    key: const Key('thursday'),
                    value: thursday,
                    onChanged: (newValue) => setState(() {
                      thursday = newValue ?? false;
                    }),
                  ),
                  Checkbox(
                    key: const Key('friday'),
                    value: friday,
                    onChanged: (newValue) => setState(() {
                      friday = newValue ?? false;
                    }),
                  ),
                  Checkbox(
                    key: const Key('saturday'),
                    value: saturday,
                    onChanged: (newValue) => setState(() {
                      saturday = newValue ?? false;
                    }),
                  ),
                  Checkbox(
                    key: const Key('sunday'),
                    value: sunday,
                    onChanged: (newValue) => setState(() {
                      sunday = newValue ?? false;
                    }),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          const Text('Thank you for filling out our questionnaire. We will get back to you as soon as possible.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    ),
  );

  Widget buildNameFields(double screenWidth) {
    List<Widget> children = [
      TextField(
        key: const Key('firstName'),
        controller: firstNameController,
        decoration: const InputDecoration(
          labelText: 'First name',
          border: OutlineInputBorder()
        ),
      ),
      TextField(
        key: const Key('lastName'),
        controller: lastNameController,
        decoration: const InputDecoration(
          labelText: 'Last name',
          border: OutlineInputBorder()
        ),
      ),
    ];

    if (screenWidth > 480) {
      return SizedBox(
        height: 50,
        child: Row(
          children: children.map((Widget e) => Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: e,
          ))).toList(),
        ),
      );
    } else {
      return Column(
        children: children.map((Widget e) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 50,
            child: e,
          ),
        )).toList(),
      );
    }
  }

  Widget buildBirthFields(double screenWidth) {
    List<Widget> children = [
      TextField(
        key: const Key('dateOfBirth'),
        controller: dateOfBirthController,
        decoration: const InputDecoration(
          labelText: 'DateOfBirth',
          border: OutlineInputBorder()
        ),
      ),
      TextField(
        key: const Key('placeOfBrith'),
        controller: placeOfBirthController,
        decoration: const InputDecoration(
          labelText: 'Place of birth',
          border: OutlineInputBorder()
        ),
      ),
      TextField(
        key: const Key('countryOfBirth'),
        controller: countryOfBirthController,
        decoration: const InputDecoration(
          labelText: 'Country of birth',
          border: OutlineInputBorder()
        ),
      ),
    ];

    if (screenWidth > 480) {
      return SizedBox(
        height: 50,
        child: Row(
          children: children.map((Widget e) => Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: e,
          ))).toList(),
        ),
      );
    } else {
      return Column(
        children: children.map((Widget e) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            height: 50,
            child: e,
          ),
        )).toList(),
      );
    }
  }
}
