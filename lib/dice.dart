import 'dart:math';

class Des {
  int nombreFace;
  int resultatFace = 0;

  Des({required this.nombreFace});

  void lanceDe() {
    resultatFace = Random().nextInt(nombreFace) + 1;
  }

  int getResult() {
    return resultatFace;
  }

  int getNbFace() {
    return nombreFace;
  }
}
