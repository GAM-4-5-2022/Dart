// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

_launchURL() async {
  const url = 'https://kveez.com/hr/rijecek/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          'Riječek Solver',
          style: TextStyle(fontSize: 40),
          colors: [
            Colors.red,
            Colors.pink,
            Colors.purple,
            Colors.deepPurple,
            Colors.deepPurple,
            Colors.indigo,
            Colors.green,
            Colors.lightGreen,
            Colors.lime,
            Colors.yellow,
            Colors.amber,
            Colors.orange,
            Colors.deepOrange,
          ]
        ),
      ),
      
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                  height: 5,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
                text: 'UPUTE',
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  text: 'Na linije napisati slova odvajajući ih zarezom\nZa zelena i žuta slova, poslije svakog slova napisati broj slova u riječi te zatim odvojiti zarezom\n',
                ),
              ),
            ),

            const MyStatefulWidget(),
            InkWell(
              onTap: () {_launchURL;},
              child:  Container(
                height: MediaQuery.of(context).size.height * 1 / 14,
                width: MediaQuery.of(context).size.width * 3 / 7,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.red,
                        Colors.pink,
                        Colors.purple,
                        Colors.deepPurple,
                        Colors.deepPurple,
                        Colors.indigo,
                        Colors.green,
                        Colors.lightGreen,
                        Colors.lime,
                        Colors.yellow,
                        Colors.amber,
                        Colors.orange,
                        Colors.deepOrange,
                      ]
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(""),
                    const Text(
                      "Otvori igru",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.arrow_right_alt_outlined,
                          size: 25.0,
                          color: Colors.green,
                        )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
  final numController = TextEditingController();

  String log = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: greenController,
              decoration: const InputDecoration(
                hintText: 'Zelena slova',
                hintStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)
                
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
                hintStyle: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)
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
                hintStyle: TextStyle(color: Color.fromARGB(255, 127, 128, 127), fontWeight: FontWeight.bold)
              ),
/*             validator: (String? value3) {
                if (value3 == null || value3.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }, */
            ),
            TextFormField(
              controller: numController,
              decoration: const InputDecoration(
                hintText: 'Broj ponuđenih riječi (4 je default)',
                hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
/*             validator: (String? value1) {
                if (value1 == null || value1.isEmpty) {
                  return 'Samo brojke dopuštene';
                }
                return null;
              }, */
            ),
            InkWell(
              onTap: () async {
                String response;

                response = await rootBundle.loadString('assets/words.txt');

                List<String> grey =
                    greyController.text.toLowerCase().split(',');
                List<String> yellow =
                    yellowController.text.toLowerCase().split(',');
                List<String> green =
                    greenController.text.toLowerCase().split(',');
                int wordNum = 4;
                if (numController.text != "") {
                  wordNum = int.parse(numController.text);
                }

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
                var possibleWords = {};

                var words = response
                    .split('\n')
                    .getRange(0, response.split('\n').length - 1);

                for (word in words) {
                  int freq = int.parse(
                      word.substring(word.indexOf(';') + 1, word.length));
                  word = word.substring(0, word.indexOf(';'));
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
                    possibleWords[word] = freq;
                  }
                }

                String output = '';
                if (possibleWords.isNotEmpty) {
                  for (int i = 0; i < wordNum; i++) {
                    if (i < possibleWords.length) {
                      if (i < wordNum - 1 && i < possibleWords.length - 1) {
                        output += (possibleWords.keys.elementAt(i) + ', ');
                      } else {
                        output += possibleWords.keys.elementAt(i);
                      }
                    }
                  }
                }
                if (possibleWords.isNotEmpty) {
                  setState(() {
                    log = 'Pronađeno ${possibleWords.length} riječi: $output.';
                  });
                } else {
                  setState(() {
                    log =
                        "Nije pronađena nijedna riječ. \nProvjerite jesu li svi podaci ispravno upisani.";
                  });
                }

                if (_formKey.currentState!.validate()) {}
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                child:  Container(
              height: MediaQuery.of(context).size.height * 1 / 15,
              width: MediaQuery.of(context).size.width * 3 / 7,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                    Colors.lightBlue,
                    Colors.cyan,
                  ]),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(""),
                  const Text(
                    "Pretraži",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(
                        Icons.search,
                        size: 25.0,
                        color: Colors.green,
                      ))
                ],
              ),
          ),
        ),
              ),
            ),
            Text(log),
          ],
        ),
      ),
    );
  }
}
