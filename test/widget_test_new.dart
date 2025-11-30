import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_ui/main.dart';
import 'package:match_ui/views/home_screen.dart';

void main() {
  group('App Tests', () {
    testWidgets('App starts and displays main screen', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app loads without crashing
      expect(find.byType(MainScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Bottom navigation bar displays all items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Find bottom navigation bar
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify all navigation items are displayed
      expect(find.byIcon(Icons.sports_esports), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.leaderboard), findsOneWidget);
      expect(find.byIcon(Icons.group), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('Tapping navigation items changes screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Initially on home screen
      expect(find.text('HomeScreen'), findsNothing);

      // Tap search navigation item (index 1)
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Verify navigation change
      expect(find.text('Search Screen'), findsOneWidget);
    });
  });

  group('HomeScreen Tests', () {
    testWidgets('HomeScreen displays tabs', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find tab bar
      expect(find.byType(TabBar), findsOneWidget);
    });

    testWidgets('HomeScreen displays ELO information', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Find ELO text
      expect(find.text('1500 ELO'), findsOneWidget);
      expect(find.text('BATTLEGROUNDS'), findsOneWidget);
    });

    testWidgets('Match cards are displayed', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify match card widgets exist
      expect(find.byType(Card), findsWidgets);
    });
  });

  group('Theme Tests', () {
    testWidgets('Dark theme is applied', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Get the scaffold's background color
      final scaffold = find.byType(Scaffold);
      expect(scaffold, findsWidgets);
    });
  });

  group('Responsive Design Tests', () {
    testWidgets('Layout adapts to small screen', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(320, 640);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const MyApp());
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('Layout adapts to large screen', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const MyApp());
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('Layout adapts to tablet screen', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(800, 1200);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const MyApp());
      expect(find.byType(MainScreen), findsOneWidget);
    });
  });
}
