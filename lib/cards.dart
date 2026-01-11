import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'player.dart';

enum CardType {blitz, dutch}

class CardsPage extends StatefulWidget {
  final List<Player> players;
  final void Function(int) select;

  const CardsPage({
    super.key,
    required this.players,
    required this.select,
  });

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  int round = 0;
  CardType _cardType = CardType.blitz;

  void _calcScore() {
    for(final player in widget.players){
      player.totalScore += player.dutchPile - (2 * player.blitzPile);
      player.dutchPile = 0;
      player.blitzPile = 0;
    }

    _cardType = CardType.blitz;
    widget.select(1);
  }

  //Function changes state to accept blitz points
  void _blitzCards() {
    setState(() {
      _cardType = CardType.blitz;
    });
  }

  //Function changes state to accept dutch points
  void _dutchCards() {
    setState(() {
      _cardType = CardType.dutch;
    });
  }

  int _getDisplayNumber(Player player) {
    switch (_cardType) {
      case CardType.blitz:
        return player.blitzPile;
      case CardType.dutch:
        return player.dutchPile;
    }
  }

  String _getDisplayKind() {
    switch (_cardType) {
      case CardType.blitz:
        return 'Cards in blitz pile';
      case CardType.dutch:
        return 'Cards in dutch pile';
    }
  }

  void _updateScore(Player player, int cards) {
    setState(() {
      switch (_cardType) {
        case CardType.blitz:
          player.blitzPile = cards;
          break;
        case CardType.dutch:
          player.dutchPile = cards;
          break;
      }
    });
  }

  void _getScore(Player player) {
    
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Add Player'),
          content: TextField(
            controller: controller,
            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _getDisplayKind(),
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
                final cards = int.tryParse(controller.text.trim());
                if (cards != null) {
                  _updateScore(player, cards);
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
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: widget.players.map((player) {
                return SizedBox(
                  width: 220,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () => _getScore(player),
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
                  
                ],
              )
            ),
          ]
        )
      )
    );
  }
}