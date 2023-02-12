import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

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

  void exportView(BuildContext context) async {
    final pdf = await exportPDF(context);

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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text('Test123', 
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey,
                      child: const Text('ACAB', 
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
