/// Game mode model
class GameMode {
  final String id;
  final String name;
  final String icon;
  final String playersLabel;
  final int maxPlayers;
  final String? description;

  const GameMode({
    required this.id,
    required this.name,
    required this.icon,
    required this.playersLabel,
    required this.maxPlayers,
    this.description,
  });

  factory GameMode.fromJson(Map<String, dynamic> json) {
    return GameMode(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      playersLabel: json['playersLabel'] as String,
      maxPlayers: json['maxPlayers'] as int,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon': icon,
    'playersLabel': playersLabel,
    'maxPlayers': maxPlayers,
    'description': description,
  };
}
