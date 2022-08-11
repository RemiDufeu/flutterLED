class Mode {
  final String name;
  final bool streaming;
  final List<String> color;

  const Mode({
    required this.name,
    required this.streaming,
    required this.color,
  });

  factory Mode.fromJson(Map<String, dynamic> json) {
    return Mode(
        name: json['name'],
        streaming: json['streaming'],
        color: List<String>.from(json['color']));
  }
}
