part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class PlaceCardInCollection extends GameEvent {
  final int card;
  final int collectionIndex;

  PlaceCardInCollection(this.card, this.collectionIndex);
}

class ChangeMaxCardNumber extends GameEvent {}

class ChangeDecksNumber extends GameEvent {}

class ChangeHandSize extends GameEvent {}

class ChangeSpecialCardsAmount extends GameEvent {}

class DrawCards extends GameEvent {}

class ResetGame extends GameEvent {}
