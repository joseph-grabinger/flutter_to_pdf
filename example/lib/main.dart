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

  final TextFieldOptions options = TextFieldOptions.uniform(
    interactive: false,
    textStyle: const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold
    ),
  );

  void exportView(BuildContext context) async {
    final pdf = await exportToPDF(context);

    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File("${dir.path}/example.pdf");

    await file.writeAsBytes(await pdf.save());
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
              return Container(
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
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey)
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          FloatingActionButton(
            onPressed: () => exportView(exportContext),
            tooltip: 'Export View',
            child: const Icon(Icons.save_alt_outlined),
          ),
        ],
      ),
    );
  }
}
