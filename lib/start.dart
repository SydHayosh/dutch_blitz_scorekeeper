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
                  onPressed: () {},
                  child: Text(player.name),
                );
              },
            ),
          ),
        
          ElevatedButton(
            onPressed: _addPlayer,
            child: const Text('New Player'),
          ),
        ]
      )
      
    );
  }
}