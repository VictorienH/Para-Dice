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
  List<int> listNombreFace = [];
  Map<int, int> compteurValeurs = {};
  int nombreFace = 6;
  MonJeuDeDes jeuDeDes = MonJeuDeDes();

  String utiliseDes = "D6";

  int nombreLance = 1;
  double moyenne = 0;

// change le nombre de face du des

  void changeDes(index) {
    setState(() {
      if (index == 0) {
        utiliseDes = "D6";
        nombreFace = 6;
      } else if (index == 1) {
        utiliseDes = "D10";
        nombreFace = 10;
      } else if (index == 2) {
        utiliseDes = "D20";
        nombreFace = 20;
      } else if (index == 3) {
        utiliseDes = "D100";
        nombreFace = 100;
      }
    });
  }

  // change la liste de nombre
  void changeListeNombreFace() {
    setState(() {
      if (utiliseDes == "D6") {
        listNombreFace.clear();
        for (int i = 1; i <= 6; i++) {
          listNombreFace.add(i);
        }
      } else if (utiliseDes == "D10") {
        listNombreFace.clear();
        for (int i = 1; i <= 10; i++) {
          listNombreFace.add(i);
        }
      } else if (utiliseDes == "D20") {
        listNombreFace.clear();
        for (int i = 1; i <= 20; i++) {
          listNombreFace.add(i);
        }
      } else if (utiliseDes == "D100") {
        listNombreFace.clear();
        for (int i = 1; i <= 100; i++) {
          listNombreFace.add(i);
        }
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

      jeuDeDes.lancerDes(nombreLance, nombreFace);
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
          preferredSize: Size.fromHeight(150),
          child: AppBar(
              flexibleSpace: Image.asset('assets/images/paradice_logo.png'))),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text('Menu'),
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
          const SizedBox(
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
                    changeListeNombreFace();
                  },
                  child: Text(listDes[index]),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.green,
              thickness: 2,
            ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.green,
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Nombre de face ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                TextSpan(
                  text: utiliseDes,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: ': Lancer ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                TextSpan(
                  text: '$nombreLance',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: ' dés',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Les résultats :',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
              height: 250,
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 0, left: 10, right: 10),
                itemCount: listNombreFace.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: 'Nb de ${index + 1} : ',
                          ),
                          TextSpan(
                            text: '${compteurValeurs[index + 1] ?? 0}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
          /*Expanded(
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: (listNombreFace.length / 2).ceil(),
            itemBuilder: (context, index) {
              final i = index * 2;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Nombre de ${i + 1} : ${compteurValeurs[i + 1] ?? 0}',
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: (listNombreFace.length / 2).floor(),
            itemBuilder: (context, index) {
              final i = index * 2 + 1;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Nombre de ${i + 1} : ${compteurValeurs[i + 1] ?? 0}',
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
),*/
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.green,
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Moyenne obtenue : ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                TextSpan(
                  text: moyenne.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, bottom: 16),
            child: FloatingActionButton(
              onPressed: lancer,
              tooltip: 'Lancer',
              child: const Icon(Icons.casino),
            ),
          ),
          const SizedBox(width: 170), // Ajouter un espace de 16 points
          Container(
            margin: const EdgeInsets.only(left: 16, bottom: 16),
            child: FloatingActionButton(
              onPressed: clearResultats,
              tooltip: 'Clear',
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}
