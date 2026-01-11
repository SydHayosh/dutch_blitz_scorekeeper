import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'player.dart';

class ScorePage extends StatefulWidget {
  final List<Player> players;
  final void Function(int) select;

  const ScorePage({
    super.key,
    required this.players,
    required this.select,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

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
                    onPressed: () {},
                    child: Text('${player.name}: ${player.totalScore}'),
                  ),
                );
              }).toList(),
            ),
            
            //Button sends player to collect points. SizedBox is used to maintain layout.
            SizedBox(
              //width: double.infinity,
              height: 120,//TODO make dynamic
              child: Center(
                //spacing: 10,
                child: ElevatedButton(
                  onPressed: () {
                    widget.select(2);
                  },
                  child: const Text('Round Over'),
                )
              )
            ),
          ]
        )
      )
    );
  }
}