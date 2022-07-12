import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/game/model/card_collection.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import '../../theme/main_theme.dart';
import 'game_card.dart';

class CardGroupCollection extends StatefulWidget {
  const CardGroupCollection({
    Key? key,
    required this.collection,
    required this.index,
  }) : super(key: key);

  final CardCollection collection;
  final int index;

  @override
  State<CardGroupCollection> createState() => _CardGroupCollectionState();
}

class _CardGroupCollectionState extends State<CardGroupCollection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _expandAnimation;
  var cardWidth = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _expandAnimation = TweenSequence(
      [
        TweenSequenceItem<double>(
          tween: Tween(begin: 1.0, end: 1.15)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 25.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(1.15),
          weight: 15.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 1.15, end: 0.95)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.95, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 10.0,
        ),
      ],
    ).animate(_controller);

    _expandAnimation?.addListener(() {
      setState(() {
        cardWidth = _expandAnimation?.value ?? 1.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.collection.direction == Direction.up
        ? Icons.expand_less
        : Icons.expand_more;
    return DragTarget<int>(
      builder: (BuildContext context, List<Object?> candidateData,
          List<dynamic> rejectedData) {
        final card = widget.collection.cards.last;
        return BlocBuilder<HelpMenuBloc, HelpMenuState>(
          builder: (context, state) {
            final selected = state.selectedWidget == widget.key;
            final scale = selected ? 0.1 : 0.0;
            var opacity = 1.0;
            Color? cardBorder = getBorderCardColor(card);
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
            return GestureDetector(
              onTap: () {
                if (state.open && widget.key != null) {
                  if (!selected) {
                    BlocProvider.of<SoundBloc>(context).add(SelectHelperItem());
                  }
                  BlocProvider.of<HelpMenuBloc>(context).add(
                      SelectCardCollectionMenu(widget.collection, widget.key!));
                }
              },
              child: Opacity(
                opacity: opacity,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(cardWidth + scale, cardWidth + scale,
                        cardWidth + scale),
                  child: GameCard(
                    selected: selected,
                    color: getCardColor(card),
                    borderColor: border,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          card.toString(),
                          style: cardTextStyle.copyWith(
                              color: getContentCardColor(card)),
                        ),
                        Icon(
                          icon,
                          color: getContentCardColor(card),
                          size: 36,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      onWillAccept: (data) {
        if (data != null && widget.collection.isValidCardPlace(data)) {
          _controller.animateTo(.1);
          return true;
        }

        return false;
      },
      onAccept: (data) {
        if (widget.collection.isSpecialCard(data)) {
          BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.special));
        }
        if (widget.collection.isImproveCard(data)) {
          BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.improve));
        } else {
          BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.place));
        }
        _controller.forward(from: 0.0);
        BlocProvider.of<GameBloc>(context)
            .add(PlaceCardInCollection(data, widget.index));
      },
      onLeave: (data) {
        _controller.animateBack(0);
        // player.play(AssetSource('sounds/playcard.wav'));
      },
    );
  }
}

String getCollectionDescription(CardCollection collection) {
  final direction =
      collection.direction == Direction.up ? "ascendent" : "descendent";
  return "Place your cards here in $direction order.";
}
