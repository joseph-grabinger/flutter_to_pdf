import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import 'package:teaplates/teaplates.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BuildContext exportContext; 

  bool checked = false;

  void saveFile(Document doc, String name) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File("${dir.path}/$name.pdf");

    await file.writeAsBytes(await doc.save());
    print('Saved exported PDF at: ${file.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter View to PDF Demo'),
      ),
      body: Column(
        children: [
          Builder(
            builder: (BuildContext ctx) {
              exportContext = ctx;
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
                      width: double.infinity,
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
                          )
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
                        )),
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // shape: const CircleBorder(),
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
            },
          ),
          const SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () async {
                  final pdf = await exportToPDF(exportContext, 
                    options: ExportOptions(
                      textFieldOptions: TextFieldOptions.uniform(
                        interactive: false, 
                      ),
                      checkboxOptions: CheckboxOptions.uniform(
                        interactive: false,
                      )
                    ),
                  );
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
                  final pdf = await exportToPDF(exportContext);
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
        ],
      ),
    );
  }
}
