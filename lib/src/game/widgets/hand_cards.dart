import 'dart:math';

import 'package:crossingwords/src/theme/main_theme.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import 'game_card.dart';

class HandCards extends StatelessWidget {
  const HandCards({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<int> cards;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      children: [
        for (int i = 0; i < cards.length; i++)
          HandCard(
            card: cards[i],
            key: ValueKey(i),
          )
      ],
    );
  }
}

class HandCard extends StatefulWidget {
  const HandCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  final int card;

  @override
  State<HandCard> createState() => _HandCardState();
}

class _HandCardState extends State<HandCard> {
  final controller = FlipCardController();
  bool fliped = false;
  bool reversed = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loopOnce(context));
  }

  Future<void> loopOnce(BuildContext context) async {
    if (fliped) return;
    controller.toggleCard();
    fliped = true;
    reversed = false;
  }

  void _refresh(DraggableDetails? details) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state != null &&
        controller.controller != null &&
        !controller.state!.isFront) {
      controller.toggleCard();
      fliped = true;
    }
    bool isSpecial = widget.card < 0;

    return BlocBuilder<HelpMenuBloc, HelpMenuState>(
      builder: (context, state) {
        final rng = Random();
        final angle = (rng.nextDouble() + 0.1) / 5 * (rng.nextBool() ? 1 : -1);
        final selected = state.selectedWidget == widget.key;
        final scale = selected ? 1.1 : 1.0;
        var opacity = 1.0;
        Color? cardBorder = getBorderCardColor(widget.card);
        Color? border = cardBorder;

        if (state.open && !selected) {
          opacity = .7;
          border = cardBorder;
        } else if (state.open && selected) {
          opacity = 1.0;
          if (cardBorder == null) {
            border = white;
          }
        }

        final Widget front = GameCard(
          selected: selected,
          borderColor: border,
          color: getCardColor(widget.card),
          content: isSpecial
              ? Icon(
                  getIconSpecialCard(widget.card),
                  color: getContentCardColor(widget.card),
                  size: 30,
                )
              : Center(
                  child: Text(
                  widget.card.toString(),
                  style: cardTextStyle.copyWith(
                      color: getContentCardColor(widget.card)),
                )),
        );
        final Widget back = GameCard(
          selected: selected,
          color: darkColor,
          content: const SizedBox(
            width: 81,
            height: 100,
          ),
        );

        return GestureDetector(
          onTap: () {
            if (state.open && widget.key != null) {
              if (!selected) {
                BlocProvider.of<SoundBloc>(context).add(SelectHelperItem());
              }
              BlocProvider.of<HelpMenuBloc>(context)
                  .add(SelectCardMenu(widget.card, widget.key!));
            }
          },
          child: Opacity(
            opacity: opacity,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(scale, scale, scale),
              child: Draggable<int>(
                maxSimultaneousDrags: !state.open ? 1 : 0,
                data: widget.card,
                feedback: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(angle),
                  child: front,
                ),
                childWhenDragging: const SizedBox(
                  width: 81,
                  height: 100,
                ),
                onDragEnd: _refresh,
                child: getDraggableChild(back, front),
              ),
            ),
          ),
        );
      },
    );
  }

  MyFlipCard getDraggableChild(Widget back, Widget front) {
    return MyFlipCard(
      flipOnTouch: false,
      controller: controller,
      back: fliped ? back : front,
      front: fliped ? front : back,
    );
  }
}
