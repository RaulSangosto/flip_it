import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/game/model/card_collection.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import '../../state/bloc/sound/sound_model.dart';
import '../../theme/main_theme.dart';
import '../../ui/background.dart';
import '../../ui/widgets.dart';
import '../utils.dart';
import '../widgets/card_group.dart';
import '../widgets/deck.dart';
import '../widgets/hand_cards.dart';
import '../widgets/help_area.dart';
import '../widgets/menus.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finised = false;
    var win = false;
    return BluredBackground(
      child: Container(
        color: Colors.transparent,
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, gameState) {
            finised = gameFinished(gameState);
            win = gameWon(gameState);
            if (!finised &&
                gameState.cards.isNotEmpty &&
                gameState.hand.length < 8) {
              BlocProvider.of<GameBloc>(context).add(DrawCards());
            } else if (finised && win) {
              BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.win));
              BlocProvider.of<SoundBloc>(context).add(PlaySong(ThemeSongs.win));
            } else if (finised && !win) {
              BlocProvider.of<SoundBloc>(context)
                  .add(PlaySound(SoundType.lose));
              BlocProvider.of<SoundBloc>(context)
                  .add(PlaySong(ThemeSongs.lose));
            }
            return Scaffold(
              onEndDrawerChanged: (isOpened) {
                BlocProvider.of<SoundBloc>(context).add(
                    PlaySound(isOpened ? SoundType.open : SoundType.close));
              },
              backgroundColor: Colors.transparent,
              endDrawer: const DrawerMenu(),
              body: BlocBuilder<HelpMenuBloc, HelpMenuState>(
                builder: (context, helpMenuState) {
                  return Stack(
                    children: [
                      Visibility(
                        visible: helpMenuState.open,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                          child: Container(
                            color: darkColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: TopBar(deck: gameState.cards),
                              ),
                              Expanded(
                                flex: 4,
                                child: PlayCardZone(
                                    collections: gameState.collections),
                              ),
                              Expanded(
                                flex: 6,
                                child: HandCards(
                                  cards: gameState.hand,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      finised ? _getFinishMenu(win) : const SizedBox.shrink(),
                      HelpArea(
                        finished: finised,
                        win: win,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _getFinishMenu(bool win) {
  return win ? const WinMenu() : const LoseMenu();
}

class PlayCardZone extends StatelessWidget {
  const PlayCardZone({
    Key? key,
    required this.collections,
  }) : super(key: key);

  final List<CardCollection>? collections;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: collections != null
            ? [
                for (int i = 0; i < collections!.length; i++)
                  CardGroupCollection(
                    collection: collections![i],
                    index: i,
                    key: ValueKey(i + 100),
                  )
              ]
            : []);
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.deck,
  }) : super(key: key);

  final List<int> deck;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardDeck(
                cards: deck,
                key: ValueKey((deck.isNotEmpty ? deck.last : 0) + 1000),
              ),
              const Spacer(),
              CircleIconButton(
                backgroundColor: accentColor,
                radius: 40,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
