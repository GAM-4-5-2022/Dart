// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, duplicate_ignore

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

String findWords(response, green, yellow, grey, wordNum) {
  var words = response.split('\n');
  var bestWords = List.empty(growable: true);

  int counter = 0;
  for(int wordLoc = 0; wordLoc < words.length && counter < wordNum; wordLoc++){
    String word = words[wordLoc];
    bool compCheck = true;

    for(int i = 0; i < green.length; i++){
      int val = green[i][1].codeUnitAt(0)-"1".codeUnitAt(0);
      if (word[val] != green[i][0]) compCheck = false;
    }
    for(int i = 0; i < yellow.length; i++){
      int val = yellow[i][1].codeUnitAt(0)-"1".codeUnitAt(0);
      if(word[val] == yellow[i][0]) compCheck = false;
    }
    for(int i = 0; i < grey.length; i++){
      for(int j = 0; j < 5; j++){
        if (word[j] == grey[i]) compCheck = false;
      }
    }
    
    if (!compCheck) continue;
    bestWords.add(word.substring(0,5));
    counter++;
  }

  if (bestWords.isEmpty){
    return "Nije Ponađena nijedna riječ\nProvijerite jeste li ispravno upisali sve podatke";
  }

  String output = "Najbolje pronađene riječi:\n";
  for(int i = 0; i < bestWords.length; i++){
    output += bestWords[i];
    if (i != bestWords.length-1) output += ", ";
  } return output;
}

String prepareFormText(tekst) {
  String noSpaces = "";
  for(int i = 0; i < tekst.length; i++){
    if (tekst[i] != " ") noSpaces += tekst[i];
  }
  return noSpaces.toLowerCase();
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
        title: GradientText('Riječek Solver',
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
            ]),
      ),
      body: Center(
        child: Column(
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
                  text:
                      'Na linije napisati slova odvajajući ih zarezom\nZa zelena i žuta slova, poslije svakog slova napisati broj slova u riječi te zatim odvojiti zarezom\n',
                ),
              ),
            ),
            const MyStatefulWidget(),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: greenController,
              decoration: const InputDecoration(
                  hintText: 'Zelena slova',
                  hintStyle: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)
              ),
            ),
            TextFormField(
              controller: yellowController,
              decoration: const InputDecoration(
                  hintText: 'Žuta slova',
                  hintStyle: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold)
              ),
            ),
            TextFormField(
              controller: greyController,
              decoration: const InputDecoration(
                  hintText: 'Siva slova',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 127, 128, 127),
                      fontWeight: FontWeight.bold)
              ),
            ),
            TextFormField(
              controller: numController,
              decoration: const InputDecoration(
                  hintText: 'Broj ponuđenih riječi (6 je default)',
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    var grey = List.empty(growable: true);
                    var yellow = List.empty(growable: true);
                    var green = List.empty(growable: true);
                    int wordNum = 6;

                    if (greyController.text != "") grey = prepareFormText(greyController.text).split(',');
                    if (yellowController.text != "") yellow = prepareFormText(yellowController.text).split(',');
                    if (greenController.text != "") green = prepareFormText(greenController.text).split(',');
                    if (numController.text != "") wordNum = int.parse(numController.text);

                    String response;
                    response = await rootBundle.loadString('assets/words.txt');
                    String output = findWords(response, green, yellow, grey, wordNum);
                    setState(() {log = output;});
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1 / 14,
                      width: MediaQuery.of(context).size.width * 3 / 7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.lightBlue,
                              Colors.cyan,
                            ]
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(""),
                          const Text(
                            "Pretraži",
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
                                Icons.search,
                                size: 25.0,
                                color: Colors.green,
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text("   "),
                InkWell(
                  onTap: () {
                    _launchURL();
                  },
                  child: Container(
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
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
            Text(""),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                text: log,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
