part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class PlaceCardInCollection extends GameEvent {
  final int card;
  final int collectionIndex;

  PlaceCardInCollection(this.card, this.collectionIndex);
}

class DrawCards extends GameEvent {}

class ResetGame extends GameEvent {}
