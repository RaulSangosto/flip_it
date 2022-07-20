import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../game/widgets/card_group.dart';
import '../../../game/widgets/game_card.dart';
import '../game/model/card_collection.dart';

part 'helpmenu_event.dart';
part 'helpmenu_state.dart';

class HelpMenuBloc extends Bloc<HelpMenuEvent, HelpMenuState> {
  HelpMenuBloc() : super(const HelpMenuInitial()) {
    on<ToggleMenu>((event, emit) => emit(_toggleMenu(event)));
    on<CloseMenu>((event, emit) => emit(_closeMenu(event)));
    on<OpenMenu>((event, emit) => emit(_openMenu(event)));
    on<UnselectWidget>((event, emit) => emit(_unselectWidget(event)));
    on<SelectCardMenu>((event, emit) => emit(_selectCardMenu(event)));
    on<SelectCardCollectionMenu>(
        (event, emit) => emit(_selectCardGroupMenu(event)));
    on<SelectCardDeckMenu>((event, emit) => emit(_selectCardDeckMenu(event)));
    on<SetMessage>((event, emit) => emit(_setMessage(event)));
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
    var message = state.message;
    if (open && message != _getCloseMessage()) {
      return HelpMenuPlaying(open, null, message, null);
    }
    message = open ? _getOpenMessage() : _getCloseMessage();
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
    return "helper_open_message".tr();
  }

  String _getCloseMessage() {
    return "helper_close_message".tr();
  }

  String _getMessageDeck(List<int> cards) {
    return "helper_deck_message".tr(args: [cards.length.toString()]);
  }

  HelpMenuState _setMessage(SetMessage event) {
    return HelpMenuPlaying(
        state.open, null, event.message, ValueKey(event.message));
  }

  HelpMenuState _openMenu(OpenMenu event) {
    return HelpMenuPlaying(true, null, state.message, state.selectedWidget);
  }

  HelpMenuState _closeMenu(CloseMenu event) {
    return HelpMenuPlaying(false, null, state.message, state.selectedWidget);
  }
}
