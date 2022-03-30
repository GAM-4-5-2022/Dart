import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Flutter is Fun! " + '$count')),
        body: ListView.builder(itemBuilder: (_, index) {
          return Container(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              width: 500,
              height: 500);
        }),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                count++;
              });
            }),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ]),
        drawer: const Drawer(
          child: Text('Yo!'),
        ),
      ),
    );
  }
}
