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
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Riječek Solver'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = "Odaberi slovo";

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
                    ),
                  ]),
            ),
            const MyStatefulWidget(),
            ElevatedButton(
                onPressed: _launchURL, child: const Text('Otvori igru')),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
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
  var possibleWords = [];
  String log = '';
  String response = 'Empty';
  load() async {
    response = await rootBundle.loadString('assets/words_github.txt');
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
                var words = response
                    .split('\n')
                    .getRange(0, response.split('\n').length - 1);

                for (word in words) {
                  bool poss = true;
                  if (greyController.text != '') {
                    for (i in grey) {
                      if (word.contains(i)) {
                        poss = false;
                      }
                    }
                  }
                  if (yellowController.text != '') {
                    for (i in yellow) {
                      int place = int.parse(i.substring(i.length - 1));
                      String letter = i.substring(0, i.length - 1);
                      if (word.contains(letter) != true ||
                          word.substring(place - 1, place) == letter) {
                        poss = false;
                      }
                    }
                  }
                  if (greenController.text != '') {
                    for (int j in greenDict.keys) {
                      if (word.substring(j - 1, j) != greenDict[j]) {
                        poss = false;
                      }
                    }
                  }
                  if (poss) {
                    possibleWords.add(word);
                  }
                }
                for (i in possibleWords) {
                  print(i);
                }
                log =
                    'Pronađeno ${possibleWords.length} riječi: $possibleWords.';
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Pretraži'),
            ),
          ),
          Text(log),
        ],
      ),
    );
  }
}
