import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:led/components/homeButton.dart';
import 'package:led/dataObject/mode.dart';
import 'package:led/dataObject/reglages.dart';

import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  final Reglages reglages;
  final Future<Reglages> Function() resetReglages;

  const Home(this.reglages, this.resetReglages);

  final apiUrl = 'https://espmockdata.herokuapp.com/reglages';

  powerToggle() async {
    final response = await http.post(Uri.parse(apiUrl + '/power'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }).then((value) => this.resetReglages());
  }

  changeLevel(newlevel) async {
    final response = await http.post(Uri.parse(apiUrl + '/level'),
        body: jsonEncode(<String, double>{'level': newlevel}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }).then((value) => this.resetReglages());
  }

  changeMode(mode) async {
    final response = await http.post(Uri.parse(apiUrl + '/mode'),
        body: jsonEncode(<String, String>{'currentMode': mode}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }).then((value) => this.resetReglages());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HomeButton(
          label: 'Power',
          action: () => this.powerToggle(),
          actif: this.reglages.power,
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
          value: this.reglages.level * 100,
          activeColor: Colors.white,
          onChanged: (value) => changeLevel(value / 100),
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
                action: () => this.changeMode(reglage.name),
                actif: reglage.name == this.reglages.currentMode,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
