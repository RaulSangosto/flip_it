import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../game/widgets/card_group.dart';
import '../../../game/widgets/game_card.dart';
import '../game/model/card_collection.dart';

part 'helpmenu_event.dart';
part 'helpmenu_state.dart';

class HelpMenuBloc extends Bloc<HelpMenuEvent, HelpMenuState> {
  HelpMenuBloc() : super(const HelpMenuInitial()) {
    on<ToggleMenu>((event, emit) => emit(_toggleMenu(event)));
    on<UnselectWidget>((event, emit) => emit(_unselectWidget(event)));
    on<SelectCardMenu>((event, emit) => emit(_selectCardMenu(event)));
    on<SelectCardCollectionMenu>(
        (event, emit) => emit(_selectCardGroupMenu(event)));
    on<SelectCardDeckMenu>((event, emit) => emit(_selectCardDeckMenu(event)));
  }

  HelpMenuState _selectCardGroupMenu(SelectCardCollectionMenu event) {
    return HelpMenuPlaying(
        true, null, _getMessageCollection(event.card), event.selected);
  }

  HelpMenuState _selectCardMenu(SelectCardMenu event) {
    return HelpMenuPlaying(
        true, event.card, _getMessageCard(event.card), event.selected);
  }

  HelpMenuState _unselectWidget(UnselectWidget event) {
    return HelpMenuPlaying(state.open, null, _getOpenMessage(), null);
  }

  HelpMenuState _toggleMenu(ToggleMenu event) {
    final open = !state.open;
    final message = open ? _getOpenMessage() : _getCloseMessage();
    return HelpMenuPlaying(open, null, message, null);
  }

  HelpMenuState _selectCardDeckMenu(SelectCardDeckMenu event) {
    return HelpMenuPlaying(
        true, null, _getMessageDeck(event.cards), event.selected);
  }

  String _getMessageCollection(CardCollection collection) {
    return getCollectionDescription(collection);
  }

  String _getMessageCard(int card) {
    return getCardDescription(card);
  }

  String _getOpenMessage() {
    return "Wich card do you need help with?";
  }

  String _getCloseMessage() {
    return "Bye!";
  }

  String _getMessageDeck(List<int> cards) {
    return "This is the Deck, there are ${cards.length} cards left.";
  }
}
