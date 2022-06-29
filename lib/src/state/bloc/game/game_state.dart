part of 'game_bloc.dart';

enum GameStatus { win, lose, playing }

@immutable
abstract class GameState {
  final GameStatus status;
  final List<int> cards;
  final List<CardCollection> collections;
  final List<int> hand;

  const GameState(this.cards, this.collections, this.hand, this.status);
}

final specialCards = [0, -1, -2, -2, -3, -3, -4, -4, -5];

class GameInitial extends GameState {
  GameInitial(int maxCardNumber)
      : super(
          [
            ...[
              for (var i = 2; i < maxCardNumber; i++)
                for (var j = 1; j <= 2; j++) i
            ],
            ...specialCards,
          ],
          [
            CardCollection(Direction.up, maxCardNumber),
            CardCollection(Direction.up, maxCardNumber),
            CardCollection(Direction.down, maxCardNumber),
            CardCollection(Direction.down, maxCardNumber),
          ],
          [],
          GameStatus.playing,
        ) {
    cards.shuffle();
  }
}

class GamePlaying extends GameState {
  const GamePlaying(
    super.cards,
    super.collections,
    super.hamd,
    super.status,
  );
}

class GameFinished extends GameState {
  const GameFinished(
    super.cards,
    super.collections,
    super.hamd,
    super.status,
  );

  bool win() {
    return status == GameStatus.win;
  }
}
