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
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Add Player'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Player name ',
              //hintText: 'Player name',
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                final name = _controller.text.trim();
                if (name.isNotEmpty) {
                  widget.onSave(Player(name: name));
                }
                Navigator.pop(context);
              },
              child: const Text('Add')
            ),
          ]
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            //Displays players
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: widget.players.map((player) {
                    return SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:() {},
                        child: Text(player.name),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            /*child: GridView.builder(
              itemCount: widget.players.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 5,
              ),
              itemBuilder: (context, index) {
                final player = widget.players[index];
                return Center(
                  child: SizedBox(
                    width: 300,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {}, //TODO Maybe allow for name editing in the future
                      child: Text(player.name),
                    ),
                  )
                );
                
                
              },
            ),*/
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