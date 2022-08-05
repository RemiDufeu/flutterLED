import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:led/components/homeButton.dart';
import 'package:led/dataObject/mode.dart';

var reglages = [
  Mode('Guirelande', () => print('mdr'), true),
  Mode('Cosy', () => print('mdr'), false),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: reglages.map((reglage) {
        return HomeButton(
          label: reglage.label,
          action: reglage.action,
          actif: reglage.actif,
        );
      }).toList(),
    );
  }
}
