import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../dataObject/reglages.dart';

class Settings extends StatelessWidget {
  Reglages reglages;
  Future<Reglages> Function() resetReglages;
  final String ipesp;
  var changeIp;

  Settings(this.reglages, this.resetReglages, this.ipesp, this.changeIp);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: TextEditingController(text: this.ipesp),
            onSubmitted: (value) => this.changeIp(value),
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              labelText: 'Ip de la led',
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              focusColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
