import 'package:client/board/board_grid.dart';
import 'package:client/board/game_page.dart';
import 'package:flutter/material.dart';
import 'package:client/create_join/create_join.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/data/strings.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber.shade300),
          ),
        ),
      ),
      routes: {
        '/': (context) => const GamePage(),
        '/login': (context) => const CreateAndJoinPage(),
        '/board': (context) => const BoardGrid(),
        '/game': (context) => const GamePage(),
      },
    );
  }
}
