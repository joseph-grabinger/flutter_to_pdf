import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late BuildContext exportContext; 

  void visitAllAlt(BuildContext context) {
    context.visitChildElements((Element element) { 
      print('Initial: $element');
      visitAlt(element, 1);
    });
  }

  void visitAlt(Element element, int level) {
    List<Widget> children = [];
    level++;
    element.visitChildElements((Element element) {
      print('Element: ${element.widget}');
      if (element.widget is MergeSemantics) {
        return;
      }
      children.add(element.widget);
      visitAlt(element, level);
    });
    print('Level: $level: $children');
  }

  // void visitAll(BuildContext context) {
  //   int level = 1;
  //   context.visitChildElements((Element element) {
  //     print('Initial: $element');
  //     visit(element, level);
  //   });
  // }

  // void visit(Element element, int level) {
  //   List<Widget> children = [];
  //   element.visitChildElements((Element element) {
  //     if (element.widget.runtimeType != MergeSemantics) {
  //       children.add(element.widget);
  //       visit(element, level++);
  //     }
  //   });
  //   print('Level: $level: $children');
  // }

  void _incrementCounter(BuildContext ctx) async {
    setState(() {
      _counter++;
    });
    // visitAllAlt(ctx);
    await exportPDF(ctx);
    // visitAll(ctx);
    // ctx.visitChildElements((Element element) { 
    //   print('1: $element');
    //   element.visitChildElements((element) { 
    //     print(element);
    //     element.visitChildElements((Element element) { 
    //       print(element);
    //       print('Type: ${element.widget.runtimeType}');
    //       print('Data: ${element.widget}');
    //       if (element.widget is Text) {
    //         Text t = element.widget as Text;
    //         print('Text: ${t.data}');
    //       }
    //       element.visitChildElements((element) {
    //         print('last: $element');
    //         print(element.runtimeType);
    //         print(element.widget.runtimeType);
    //         print(element.widget);
    //       });
    //     });
    //   });});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
                      child: Text('Test123', style: TextStyle(color: Colors.red),)),
                    Container(
                      color: Colors.blueGrey,
                      child: Text('ACAB', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,))),
                  ],
                ),
              );
            },
          ),
          FloatingActionButton(
                onPressed: () => _incrementCounter(exportContext),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )
        ],
      ),
    );
  }
}
