import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../game/widgets/game_card.dart';
import '../../game/widgets/help_area.dart';
import '../../game/widgets/menus.dart';
import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import '../../state/bloc/sound/sound_model.dart';
import '../../theme/main_theme.dart';
import '../../ui/background.dart';
import '../../ui/widgets.dart';

final List<String> messages = [
  "tutorial_message_0",
  "tutorial_message_1",
  "tutorial_message_2",
  "tutorial_message_3",
  "tutorial_message_4",
  "tutorial_message_5",
  "tutorial_message_6",
  "tutorial_message_7"
];

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int messageIndex = 0;

  void _onRestartMenu(BuildContext context) {
    BlocProvider.of<HelpMenuBloc>(context).add(CloseMenu());
    BlocProvider.of<SoundBloc>(context).add(StopTalkHelper());
    setState(() {
      messageIndex = 0;
    });

    BlocProvider.of<HelpMenuBloc>(context)
        .add(SetMessage(messages[messageIndex].tr()));
    setState(() {
      messageIndex = 1;
    });
    Scaffold.of(context).closeEndDrawer();
  }

  void _increaseIndex() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        messageIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BluredBackground(
      child: Scaffold(
        onEndDrawerChanged: (isOpened) {
          BlocProvider.of<SoundBloc>(context)
              .add(PlaySound(isOpened ? SoundType.open : SoundType.close));
        },
        backgroundColor: Colors.transparent,
        endDrawer: DrawerMenu(
          onRestart: _onRestartMenu,
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Builder(builder: (context) {
                          return CircleIconButton(
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
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            TutorialBody(
              messageIndex: messageIndex,
              increaseIndex: _increaseIndex,
              key: const ValueKey("body"),
            ),
            const HelpArea(
              finished: false,
              win: false,
              closeable: false,
              expanded: true,
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialBody extends StatefulWidget {
  const TutorialBody({
    Key? key,
    required this.messageIndex,
    required this.increaseIndex,
  }) : super(key: key);

  final int messageIndex;
  final VoidCallback increaseIndex;

  @override
  State<TutorialBody> createState() => _TutorialBodyState();
}

class _TutorialBodyState extends State<TutorialBody> {
  @override
  void initState() {
    BlocProvider.of<HelpMenuBloc>(context)
        .add(SetMessage(messages[widget.messageIndex].tr()));
    widget.increaseIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpMenuBloc, HelpMenuState>(
      builder: (context, state) {
        bool tutorialFinish = widget.messageIndex >= messages.length;
        return state.open
            ? Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PlayAreaTutorial(
                          tutorialIndex: widget.messageIndex,
                          key: ValueKey(widget.increaseIndex),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleIconButton(
                                backgroundColor: green,
                                icon: Icon(
                                  tutorialFinish
                                      ? Icons.play_arrow_outlined
                                      : Icons.arrow_forward_rounded,
                                  color: darkColor,
                                  size: 50,
                                ),
                                radius: 40,
                                padding: 10,
                                onPressed: () {
                                  if (!tutorialFinish) {
                                    BlocProvider.of<HelpMenuBloc>(context).add(
                                        SetMessage(messages[widget.messageIndex]
                                            .tr()));
                                    BlocProvider.of<SoundBloc>(context)
                                        .add(StartTalkHelper());
                                    widget.increaseIndex();
                                  } else {
                                    BlocProvider.of<HelpMenuBloc>(context)
                                        .add(ToggleMenu());
                                    BlocProvider.of<SoundBloc>(context)
                                        .add(StopTalkHelper());
                                    GoRouter.of(context).pushNamed("play");
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                !tutorialFinish
                                    ? "tutorial_button_continue"
                                    : "tutorial_button_play",
                                style: cardTextStyle,
                              ).tr(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Positioned(
                left: 10,
                bottom: 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          "tutorial_cta",
                          style: cardTextStyle,
                        ).tr(args: ["Flipy"]),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          SizedBox(
                            width: 65,
                          ),
                          Icon(
                            Icons.arrow_downward_rounded,
                            size: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class PlayAreaTutorial extends StatelessWidget {
  const PlayAreaTutorial({
    Key? key,
    required this.tutorialIndex,
  }) : super(key: key);

  final int tutorialIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, gameState) {
        return Expanded(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: tutorialIndex >= 2 ? 1 : 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  MockedGroupCard(ascendent: true),
                  MockedGroupCard(ascendent: true),
                  MockedGroupCard(ascendent: false),
                  MockedGroupCard(ascendent: false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MockedGroupCard extends StatelessWidget {
  const MockedGroupCard({
    Key? key,
    required this.ascendent,
  }) : super(key: key);

  final bool ascendent;

  @override
  Widget build(BuildContext context) {
    return GameCard(
      color: ascendent ? white : darkColor,
      borderColor: ascendent ? darkColor : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            ascendent ? "1" : "80",
            style: ascendent ? cardTextStyle : deckTextStyle,
          ),
          Icon(
            ascendent ? Icons.expand_less_rounded : Icons.expand_more_rounded,
            size: 36,
            color: ascendent ? darkColor : white,
          )
        ],
      ),
      selected: false,
    );
  }
}
