class Player {
  final String name;
  int blitzPile = 0; //Cards left in the blitz pile. These will be the negative points
  int dutchPile = 0; //Cards played to the center. These will be the positive points
  int totalScore = 0;
  
  Player({
    required this.name,
  });

}