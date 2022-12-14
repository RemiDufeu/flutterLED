import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led/dataObject/reglages.dart';
import 'package:led/pages/home.dart';
import 'package:led/pages/settings.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP LED',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ESP LED'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect fdeff
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  Reglages _reglages = Reglages.empty();
  var listScreens = null;
  String ipesp = "https://espmockdata.herokuapp.com";

  @override
  void initState() {
    super.initState();
    _getReglages();
  }

  Future<Reglages> _getReglages() async {
    String apiUrl = ipesp + '/reglages';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      if (response.statusCode == 200) {
        Reglages reglagesJson = Reglages.fromJson(jsonDecode(response.body));
        setState(() {
          _reglages = reglagesJson;
        });
        return reglagesJson;
      } else {
        setState(() {
          _reglages = Reglages.empty();
        });
        print('Request failed with status: ${response.statusCode}.');
        return _reglages;
      }
    } catch (e) {
      print(e);
      setState(() {
        _reglages = Reglages.empty();
      });
      return _reglages;
    }
  }

  void setPage(int pageNumber) {
    setState(() {
      _index = pageNumber;
    });
  }

  changeip(ip) {
    setState(() {
      ipesp = ip;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = _index == 0
        ? (_reglages.modes.length == 0
            ? Center(
                child: Text(
                "ESP non trouv??",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ))
            : Home(_reglages, _getReglages, ipesp))
        : Settings(_reglages, _getReglages, ipesp, changeip);

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
      ),
      body: screen,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey[600],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black12,
        elevation: 1,
        currentIndex: _index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int indexClicked) {
          setState(() {
            _index = indexClicked;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
