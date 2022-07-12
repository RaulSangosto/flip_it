import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'model/card_collection.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  static int maxCardNumber = 80;
  static int handSize = 8;
  static const int interchangeCard = -5;

  GameBloc() : super(GameInitial(maxCardNumber)) {
    on<PlaceCardInCollection>(
        (event, emit) => emit(_placeCardInCollection(event)));
    on<DrawCards>((event, emit) => emit(_drawCards(event)));
    on<ResetGame>((event, emit) => emit(_resetGame(event)));
  }

  GameState _placeCardInCollection(PlaceCardInCollection event) {
    var collections = state.collections;
    var collection = collections[event.collectionIndex];
    var hand = state.hand;
    if (event.card == interchangeCard) {
      var last = collection.takeCard();
      var index = hand.indexOf(event.card);
      hand[index] = last;
    } else {
      if (collection.place(event.card)) {
        hand.remove(event.card);
      }
    }

    final status = _getGameStatus();
    if (status == GameStatus.playing) {
      return GamePlaying(state.cards, collections, hand, status);
    } else {
      return GameFinished(state.cards, collections, hand, status);
    }
  }

  GameState _drawCards(DrawCards event) {
    var cards = state.cards;
    var hand = state.hand;
    var drawCards = cards.take(handSize - hand.length).toList();
    cards.removeRange(0, drawCards.length);
    hand.addAll(drawCards);
    final status = _getGameStatus();
    if (status == GameStatus.playing) {
      return GamePlaying(cards, state.collections, hand, status);
    } else {
      return GameFinished(cards, state.collections, hand, status);
    }
  }

  GameState _resetGame(ResetGame event) {
    return GameInitial(maxCardNumber);
  }

  GameStatus _getGameStatus() {
    final deck = state.cards;
    final hand = state.hand;
    final handNumberCards = hand.where((card) => card > 0).toList();
    if (deck.isEmpty) {
      if (hand.isEmpty || handNumberCards.isEmpty) {
        return GameStatus.win;
      } else if (_canPlaceCards(hand, state.collections)) {
        return GameStatus.playing;
      } else {
        return GameStatus.lose;
      }
    } else if (_canPlaceCards(hand, state.collections) || hand.length < 8) {
      return GameStatus.playing;
    } else {
      return GameStatus.lose;
    }
  }

  bool _canPlaceCards(List<int> hand, List<CardCollection> collections) {
    for (var collection in collections) {
      for (var card in hand) {
        if (collection.isValidCardPlace(card)) {
          return true;
        }
      }
    }
    return false;
  }
}
