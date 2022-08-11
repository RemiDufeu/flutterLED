import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:led/components/homeButton.dart';
import 'package:led/dataObject/mode.dart';
import 'package:led/dataObject/reglages.dart';

class Home extends StatelessWidget {
  final Reglages reglages;
  final Future<Reglages> Function() resetReglages;

  const Home(this.reglages, this.resetReglages);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HomeButton(
          label: 'Power',
          action: () => print(this.reglages.currentMode),
          actif: false,
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Luminosité',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Slider(
          value: 50,
          activeColor: Colors.white,
          onChanged: (value) => print(this.reglages.currentMode),
          max: 100,
          divisions: 20,
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.only(top: 30),
            crossAxisCount: 3,
            children: this.reglages.modes.map((reglage) {
              return HomeButton(
                label: reglage.name,
                action: () => print(reglage.name),
                actif: reglage.name == this.reglages.currentMode,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
