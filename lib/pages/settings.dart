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

  colorStringToColor(String cString) {
    String r = cString.substring(4, cString.length - 1);
    List<int> q = r.split(",").map((c) => int.parse(c)).toList();
    return Color.fromRGBO(q[0], q[1], q[2], 1);
  }

  Settings(this.reglages, this.resetReglages, this.ipesp, this.changeIp);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: TextEditingController(text: this.ipesp),
            onSubmitted: (value) => {changeIp(value), this.resetReglages()},
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
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: reglages.modes.length,
            itemBuilder: (context, index) {
              var item = reglages.modes[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(children: [
                    Text(item.name, style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Row(
                        children: item.color
                            .map(
                              (element) => Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    color: colorStringToColor(element)),
                              ),
                            )
                            .toList()),
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
