import '../state/bloc/game/game_bloc.dart';

bool gameFinished(GameState state) {
  return state is GameFinished;
}

bool gameWon(GameState state) {
  return state is GameFinished && state.win();
}
