part of 'game_bloc.dart';

@immutable
abstract class GameState {
  final GameController controller;

  const GameState(this.controller);
}

class GameInitial extends GameState {
  GameInitial() : super(GameController.initial()) {
    controller.cards.shuffle();
  }
}

class GamePlaying extends GameState {
  const GamePlaying(super.controller);
}

class GameFinished extends GameState {
  const GameFinished(super.controller);
}
