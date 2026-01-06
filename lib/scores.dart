import 'package:flutter/material.dart';
import 'player.dart';

enum ScoreView {blitz, dutch, total}

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
  ScoreView _scoreView = ScoreView.total;

  void _roundEnd() {
    setState(() {
      roundOver = true;
      _scoreView = ScoreView.blitz;
    });
    //TODO updates round and switches points
  }

  void _calcScore() {
    setState(() {
      roundOver = false;
      _scoreView = ScoreView.total;
    });
  }

  void _blitzCards() {
    setState(() {
      _scoreView = ScoreView.blitz;
    });
  }

  void _dutchCards() {
    setState(() {
      _scoreView = ScoreView.dutch;
    });
  }

  int _getDisplayNumber(Player player) {
    switch (_scoreView) {
      case ScoreView.blitz:
        return player.blitzPile;
      case ScoreView.dutch:
        return player.dutchPile;
      case ScoreView.total:
        return player.totalScore;
    }
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
                    child: Text('${player.name}: ${_getDisplayNumber(player)}'),
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
                      onPressed: _blitzCards,
                      child: const Text('Blitz Cards'),
                    ),
                  
                    ElevatedButton(
                      onPressed: _dutchCards,
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