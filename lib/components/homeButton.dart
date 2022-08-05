import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeButton extends StatelessWidget {
  final String label;
  final Function action;
  final bool actif;

  const HomeButton(
      {Key? key,
      required this.label,
      required this.action,
      required this.actif})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.actif ? null : () => {this.action()},
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        height: 70,
        width: 150,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 75, 75, 75),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 58, 58, 58),
              offset: Offset(10, 10),
              blurRadius: 30,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 85, 85, 85),
              offset: Offset(-10, -10),
              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          this.label,
          style: TextStyle(
            fontSize: 18,
            color:
                this.actif ? Color.fromARGB(255, 143, 143, 143) : Colors.white,
          ),
        ),
      ),
    );
  }
}
