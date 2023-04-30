import 'dart:ffi';

import 'package:flutter/material.dart';

import 'Pages/home_page.dart';
import 'Pages/perso.dart';
import 'Pages/personnaliser.dart';
import 'Pages/accueil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projet Para\'Dice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AccueilPage(),
      routes: <String, WidgetBuilder>{
        '/Accueil': (BuildContext context) => AccueilPage(),
        '/Statistique': (BuildContext context) => HomePage(),
        '/Perso': (BuildContext context) => CustomDicePage(),
        '/Personnaliser': (BuildContext context) => PersonnaliserPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
