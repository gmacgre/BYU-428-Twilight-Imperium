import 'package:client/board/board_grid.dart';
import 'package:flutter/material.dart';
import 'package:client/create_join/create_join.dart';
import 'package:client/info/info_panel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twilight Imperium',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      routes: {
        '/': (context) => const CreateAndJoinPage(),
        '/login': (context) => const CreateAndJoinPage(),
        '/game': (context) => const InfoPanel(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: CreateAndJoinPage())),
    );
  }
}
