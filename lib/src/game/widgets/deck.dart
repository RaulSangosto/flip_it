import 'package:crossingwords/src/theme/main_theme.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import 'game_card.dart';

class CardDeck extends StatelessWidget {
  CardDeck({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<int> cards;
  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpMenuBloc, HelpMenuState>(
      builder: (context, state) {
        final selected = state.selectedWidget == key;
        final scale = selected ? 1.15 : 1.0;
        var opacity = 1.0;
        Color? border;

        if (state.open && !selected) {
          opacity = .7;
          border = null;
        } else if (state.open && selected) {
          opacity = 1.0;
          border = white;
        }

        return Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                if (state.open && key != null) {
                  if (!selected) {
                    BlocProvider.of<SoundBloc>(context).add(SelectHelperItem());
                  }
                  BlocProvider.of<HelpMenuBloc>(context)
                      .add(SelectCardDeckMenu(cards, key!));
                }
              },
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(scale, scale, scale),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    cards.isNotEmpty
                        ? GameCard(
                            selected: selected,
                            borderColor: border,
                            color: darkColor,
                            content: const Center(),
                          )
                        : Opacity(
                            opacity: 0.2,
                            child: GameCard(
                              selected: selected,
                              color: Theme.of(context).backgroundColor,
                              content: const Center(),
                            ),
                          ),
                    Text(
                      cards.length.toString(),
                      style: deckTextStyle,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
