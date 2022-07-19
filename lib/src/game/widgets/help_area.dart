import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../game/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import '../../state/bloc/sound/sound_model.dart';
import '../../theme/main_theme.dart';
import '../../ui/helper.dart';
import '../../ui/widgets.dart';

class HelpArea extends StatefulWidget {
  const HelpArea({
    Key? key,
    required this.win,
    required this.finished,
  }) : super(key: key);

  final bool win;
  final bool finished;

  @override
  State<HelpArea> createState() => _HelpAreaState();
}

class _HelpAreaState extends State<HelpArea> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpMenuBloc, HelpMenuState>(
      builder: (context, helpMenuState) {
        return BlocBuilder<GameBloc, GameState>(
          builder: (context, gameState) {
            bool open = helpMenuState.open || widget.finished;
            bool finised = gameFinished(gameState);

            return Positioned(
              bottom: 20,
              left: 10,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      margin: const EdgeInsets.only(top: 30),
                      width:
                          open ? MediaQuery.of(context).size.width - 20 : 140,
                      height: open ? 130 : 60,
                      duration: const Duration(milliseconds: 200),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 0,
                        color: open ? white : backgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          side: BorderSide(color: darkColor, width: 2),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: open ? 25.0 : 10.0,
                            right: open ? 15.0 : 10.0,
                            top: open ? 15.0 : 10.0,
                            bottom: 10.0,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: open ? 1 : 100,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: open ? 40 : 40,
                                      height: open ? 50 : 40,
                                      margin:
                                          EdgeInsets.only(left: open ? 10 : 0),
                                      decoration: BoxDecoration(
                                        color: black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Positioned(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ...List.generate(
                                                    2,
                                                    (int index) => Container(
                                                      width: 7,
                                                      height: 7,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(100),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              child: Container(
                                                width: 17,
                                                height: 7,
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                decoration: const BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(100),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    finised
                                        ? const SizedBox.shrink()
                                        : InteractButton(open: open),
                                  ],
                                ),
                              ),
                              const HelpTextArea(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    open
                        ? Positioned(
                            left: 30,
                            top: 0,
                            child: Helper(
                              key: helpMenuState.selectedWidget,
                            ))
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class InteractButton extends StatelessWidget {
  const InteractButton({
    Key? key,
    required this.open,
  }) : super(key: key);

  final bool open;

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
        backgroundColor: accentColor,
        onPressed: () {
          BlocProvider.of<HelpMenuBloc>(context).add(ToggleMenu());
          BlocProvider.of<SoundBloc>(context)
              .add(PlaySound(open ? SoundType.closeHelp : SoundType.openHelp));
          if (open) {
            BlocProvider.of<SoundBloc>(context).add(StopTalkHelper());
          } else {
            BlocProvider.of<SoundBloc>(context).add(StartTalkHelper());
          }
        },
        icon: Icon(
          !open ? Icons.lightbulb_outline_rounded : Icons.close_rounded,
          color: Theme.of(context).iconTheme.color,
          size: 30,
        ));
  }
}

class HelpTextArea extends StatelessWidget {
  const HelpTextArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpMenuBloc, HelpMenuState>(
      builder: (context, helpMenuState) {
        return BlocBuilder<GameBloc, GameState>(
          builder: (context, gameState) {
            final finised = gameFinished(gameState);
            final win = gameWon(gameState);
            final open = helpMenuState.open || finised;

            if (finised) {
              BlocProvider.of<SoundBloc>(context).add(StartTalkHelper());
            }

            return Expanded(
              child: AnimatedContainer(
                height: open ? double.maxFinite : 0,
                width: open ? double.maxFinite : 0,
                duration: const Duration(milliseconds: 200),
                child: open
                    ? Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          AnimatedTextKit(
                              key: finised
                                  ? ValueKey<String>(getFinisedText(win))
                                  : helpMenuState.selectedWidget,
                              isRepeatingAnimation: false,
                              pause: Duration.zero,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  finised
                                      ? getFinisedText(win)
                                      : helpMenuState.message,
                                  speed: const Duration(milliseconds: 40),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                              onFinished: () {
                                BlocProvider.of<SoundBloc>(context)
                                    .add(StopTalkHelper());
                              }),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
        );
      },
    );
  }

  String getFinisedText(bool win) {
    if (win) {
      return "finished_text_win".tr();
    } else {
      return "finished_text_lose".tr();
    }
  }
}
