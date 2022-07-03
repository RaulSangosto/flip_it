import 'package:crossingwords/src/state/bloc/game/model/card_collection.dart';
import 'package:crossingwords/src/state/bloc/sound/sound_bloc.dart';
import 'package:crossingwords/src/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../ui/widgets.dart';
import '../widgets/card_group.dart';
import '../widgets/deck.dart';
import '../widgets/hand_cards.dart';
import '../widgets/menus.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finised = false;
    var win = false;
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, gameState) {
        if ((gameState is GameInitial || gameState is GamePlaying) &&
            gameState.cards.isNotEmpty) {
          finised = false;
          win = false;
          if (gameState.hand.length < 8) {
            BlocProvider.of<GameBloc>(context).add(DrawCards());
          }
        } else if (gameState is GameFinished) {
          finised = true;
          win = gameState.win();
          if (win) {
            BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.win));
          } else {
            BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.lose));
          }
        }
        return Scaffold(
          endDrawer: const DrawerMenu(),
          body: BlocBuilder<HelpMenuBloc, HelpMenuState>(
            builder: (context, helpMenuState) {
              return Stack(
                children: [
                  Opacity(
                    opacity: helpMenuState.open ? .8 : 0,
                    child: Container(
                      color: darkColor,
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
                  const HelpArea(),
                  finised ? _getFinishMenu(win) : const SizedBox.shrink(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class HelpArea extends StatefulWidget {
  const HelpArea({
    Key? key,
  }) : super(key: key);

  @override
  State<HelpArea> createState() => _HelpAreaState();
}

class _HelpAreaState extends State<HelpArea> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpMenuBloc, HelpMenuState>(
      builder: (context, helpMenuState) {
        return Positioned(
          bottom: 20,
          left: 10,
          child: AnimatedContainer(
            width: helpMenuState.open
                ? MediaQuery.of(context).size.width - 20
                : 140,
            height: helpMenuState.open ? 150 : 60,
            duration: const Duration(milliseconds: 200),
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              color: helpMenuState.open ? white : backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                side: BorderSide(color: darkColor, width: 2),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Padding(
                padding: EdgeInsets.all(helpMenuState.open ? 15.0 : 10.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: helpMenuState.open ? 1 : 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: helpMenuState.open ? 80 : 40,
                            height: helpMenuState.open ? 50 : 40,
                            decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          CircleIconButton(
                              backgroundColor: accentColor,
                              onPressed: () =>
                                  BlocProvider.of<HelpMenuBloc>(context)
                                      .add(ToggleMenu()),
                              icon: Icon(
                                !helpMenuState.open
                                    ? Icons.lightbulb_outline_rounded
                                    : Icons.close_rounded,
                                color: Theme.of(context).iconTheme.color,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: AnimatedContainer(
                        height: helpMenuState.open ? double.maxFinite : 0,
                        width: helpMenuState.open ? double.maxFinite : 0,
                        duration: const Duration(milliseconds: 200),
                        child: helpMenuState.open
                            ? Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    helpMenuState.message,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
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
