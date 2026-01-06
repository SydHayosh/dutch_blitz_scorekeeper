import 'package:dutch_blitz/scores.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart'; //Needed to enable debugPaintSizeEnabled
import 'start.dart';
import 'player.dart';

void main() {
  //debugPaintSizeEnabled = true; //Shows widget outlins and padding. Restart when turning on. Reloading alone does not work.
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;
  //List<Widget> pages = [StartPage(onSave: _newPlayer,)];
  
  final List<Player> _players = [];

  void _select(int i) => setState(() => _index = i);

  void _newPlayer(Player p){
    setState(() {
      _players.add(p);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      //starting screen where the user adds players
      StartPage(
        players: _players,
        onSave: _newPlayer,
        select: _select,
      ),
      ScorePage(
        players: _players
      ),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: pages)
    );
  }
}