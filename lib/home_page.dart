import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paradice/monJeuDeDes.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listNombre = ["-10", "-1", "1", "+1", "+10"];
  List<String> listDes = ["D6", "D10", "D20", "D100"];
  List<int> listNombreFace = [1, 2, 3, 4, 5, 6];
  Map<int, int> compteurValeurs = {};
  MonJeuDeDes jeuDeDes = MonJeuDeDes(nombreFace: 6);

  String utiliseDes = "D6";
  int nombreFace = 6;
  int nombreLance = 1;
  double moyenne = 0;

// change le nombre de face du des

  void changeDes(index) {
    setState(() {
      if (index == 0) {
        utiliseDes = "D6";
      } else if (index == 1) {
        utiliseDes = "D10";
      } else if (index == 2) {
        utiliseDes = "D20";
      } else if (index == 3) {
        utiliseDes = "D100";
      }
    });
  }

// Ajoute la valeur sélectionné au nombre de lancé désiré
  void ajoutNombre(index) {
    setState(() {
      if (index == 0 && nombreLance > 9) {
        nombreLance += -10;
      } else if (index == 1 && nombreLance > 0) {
        nombreLance += -1;
      } else if (index == 2) {
        nombreLance = 1;
      } else if (index == 3) {
        nombreLance += 1;
      } else if (index == 4) {
        nombreLance += 10;
      }
    });
  }

// clear tous les résultats

  void clearResultats() {
    setState(() {
      jeuDeDes.clearResultat();
      moyenne = 0;
    });
  }
// lance  les dés

  lancer() {
    setState(() {
      compteurValeurs.clear();

      jeuDeDes.lancerDes(nombreLance);
      jeuDeDes.genereValeur();
      compteurValeurs = jeuDeDes.getResultCompteur();
      moyenne = jeuDeDes.calculerMoyenne(jeuDeDes.getResultCompteur());
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> compteurValeurs = jeuDeDes.getResultCompteur();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
              flexibleSpace: Image.asset('assets/images/paradice_logo.png'))),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: const Text('Accès aux statistiques'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Accès aux dés personnalisés'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: List.generate(
              listDes.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // exécute la fonction ajoutNombre
                    changeDes(index);
                  },
                  child: Text(listDes[index]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: List.generate(
              listNombre.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  onPressed: () {
                    // exécute la fonction ajoutNombre
                    ajoutNombre(index);
                  },
                  child: Text(listNombre[index]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Nombre de $utiliseDes : $nombreLance'),
          SizedBox(
            height: 10,
          ),
          const Text('Les résultats :'),
          Column(
            children: List.generate(
              listNombreFace.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                    'Nombre de ${index + 1} : ${compteurValeurs[index + 1] ?? 0}'),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Moyenne obtenue : $moyenne')
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 16),
            child: FloatingActionButton(
              onPressed: lancer,
              tooltip: 'Lancer',
              child: Icon(Icons.casino),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 16),
            child: FloatingActionButton(
              onPressed: clearResultats,
              tooltip: 'Clear',
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}
