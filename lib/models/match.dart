/// Prize pool details model
class PrizePool {
  final String currency;
  final double amount;
  final int totalSquads;

  const PrizePool({
    required this.currency,
    required this.amount,
    required this.totalSquads,
  });

  factory PrizePool.fromJson(Map<String, dynamic> json) {
    return PrizePool(
      currency: json['currency'] as String,
      amount: (json['amount'] as num).toDouble(),
      totalSquads: json['totalSquads'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'currency': currency,
    'amount': amount,
    'totalSquads': totalSquads,
  };
}

/// Entry fees model
class EntryFees {
  final String currency;
  final double amount;
  final int perPlayer;

  const EntryFees({
    required this.currency,
    required this.amount,
    required this.perPlayer,
  });

  factory EntryFees.fromJson(Map<String, dynamic> json) {
    return EntryFees(
      currency: json['currency'] as String,
      amount: (json['amount'] as num).toDouble(),
      perPlayer: json['perPlayer'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'currency': currency,
    'amount': amount,
    'perPlayer': perPlayer,
  };
}

/// Game mode details for a match
class MatchGameMode {
  final String name;
  final int playersCount;

  const MatchGameMode({required this.name, required this.playersCount});

  factory MatchGameMode.fromJson(Map<String, dynamic> json) {
    return MatchGameMode(
      name: json['name'] as String,
      playersCount: json['playersCount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'playersCount': playersCount};
}

/// Match model
class Match {
  final String id;
  final String title;
  final String tournament;
  final String gameType;
  final String matchType;
  final DateTime dateTime;
  final String? imageUrl;
  final MatchGameMode gameMode;
  final EntryFees entryFees;
  final PrizePool prizePool;
  final int registeredPlayers;
  final bool isFavorite;

  const Match({
    required this.id,
    required this.title,
    required this.tournament,
    required this.gameType,
    required this.matchType,
    required this.dateTime,
    required this.gameMode,
    required this.entryFees,
    required this.prizePool,
    required this.registeredPlayers,
    this.imageUrl,
    this.isFavorite = false,
  });

  Match copyWith({
    String? id,
    String? title,
    String? tournament,
    String? gameType,
    String? matchType,
    DateTime? dateTime,
    String? imageUrl,
    MatchGameMode? gameMode,
    EntryFees? entryFees,
    PrizePool? prizePool,
    int? registeredPlayers,
    bool? isFavorite,
  }) {
    return Match(
      id: id ?? this.id,
      title: title ?? this.title,
      tournament: tournament ?? this.tournament,
      gameType: gameType ?? this.gameType,
      matchType: matchType ?? this.matchType,
      dateTime: dateTime ?? this.dateTime,
      imageUrl: imageUrl ?? this.imageUrl,
      gameMode: gameMode ?? this.gameMode,
      entryFees: entryFees ?? this.entryFees,
      prizePool: prizePool ?? this.prizePool,
      registeredPlayers: registeredPlayers ?? this.registeredPlayers,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as String,
      title: json['title'] as String,
      tournament: json['tournament'] as String,
      gameType: json['gameType'] as String,
      matchType: json['matchType'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      imageUrl: json['imageUrl'] as String?,
      gameMode: MatchGameMode.fromJson(
        json['gameMode'] as Map<String, dynamic>,
      ),
      entryFees: EntryFees.fromJson(json['entryFees'] as Map<String, dynamic>),
      prizePool: PrizePool.fromJson(json['prizePool'] as Map<String, dynamic>),
      registeredPlayers: json['registeredPlayers'] as int,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'tournament': tournament,
    'gameType': gameType,
    'matchType': matchType,
    'dateTime': dateTime.toIso8601String(),
    'imageUrl': imageUrl,
    'gameMode': gameMode.toJson(),
    'entryFees': entryFees.toJson(),
    'prizePool': prizePool.toJson(),
    'registeredPlayers': registeredPlayers,
    'isFavorite': isFavorite,
  };
}
