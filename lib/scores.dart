import 'package:flutter/material.dart';
import 'player.dart';

class ScorePage extends StatefulWidget {
  final List<Player> players;
  //final void Function(Player) onSave;

  const ScorePage({
    super.key,
    required this.players,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}



class _ScorePageState extends State<ScorePage> {
  int round = 0;
  bool roundOver = false;

  void _roundEnd() {
    setState(() {
      roundOver = true;
    });
    //TODO updates round and switches points
  }

  void _calcScore() {
    setState(() {
      roundOver = false;
    });
  }
  /*void _addPlayer() {
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
  }*/

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
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: widget.players.map((player) {
                return SizedBox(
                  width: 220,
                  height: 40,
                  child: TextButton(
                    onPressed:() {},
                    child: Text(player.name),
                  ),
                );
              }).toList(),
            ),

            /*
            Buttons to navigate which cards are being scored.
            Inbetween rounds only one button to end the round is avilable.
            When points are ready to enter there are three buttons. Two
            to switch between the blitz and dutch cards and one to start
            the next round. SizedBox is used to maintain layout.
            */
            SizedBox(
              //width: double.infinity,
              height: 120,//TODO make dynamic
              child: Column(
                //spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (roundOver) ...[
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Blitz Cards'),
                    ),
                  
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Dutch Cards'),
                    ),

                    ElevatedButton(
                      onPressed: _calcScore,
                      child: const Text('Done'),
                    )
                  ] else
                    ElevatedButton(
                      onPressed: _roundEnd,
                      child: const Text('Round Over'),
                    )
                ],
              )
            ),
          ]
        )
      )
    );
  }
}