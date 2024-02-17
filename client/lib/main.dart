import 'package:client/board/board_grid.dart';
import 'package:client/board/board_space.dart';
import 'package:flutter/material.dart';
import 'package:client/info/info_panel.dart';

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
      home: const MyHomePage(title: 'Player Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          const Expanded(
            child: Center(
              child: InfoPanel(),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.all(20.0),
            width: screenWidth * 0.7,
            color: const Color.fromARGB(255, 0, 0, 20),
            child: InteractiveViewer(
              child: const BoardGrid(),
            ),
          ),
        ],
      )),
    );
  }
}

