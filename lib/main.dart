import 'package:flutter/material.dart';

import 'slot_machine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Contest',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Slot Machine Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> participants = [
    'Kumar Pratik',
    'Apoorva Sahu',
    'Kumar Sanket',
    'Atul Ranjan',
    "Varun Kumar Sahu",
    "Saurabh Sahu",
    "Suraj Ahmad Choudhury",
    "Amith M S",
    'Sankhadeep Roy',
    "Sarika Gautam",
    "MD Khalid Imam",
    'Suresh babu',
    'Pushkar Kumar',
    'Ruchika Guptha',
    'Shubham Kumar',
    "Aditya Soni",
    "Sumant Raj",
    "Raja Jain",
    "Nitish",
    'Anushka',
    'Afreena',
    "Vikram",
    "Tanmay",
    "Rishab Agarwal",
    "Pavitra",
    "Raghav",
    'Armaan',
    'Rudra',
    'Vinay',
    'Flutter Team',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: Center(
        child: LuckyDraw(participants, 125, 275),
      ),
    );
  }
}
