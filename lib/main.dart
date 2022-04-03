// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

_launchURL() async {
  const url = 'https://kveez.com/hr/rijecek/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

List<String> abeceda = <String>[
  'Prazno',
  'A',
  'B',
  'C',
  'Č',
  'Ć',
  'D',
  'DŽ',
  'Đ',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'LJ',
  'M',
  'N',
  'NJ',
  'O',
  'P',
  'R',
  'S',
  'Š',
  'T',
  'U',
  'V',
  'Z',
  'Ž'
];
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Riječek Solver'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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

  String value = "Odaberi slovo";
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'UPUTE\n\n',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text:
                          'Na linije napisati slova odvajajući ih zarezom (,).\nZa zelena i žuta slova, poslije svakog slova napisati broj slova u riječi te zatim odvojiti zarezom.',
                      //style: const TextStyle(fontWeight: FontWeight.bold))
                    ),
                  ]),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const MyStatefulWidget(),
            ElevatedButton(
                onPressed: _launchURL, child: const Text('Otvori igru')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final greyController = TextEditingController();
  final greenController = TextEditingController();
  final yellowController = TextEditingController();
  var words = [];
  String response = 'Empty';
  load() async {
    response = await rootBundle.loadString('assets/words.txt');
    setState(() {
      words = response.split('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: greenController,
            decoration: const InputDecoration(
              hintText: 'Zelena slova',
            ),
/*             validator: (String? value1) {
              if (value1 == null || value1.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, */
          ),
          TextFormField(
            controller: yellowController,
            decoration: const InputDecoration(
              hintText: 'Žuta slova',
            ),
/*             validator: (String? value2) {
              if (value2 == null || value2.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, */
          ),
          TextFormField(
            controller: greyController,
            decoration: const InputDecoration(
              hintText: 'Siva slova',
            ),
/*             validator: (String? value3) {
              if (value3 == null || value3.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, */
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                load();
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                List<String> grey =
                    greyController.text.toLowerCase().split(',');
                List<String> yellow =
                    yellowController.text.toLowerCase().split(',');
                List<String> green =
                    greenController.text.toLowerCase().split(',');

                var greenDict = {};
                var yellowDict = {};
                String i;

                if (greenController.text != "") {
                  for (i in green) {
                    greenDict[int.parse(i.substring(i.length - 1))] =
                        i.substring(0, i.length - 1);
                  }
                }
                if (yellowController.text != "") {
                  for (i in yellow) {
                    yellowDict[int.parse(i.substring(i.length - 1))] =
                        i.substring(0, i.length - 1);
                  }
                }
                String word;
                var possibleWords = [];
                List<String> alphabet = [];
                for (int i = 97; i < 123; i++) {
                  if (String.fromCharCodes([i]) != 'q' &&
                      String.fromCharCodes([i]) != 'x' &&
                      String.fromCharCodes([i]) != 'y' &&
                      String.fromCharCodes([i]) != 'w') {
                    alphabet.add(String.fromCharCodes([i]));
                  }
                }
                alphabet.add('ć');
                alphabet.add('č');
                alphabet.add('dž');
                alphabet.add('đ');
                alphabet.add('lj');
                alphabet.add('nj');
                alphabet.add('š');
                alphabet.add('ž');
                print(yellowController.text);
                print(yellowDict);
                var words = response
                    .split('\n')
                    .getRange(0, response.split('\n').length - 1);

                for (word in words) {
                  bool poss = true;
                  for (i in grey) {
                    if (word.contains(i)) {
                      poss = false;
                    }
                  }
                  for (int j in yellowDict.keys) {
                    if (word.contains(yellowDict[j]) != true ||
                        word.substring(j - 1, j) == yellowDict[j]) {
                      poss = false;
                    }
                  }
                  for (int j in greenDict.keys) {
                    if (word.substring(j - 1, j) != greenDict[j]) {
                      poss = false;
                    }
                  }
                  if (poss) {
                    possibleWords.add(word);
                  }
                }
                for (i in possibleWords) {
                  print(i);
                }
                print('Pronađeno ${possibleWords.length} riječi.');

                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Unesi'),
            ),
          ),
        ],
      ),
    );
  }
}
