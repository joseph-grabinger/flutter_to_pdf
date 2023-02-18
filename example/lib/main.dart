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
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text('Hello Space', 
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: true,
                          // maxLines: 4,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(),
                        obscureText: true,
                        style: const TextStyle(color: Colors.green),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      Image.network('https://picsum.photos/250?image=9'),
                      SizedBox(
                        height: 50,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Colors.blueGrey,
                            height: 50,
                            width: 50,
                            child: const Text('Hello World', 
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // color: Colors.green,
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://picsum.photos/250?image=9'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
