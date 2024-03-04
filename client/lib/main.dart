import 'package:client/board/board_grid.dart';
import 'package:client/board/game_page.dart';
import 'package:flutter/material.dart';
import 'package:client/create_join/create_join.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          useMaterial3: true),
      routes: {
        '/': (context) => const CreateAndJoinPage(),
        '/login': (context) => const CreateAndJoinPage(),
        '/board': (context) => const BoardGrid(),
        '/game': (context) => const GamePage(),
      },
    );
  }
}

