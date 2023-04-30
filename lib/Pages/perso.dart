import 'package:flutter/material.dart';

class CustomDicePage extends StatefulWidget {
  const CustomDicePage({super.key});

  @override
  State<CustomDicePage> createState() => _CustomDicePageState();
}

class _CustomDicePageState extends State<CustomDicePage> {
  int numberOfSides = 6;
  TextEditingController sidesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sidesController.text = numberOfSides.toString();
  }

  @override
  void dispose() {
    sidesController.dispose();
    super.dispose();
  }

  void _setNumberOfSides() {
    int newNumberOfSides = int.tryParse(sidesController.text) ?? numberOfSides;
    setState(() {
      numberOfSides = newNumberOfSides;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Dice'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Image.asset('assets/images/paradice_logo.png'),
            ),
            Text('Nombre de faces:'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: sidesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a number',
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _setNumberOfSides,
                  child: Text('Ajouter le dé'),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text('You have created a custom dice with $numberOfSides sides.'),
          ],
        ),
      ),
    );
  }
}
