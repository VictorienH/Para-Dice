import 'dart:math';

class MonJeuDeDes {
  int nombreFace;
  int resultatFace = 0;

  MonJeuDeDes({required this.nombreFace});

  List<int> resultatDes = [];
  Map<int, int> compteurValeurs = {};

  List<int> lancerDes(int nombreLance) {
    Random random = Random();

    for (int i = 0; i < nombreLance; i++) {
      int resultat = random.nextInt(nombreFace) + 1;
      resultatDes.add(resultat);
    }
    return resultatDes;
  }

  void genereValeur() {
    for (int valeur in resultatDes) {
      if (compteurValeurs.containsKey(valeur)) {
        compteurValeurs[valeur] = compteurValeurs[valeur]! + 1;
      } else {
        compteurValeurs[valeur] = 1;
      }
    }
  }

  void clearResultat() {
    compteurValeurs.clear();
    resultatDes.clear();
  }

  Map<int, int> getResultCompteur() {
    return compteurValeurs;
  }

  int getResultDes() {
    return resultatFace;
  }

  int getNbFace() {
    return nombreFace;
  }

  double calculerMoyenne(Map<int, int> des) {
    var total = 0;
    var count = 0;
    des.forEach((key, value) {
      total += key * value;
      count += value;
    });
    return count == 0 ? 0 : total / count;
  }
}
