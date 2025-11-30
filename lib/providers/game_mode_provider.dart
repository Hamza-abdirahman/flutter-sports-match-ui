import 'package:flutter/material.dart';
import '../models/game_mode.dart';

/// Provider for managing game modes
class GameModeProvider extends ChangeNotifier {
  final List<GameMode> _gameModes = [];
  String _selectedGameModeId = '';

  List<GameMode> get gameModes => _gameModes;
  String get selectedGameModeId => _selectedGameModeId;

  GameMode? get selectedGameMode {
    try {
      return _gameModes.firstWhere((gm) => gm.id == _selectedGameModeId);
    } catch (e) {
      return null;
    }
  }

  GameModeProvider() {
    _initializeGameModes();
  }

  /// Initialize sample game modes based on the design
  void _initializeGameModes() {
    _gameModes.addAll([
      const GameMode(
        id: 'arena',
        name: 'Sniper',
        icon: '✨',
        playersLabel: 'Ongoing Arena : 20',
        maxPlayers: 1,
        description: 'Arena gameplay mode',
      ),
      const GameMode(
        id: 'zenith',
        name: 'Assault',
        icon: '🦇',
        playersLabel: 'Ongoing Arena',
        maxPlayers: 4,
        description: 'Team-based league competition',
      ),
      const GameMode(
        id: 'championship',
        name: 'Championship',
        icon: '🩸',
        playersLabel: 'Championship',
        maxPlayers: 4,
        description: 'Championship tournament mode',
      ),
    ]);

    // Set first game mode as selected
    if (_gameModes.isNotEmpty) {
      _selectedGameModeId = _gameModes[0].id;
    }
  }

  /// Select a game mode by ID
  void selectGameMode(String gameModeId) {
    if (_gameModes.any((gm) => gm.id == gameModeId)) {
      _selectedGameModeId = gameModeId;
      notifyListeners();
    }
  }

  /// Get game mode by ID
  GameMode? getGameModeById(String id) {
    try {
      return _gameModes.firstWhere((gm) => gm.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search game modes
  List<GameMode> searchGameModes(String query) {
    if (query.isEmpty) return _gameModes;
    final lowerQuery = query.toLowerCase();
    return _gameModes
        .where((gm) => gm.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Get game modes by max players
  List<GameMode> filterByMaxPlayers(int maxPlayers) {
    return _gameModes.where((gm) => gm.maxPlayers == maxPlayers).toList();
  }
}
