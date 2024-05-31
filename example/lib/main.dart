import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

void main() => runApp(const Demo());

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final ExportDelegate exportDelegate = ExportDelegate(
    ttfFonts: {
      'LoveDays': 'assets/fonts/LoveDays-Regular.ttf',
      'OpenSans': 'assets/fonts/OpenSans-Regular.ttf',
    },
  );

  Future<void> saveFile(document, String name) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(await document.save());
    debugPrint('Saved exported PDF at: ${file.path}');
  }

  String currentFrameId = 'questionaireDemo';

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.black87,
          ),
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            key: GlobalKey<ScaffoldState>(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text('Flutter to PDF - Demo'),
              bottom: TabBar(
                indicator: const UnderlineTabIndicator(),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.question_answer),
                    text: 'Questionaire',
                  ),
                  Tab(
                    icon: Icon(Icons.ssid_chart),
                    text: 'Charts & Custom Paint',
                  ),
                ],
                onTap: (int value) {
                  setState(() {
                    currentFrameId =
                        value == 0 ? 'questionaireDemo' : 'captureWrapperDemo';
                  });
                },
              ),
            ),
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    final ExportOptions overrideOptions = ExportOptions(
                      textFieldOptions: TextFieldOptions.uniform(
                        interactive: false,
                      ),
                      checkboxOptions: CheckboxOptions.uniform(
                        interactive: false,
                      ),
                    );
                    final pdf = await exportDelegate.exportToPdfDocument(
                        currentFrameId,
                        overrideOptions: overrideOptions);
                    saveFile(pdf, 'static-example');
                  },
                  child: const Row(
                    children: [
                      Text('Export as static'),
                      Icon(Icons.save_alt_outlined),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final pdf = await exportDelegate
                        .exportToPdfDocument(currentFrameId);
                    saveFile(pdf, 'interactive-example');
                  },
                  child: const Row(
                    children: [
                      Text('Export as interactive'),
                      Icon(Icons.save_alt_outlined),
                    ],
                  ),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                ExportFrame(
                  frameId: 'questionaireDemo',
                  exportDelegate: exportDelegate,
                  child: const QuestionnaireExample(),
                ),
                ExportFrame(
                  frameId: 'captureWrapperDemo',
                  exportDelegate: exportDelegate,
                  child: const CaptureWrapperExample(),
                ),
              ],
            ),
          ),
        ),
      );
}

class QuestionnaireExample extends StatefulWidget {
  const QuestionnaireExample({super.key});

  @override
  State<QuestionnaireExample> createState() => _QuestionnaireExampleState();
}

class _QuestionnaireExampleState extends State<QuestionnaireExample> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final countryOfBirthController = TextEditingController();

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
                    children: [
                      Text('Dunef UG (haftungsbeschränkt)'),
                      Text(
                        'Questionnaire',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (MediaQuery.of(context).size.width > 425)
                    const Row(
                      children: [
                        Text(
                          'Date: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text('04.04.2023'),
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
                      image: DecorationImage(
                        image: NetworkImage('http://i.pravatar.cc/100'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child:
                          buildNameFields(MediaQuery.of(context).size.width)),
                ],
              ),
              const SizedBox(height: 16),
              buildBirthFields(MediaQuery.of(context).size.width),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                style: TextStyle(fontFamily: 'LoveDays'),
              ),
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
                  const Text(
                    'I hereby accept the terms of the Lorem Ipsum.',
                    style: TextStyle(fontFamily: 'OpenSans'),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Please select your availability:',
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
              const Text(
                'Thank you for filling out our questionnaire. We will get back to you as soon as possible.',
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
            labelText: 'First name', border: OutlineInputBorder()),
      ),
      TextField(
        key: const Key('lastName'),
        controller: lastNameController,
        decoration: const InputDecoration(
            labelText: 'Last name', border: OutlineInputBorder()),
      ),
    ];

    if (screenWidth > 480) {
      return SizedBox(
        height: 50,
        child: Row(
          children: children
              .map((Widget e) => Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: e,
                  )))
              .toList(),
        ),
      );
    } else {
      return Column(
        children: children
            .map((Widget e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: e,
                  ),
                ))
            .toList(),
      );
    }
  }

  Widget buildBirthFields(double screenWidth) {
    List<Widget> children = [
      TextField(
        key: const Key('dateOfBirth'),
        controller: dateOfBirthController,
        decoration: const InputDecoration(
            labelText: 'DateOfBirth', border: OutlineInputBorder()),
      ),
      TextField(
        key: const Key('placeOfBrith'),
        controller: placeOfBirthController,
        decoration: const InputDecoration(
            labelText: 'Place of birth', border: OutlineInputBorder()),
      ),
      TextField(
        key: const Key('countryOfBirth'),
        controller: countryOfBirthController,
        decoration: const InputDecoration(
            labelText: 'Country of birth', border: OutlineInputBorder()),
      ),
    ];

    if (screenWidth > 480) {
      return SizedBox(
        height: 50,
        child: Row(
          children: children
              .map((Widget e) => Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: e,
                  )))
              .toList(),
        ),
      );
    } else {
      return Column(
        children: children
            .map((Widget e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: e,
                  ),
                ))
            .toList(),
      );
    }
  }
}

class CaptureWrapperExample extends StatelessWidget {
  const CaptureWrapperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: CaptureWrapper(
              key: const Key('Chart'),
              child: buildChart(),
            ),
          ),
          CaptureWrapper(
            key: const Key('CustomPaint'),
            child: CustomPaint(
              size: const Size(300, 300),
              painter: HousePainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChart() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    // Example shows a mix of positive and negative data values.
    chartData = ChartData(
      dataRows: const [
        [2000.0, 1800.0, 2200.0, 2300.0, 1700.0, 1800.0],
        [1100.0, 1000.0, 1200.0, 800.0, 700.0, 800.0],
        [0.0, 100.0, -200.0, 150.0, -100.0, -150.0],
        [-800.0, -400.0, -300.0, -400.0, -200.0, -250.0],
      ],
      xUserLabels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
      dataRowsLegends: const [
        'Big Corp',
        'Medium Corp',
        'Print Shop',
        'Bar',
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );
    return LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
  }
}

class HousePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    // Draw the house body
    const body = Rect.fromLTWH(50, 100, 200, 200);
    canvas.drawRect(body, paint);

    // Draw the roof
    final roofPath = Path()
      ..moveTo(150, 20)
      ..lineTo(280, 100)
      ..lineTo(20, 100)
      ..close();
    paint.color = Colors.red;
    canvas.drawPath(roofPath, paint);

    // Draw the door
    const door = Rect.fromLTWH(125, 230, 50, 70);
    paint.color = Colors.black;
    canvas.drawRect(door, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
