import 'package:flutter/material.dart';
import 'player.dart';

class StartPage extends StatefulWidget {
  final List<Player> players;
  final void Function(Player) onSave;
  final void Function(int) select;

  const StartPage({
    super.key,
    required this.players,
    required this.onSave,
    required this.select,
  });

  @override
  State<StartPage> createState() => _StartPageState();
}



class _StartPageState extends State<StartPage> {
  void _addPlayer() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Add Player'),
          content: TextField(
            controller: controller,
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
                final name = controller.text.trim();
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
      
      body: Center(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Displays players
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Wrap( //TODO can propably get rid of the scroll view. Come back and simplify later
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: widget.players.map((player) {
                    return SizedBox(
                      width: 220,
                      height: 40,
                      child: ElevatedButton(
                        onPressed:() {},
                        child: Text(player.name),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          
            //Button to add up to eight players. Button disapears when eight players are added.
            if (widget.players.length < 8)
              ElevatedButton(
                onPressed: _addPlayer,
                child: const Text('New Player'),
              ),

            //Button to start the game. Appears after two players are added
            if (widget.players.length > 1)
              ElevatedButton(
                onPressed: () {
                  widget.select(1);
                },
                child: const Text('Start'),
              ),

          ]
        )
      )
    );
  }
}