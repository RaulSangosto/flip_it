import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import 'model/card_collection.dart';
import 'model/game_model.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> with HydratedMixin {
  static const int interchangeCard = -5;

  GameBloc() : super(GameInitial()) {
    on<PlaceCardInCollection>(
        (event, emit) => emit(_placeCardInCollection(event)));
    on<DrawCards>((event, emit) => emit(_drawCards(event)));
    on<ResetGame>((event, emit) => emit(_resetGame(event)));
    on<ChangeMaxCardNumber>((event, emit) => emit(_changeMaxCardNumber(event)));
    on<ChangeDecksNumber>((event, emit) => emit(_changeDecksNumber(event)));
    on<ChangeHandSize>((event, emit) => emit(_changeHandSize(event)));
  }

  GameState _placeCardInCollection(PlaceCardInCollection event) {
    var collections = state.controller.collections;
    var collection = collections[event.collectionIndex];
    var hand = state.controller.hand;
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
      return GamePlaying(state.controller.copyWith(
        status: status,
        collections: collections,
        hand: hand,
      ));
    } else {
      return GameFinished(state.controller.copyWith(
        status: status,
        collections: collections,
        hand: hand,
      ));
    }
  }

  GameState _drawCards(DrawCards event) {
    var cards = state.controller.cards;
    var hand = state.controller.hand;
    var drawCards =
        cards.take(state.controller.handSize - hand.length).toList();
    cards.removeRange(0, drawCards.length);
    hand.addAll(drawCards);
    final status = _getGameStatus();
    if (status == GameStatus.playing) {
      return GamePlaying(state.controller.copyWith(
        status: status,
        cards: cards,
        hand: hand,
      ));
    } else {
      return GameFinished(state.controller.copyWith(
        status: status,
        cards: cards,
        hand: hand,
      ));
    }
  }

  GameState _resetGame(ResetGame event) {
    return GameInitial();
  }

  GameStatus _getGameStatus() {
    final deck = state.controller.cards;
    final hand = state.controller.hand;
    final handNumberCards = hand.where((card) => card > 0).toList();
    if (deck.isEmpty) {
      if (hand.isEmpty || handNumberCards.isEmpty) {
        return GameStatus.win;
      } else if (_canPlaceCards(hand, state.controller.collections)) {
        return GameStatus.playing;
      } else {
        return GameStatus.lose;
      }
    } else if (_canPlaceCards(hand, state.controller.collections) ||
        hand.length < 8) {
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

  @override
  GameState? fromJson(Map<String, dynamic> json) {
    try {
      final controller = GameController.fromJson(json);
      return GamePlaying(controller);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(GameState state) {
    if (state is GamePlaying) {
      return state.controller.toJson();
    }
    return null;
  }

  GameState _changeHandSize(ChangeHandSize event) {
    List<int> options = [4, 6, 8, 10];
    int index = options.indexOf(state.controller.handSize);
    index += 1;
    if (index >= options.length) {
      index = 0;
    }
    final controller = GameController.fromSettings(
      maxCardNumber: state.controller.maxCardNumber,
      decksNumber: state.controller.decksNumber,
      handSize: options[index],
    );
    controller.cards.shuffle();

    return GamePlaying(controller);
  }

  GameState _changeDecksNumber(ChangeDecksNumber event) {
    List<int> options = [1, 2, 3, 4];
    int index = options.indexOf(state.controller.decksNumber);
    index += 1;
    if (index >= options.length) {
      index = 0;
    }
    final controller = GameController.fromSettings(
      maxCardNumber: state.controller.maxCardNumber,
      decksNumber: options[index],
      handSize: state.controller.handSize,
    );
    controller.cards.shuffle();

    return GamePlaying(controller);
  }

  GameState _changeMaxCardNumber(ChangeMaxCardNumber event) {
    List<int> options = [50, 60, 70, 80, 90, 100];
    int index = options.indexOf(state.controller.maxCardNumber);
    index += 1;
    if (index >= options.length) {
      index = 0;
    }
    final controller = GameController.fromSettings(
      maxCardNumber: options[index],
      decksNumber: state.controller.decksNumber,
      handSize: state.controller.handSize,
    );
    controller.cards.shuffle();

    return GamePlaying(controller);
  }
}
