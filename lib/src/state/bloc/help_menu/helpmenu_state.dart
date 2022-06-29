part of 'helpmenu_bloc.dart';

@immutable
abstract class HelpMenuState {
  final bool open;
  final int? selectedCard;
  final String message;
  final Key? selectedWidget;

  const HelpMenuState(
    this.open,
    this.selectedCard,
    this.message,
    this.selectedWidget,
  );
}

class HelpMenuInitial extends HelpMenuState {
  const HelpMenuInitial() : super(false, null, "", null);
}

class HelpMenuPlaying extends HelpMenuState {
  const HelpMenuPlaying(
    super.open,
    super.selectedCard,
    super.message,
    super.selectedWidget,
  );
}
