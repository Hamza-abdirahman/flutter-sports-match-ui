import 'package:flutter/material.dart';
import '../models/match.dart';

/// Provider for managing match data and state
class MatchProvider extends ChangeNotifier {
  final List<Match> _matches = [];
  final List<Match> _registeredMatches = [];
  final Set<String> _favoriteIds = {};

  List<Match> get matches => _matches;
  List<Match> get registeredMatches => _registeredMatches;
  Set<String> get favoriteIds => _favoriteIds;

  MatchProvider() {
    _initializeMatches();
  }

  /// Initialize sample match data based on the design
  void _initializeMatches() {
    _matches.addAll([
      Match(
        id: '1',
        title: 'GWCS Season 1',
        tournament: 'GWCS',
        gameType: 'Erangle',
        matchType: 'BATTLE ROYAL',
        dateTime: DateTime.now().add(const Duration(days: 1)),
        imageUrl: null, // Placeholder for image
        gameMode: const MatchGameMode(name: 'Solo', playersCount: 1),
        entryFees: const EntryFees(currency: '₹', amount: 59, perPlayer: 1),
        prizePool: const PrizePool(currency: '₹', amount: 3000, totalSquads: 0),
        registeredPlayers: 45,
        isFavorite: false,
      ),
      Match(
        id: '2',
        title: 'Indigos Series',
        tournament: 'Indigos',
        gameType: 'Erangle',
        matchType: 'BATTLE ROYAL',
        dateTime: DateTime.now().add(const Duration(days: 2)),
        imageUrl: null,
        gameMode: const MatchGameMode(name: 'Squad', playersCount: 4),
        entryFees: const EntryFees(currency: '₹', amount: 59, perPlayer: 4),
        prizePool: const PrizePool(
          currency: '₹',
          amount: 3000,
          totalSquads: 23,
        ),
        registeredPlayers: 92,
        isFavorite: false,
      ),
      Match(
        id: '3',
        title: 'Championship 3030',
        tournament: 'Championship',
        gameType: 'Erangle',
        matchType: 'BATTLE ROYAL',
        dateTime: DateTime.now().add(const Duration(days: 3)),
        imageUrl: null,
        gameMode: const MatchGameMode(name: 'Squad', playersCount: 4),
        entryFees: const EntryFees(currency: '₹', amount: 59, perPlayer: 4),
        prizePool: const PrizePool(
          currency: '₹',
          amount: 3000,
          totalSquads: 23,
        ),
        registeredPlayers: 88,
        isFavorite: false,
      ),
    ]);
  }

  /// Toggle favorite status of a match
  void toggleFavorite(String matchId) {
    if (_favoriteIds.contains(matchId)) {
      _favoriteIds.remove(matchId);
    } else {
      _favoriteIds.add(matchId);
    }

    // Update the match object
    final index = _matches.indexWhere((m) => m.id == matchId);
    if (index != -1) {
      _matches[index] = _matches[index].copyWith(
        isFavorite: !_matches[index].isFavorite,
      );
    }

    notifyListeners();
  }

  /// Register for a match
  void registerMatch(String matchId) {
    final match = _matches.firstWhere((m) => m.id == matchId);
    if (!_registeredMatches.any((m) => m.id == matchId)) {
      _registeredMatches.add(match);
      notifyListeners();
    }
  }

  /// Unregister from a match
  void unregisterMatch(String matchId) {
    _registeredMatches.removeWhere((m) => m.id == matchId);
    notifyListeners();
  }

  /// Get a single match by ID
  Match? getMatchById(String id) {
    try {
      return _matches.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Check if match is favorite
  bool isFavorite(String matchId) => _favoriteIds.contains(matchId);

  /// Check if user is registered for match
  bool isRegistered(String matchId) {
    return _registeredMatches.any((m) => m.id == matchId);
  }

  /// Search matches by title or tournament name
  List<Match> searchMatches(String query) {
    if (query.isEmpty) return _matches;
    final lowerQuery = query.toLowerCase();
    return _matches
        .where(
          (match) =>
              match.title.toLowerCase().contains(lowerQuery) ||
              match.tournament.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  /// Filter matches by game type
  List<Match> filterByGameType(String gameType) {
    if (gameType.isEmpty) return _matches;
    return _matches.where((m) => m.gameType == gameType).toList();
  }
}
