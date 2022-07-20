part of 'helpmenu_bloc.dart';

@immutable
abstract class HelpMenuEvent {}

class ToggleMenu extends HelpMenuEvent {}

class CloseMenu extends HelpMenuEvent {}

class OpenMenu extends HelpMenuEvent {}

class UnselectWidget extends HelpMenuEvent {}

class SelectCardMenu extends HelpMenuEvent {
  final int card;
  final Key selected;

  SelectCardMenu(this.card, this.selected);
}

class SelectCardCollectionMenu extends HelpMenuEvent {
  final CardCollection card;
  final Key selected;

  SelectCardCollectionMenu(this.card, this.selected);
}

class SelectCardDeckMenu extends HelpMenuEvent {
  final List<int> cards;
  final Key selected;

  SelectCardDeckMenu(this.cards, this.selected);
}

class SetMessage extends HelpMenuEvent {
  final String message;

  SetMessage(this.message);
}
