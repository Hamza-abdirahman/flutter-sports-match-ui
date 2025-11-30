import 'package:flutter/material.dart';

/// Provider for managing app-wide UI state
class AppStateProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  int _selectedNavIndex = 0;
  String _searchQuery = '';

  bool get isDarkMode => _isDarkMode;
  int get selectedNavIndex => _selectedNavIndex;
  String get searchQuery => _searchQuery;

  /// Toggle theme mode
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Set navigation index
  void setNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  /// Update search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Clear search query
  void clearSearchQuery() {
    _searchQuery = '';
    notifyListeners();
  }
}
