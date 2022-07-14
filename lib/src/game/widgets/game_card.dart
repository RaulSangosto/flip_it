import '../../theme/main_theme.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

Color getCardColor(int card) {
  // final colors = [
  //   backgroundColor,
  //   Colors.lightGreen[400] ?? Colors.lightGreen,
  //   Colors.cyan[200] ?? Colors.cyan,
  //   purple,
  //   Colors.pinkAccent[100] ?? Colors.pink,
  //   Colors.redAccent,
  //   Colors.orange[600] ?? Colors.orange,
  //   Colors.purple[700] ?? Colors.teal,
  //   Colors.blue[800] ?? Colors.blue,
  //   Colors.blueGrey[600] ?? Colors.blueGrey,
  // ];
  final colors2 = [
    backgroundColor,
    green,
    Colors.cyan[200] ?? Colors.cyan,
    Colors.pinkAccent[100] ?? Colors.pink,
    Colors.grey[300] ?? Colors.redAccent,
    purple, //Colors.orange[300] ?? Colors.orange,
    Colors.teal[200] ?? Colors.teal,
    Colors.blueAccent,
    darkColor,
  ];

  final colors3 = [
    backgroundColor,
    green,
    Colors.cyan[200] ?? Colors.cyan,
    Colors.pink[200] ?? Colors.pink,
    grey,
    purple, //Colors.orange[300] ?? Colors.orange,
    Colors.teal[200] ?? Colors.teal,
    Colors.indigo[400] ?? Colors.indigo,
    darkColor,
  ];
  if (card <= 0) return getSpecialCardsColor(card);
  return colors3[(card / 10).floor()];
}

Color? getBorderCardColor(int card) {
  if (card > 0 && card < 10) return textColor;
  // if (card <= 0) return white;
  return null;
}

Color getContentCardColor(int card) {
  if (card > 0 && card < 80) return textColor;
  return white;
}

Color getSpecialCardsColor(int card) {
  final colors = [
    darkColor,
    Colors.amber[400] ?? Colors.amber,
    Colors.green[400] ?? Colors.green,
    Colors.cyan[300] ?? Colors.cyan,
    // Colors.blue,
    Colors.purple[700] ?? Colors.purple,
    Colors.pink[400] ?? Colors.pink,
    // Colors.redAccent,
    // Colors.orange,
    // Colors.brown,
    Colors.blue[800] ?? Colors.blue,
  ];
  return colors[0];
}

IconData getIconSpecialCard(int card) {
  switch (card) {
    case -1:
      // Change direction group cards
      return Icons.shuffle_rounded;
    case -2:
      // Suffle group cards
      return Icons.auto_awesome_motion_rounded;
    case -3:
      // Remove last group card
      return Icons.delete_outline;
    case -4:
      // Reduce/increase 20 group card
      return Icons.vertical_align_center_rounded;
    case -5:
      // Reduce/increase 20 group card
      return Icons.download_rounded;
    default:
      return Icons.question_mark;
  }
}

String getCardDescription(int card) {
  if (card > 0) {
    return "It´s a normal card. The number $card";
  } else {
    switch (card) {
      case 0:
        return "Resets the group to its starting value.";
      case -1:
        return "Changes direction of the group you place it in";
      case -2:
        return "Shuffles the group you place it in.";
      case -3:
        return "Removes the last card in the group you place it in.";
      case -4:
        return "Adds/Subtracs 20 in the oposite direction of group you place it in.";
      default:
        return "";
    }
  }
}

class FlipGameCard extends StatelessWidget {
  const FlipGameCard({
    Key? key,
    this.color,
    this.fliped = false,
    required this.content,
    required this.controller,
    required this.selected,
  }) : super(key: key);
  final Color? color;
  final Widget content;
  final FlipCardController controller;
  final bool fliped;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Widget front = GameCard(
      color: color,
      content: content,
      selected: selected,
    );
    final Widget back = GameCard(
      color: Colors.blueGrey[800],
      selected: selected,
      content: const SizedBox(
        width: 81,
        height: 100,
      ),
    );
    return FlipCard(
      flipOnTouch: false,
      controller: controller,
      direction: FlipDirection.VERTICAL,
      back: fliped ? front : back,
      front: fliped ? back : front,
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    Key? key,
    required this.content,
    this.color,
    required this.selected,
    this.borderColor,
  }) : super(key: key);

  final Widget content;
  final Color? color;
  final Color? borderColor;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 3)
              : BorderSide.none),
      elevation: selected ? 5 : 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 150),
        child: AnimatedContainer(
          width: (MediaQuery.of(context).size.width - 100) / 4,
          padding: const EdgeInsets.all(8.0),
          duration: const Duration(milliseconds: 200),
          child: AspectRatio(
            aspectRatio: 7 / 12,
            child: content,
          ),
        ),
      ),
    );
  }
}

class MyFlipCard extends FlipCard {
  const MyFlipCard({
    super.key,
    required super.front,
    required super.back,
    required super.flipOnTouch,
    required super.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return MyFlipCardState();
  }
}

class MyFlipCardState extends FlipCardState {
  bool disposed = false;

  @override
  void toggleCard() {
    if (disposed) return;
    super.toggleCard();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
