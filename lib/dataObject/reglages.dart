import 'mode.dart';

class Reglages {
  final String currentMode;
  final bool power;
  final List<Mode> modes;
  final double level;

  const Reglages({
    required this.currentMode,
    required this.power,
    required this.modes,
    required this.level,
  });

  factory Reglages.fromJson(Map<String, dynamic> json) {
    return Reglages(
        currentMode: json['currentMode'],
        power: json['power'],
        modes: List<Mode>.from(
            json['modes'].map((element) => Mode.fromJson(element))),
        level: json['level']);
  }

  static Reglages empty() {
    return Reglages(currentMode: '', power: false, modes: [], level: 0);
  }
}
