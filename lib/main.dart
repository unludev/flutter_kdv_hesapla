// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  final List<bool> _selection = [true, false, false];
  String? tax;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (tax != null)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '$tax',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              Text(
                'Toplam Tutar',
              ),
              SizedBox(
                width: 70,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '₺100.00',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ToggleButtons(children: [
                  Text('%18'),
                  Text('%8'),
                  Text('%1'),
                ], isSelected: _selection, onPressed: updateSelection),
              ),
              TextButton(
                onPressed: calculateTax,
                child: Text('Vergi Hesapla'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
              ),
            ],
          )),
        ));
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTax() {
    final totalAmount = double.parse(controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final taxPercentage = [0.18, 0.08, 0.01][selectedIndex];

    final taxTotal = (totalAmount * taxPercentage).toStringAsFixed(2);

    setState(() {
      tax = '₺$taxTotal';
    });
  }
}
