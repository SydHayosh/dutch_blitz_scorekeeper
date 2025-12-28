import 'package:flutter/material.dart';
import 'player.dart';

class StartPage extends StatefulWidget {
  final List<Player> players;
  final void Function(Player) onSave;

  const StartPage({
    super.key,
    required this.players,
    required this.onSave
  });

  @override
  State<StartPage> createState() => _StartPageState();
}



class _StartPageState extends State<StartPage> {

  void _addPlayer() {
    print('new player pressed');

    //final player = Player(name: 'player');
    widget.onSave(Player(name: 'player'));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            //Displays players
            child: ListView.builder(
              itemCount: widget.players.length,
              itemBuilder: (context, index) {
                final player = widget.players[index];
                return ElevatedButton(
                  onPressed: () {}, //Maybe allow for name editing in the future
                  child: Text(player.name),
                );
              },
            ),
          ),
        
          //Button to add up to eight players. Button disapears when eight players are added.
          if (widget.players.length < 8)
            ElevatedButton(
              onPressed: _addPlayer,
              child: const Text('New Player'),
            ),
          
          //Button to start the game.
          if (widget.players.length > 1)
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start'),
            ),
          
        ]
      )
    );
  }
}