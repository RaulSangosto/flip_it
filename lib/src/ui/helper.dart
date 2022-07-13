import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game/utils.dart';
import '../state/bloc/game/game_bloc.dart';
import '../state/bloc/sound/sound_bloc.dart';
import '../theme/main_theme.dart';

class Helper extends StatefulWidget {
  const Helper({Key? key}) : super(key: key);

  @override
  State<Helper> createState() => _HelperState();
}

class _HelperState extends State<Helper> {
  double? top;
  double? left;
  double mouthHeight = 10;
  double mouthWidth = 20;
  bool blink = false;
  bool startedTalking = false;
  double angle = 0;
  late Timer _faceMovementTimer;
  late Timer _blinkTimer;
  Timer? _talkTimer;
  late Timer _bodyRotationTimer;

  double getRandomX() {
    return (Random().nextDouble() * 10 * (Random().nextBool() ? 1.0 : -1.0))
        .clamp(-10, 10);
  }

  double getRandomY() {
    return (Random().nextDouble() * 15).clamp(5, 20);
  }

  @override
  void initState() {
    top = getRandomY();
    left = getRandomX();

    _faceMovementTimer =
        Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      setState(() {
        top = getRandomY();
        left = getRandomX();
      });
    });
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      setState(() {
        if (blink) {
          blink = false;
        } else {
          if (Random().nextInt(50) < 2) {
            blink = true;
          }
        }
      });
    });
    _bodyRotationTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        final dir = Random().nextBool() ? 1 : -1;
        angle = Random().nextDouble() * 0.02 * dir;
      });
    });
    super.initState();
  }

  void initTalking() {
    setState(() {
      startedTalking = true;
      _talkTimer = Timer.periodic(const Duration(milliseconds: 6), (timer) {
        mouthWidth = (Random().nextDouble() * 20).clamp(5, 20);
        mouthHeight = (Random().nextDouble() * 30).clamp(5, 30);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _faceMovementTimer.cancel();
    _blinkTimer.cancel();
    _talkTimer?.cancel();
    _bodyRotationTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundState>(
      builder: (context, state) {
        double width = MediaQuery.of(context).size.width / 5.5;
        bool isTalking = state.controller.helperAudioPlayer.state == PlayerState.playing;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Add Your Code here.
          if (isTalking && !startedTalking) {
            initTalking();
          } else if (!isTalking && startedTalking) {
            setState(() {
              startedTalking = false;
              _talkTimer?.cancel();
              mouthHeight = 10;
              mouthWidth = 20;
            });
          }
        });

        return AnimatedRotation(
          duration: const Duration(seconds: 2),
          turns: angle,
          child: Card(
            elevation: 0,
            color: darkColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
                bottom: Radius.circular(60),
              ),
              side: BorderSide(color: white, width: 5),
            ),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                  width: width,
                  child: const AspectRatio(
                    aspectRatio: 7 / 10,
                  ),
                ),
                HelperFace(
                  top: top,
                  left: left,
                  width: width,
                  blink: blink,
                  mouthWidth: mouthWidth,
                  mouthHeight: mouthHeight,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HelperFace extends StatelessWidget {
  const HelperFace({
    Key? key,
    required this.top,
    required this.left,
    required this.width,
    required this.blink,
    required this.mouthWidth,
    required this.mouthHeight,
  }) : super(key: key);

  final double? top;
  final double? left;
  final double width;
  final bool blink;
  final double mouthWidth;
  final double mouthHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: top,
      left: left,
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, gameState) {
              final lose = gameFinished(gameState) && !gameWon(gameState);
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HelperEye(blink: blink, lose: lose, width: (width - 30) / 4),
                  HelperMouth(
                      width: mouthWidth.clamp(0, (width - 30) / 2),
                      height: mouthHeight,
                      lose: lose),
                  HelperEye(blink: blink, lose: lose, width: (width - 30) / 4),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HelperMouth extends StatelessWidget {
  const HelperMouth({
    Key? key,
    required this.width,
    required this.height,
    required this.lose,
  }) : super(key: key);

  final double width;
  final double height;
  final bool lose;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(lose ? 100 : 0),
          bottom: Radius.circular(lose ? 0 : 100),
        ),
      ),
      duration: const Duration(milliseconds: 5),
    );
  }
}

class HelperEye extends StatelessWidget {
  const HelperEye({
    Key? key,
    this.blink = false,
    required this.lose,
    required this.width,
  }) : super(key: key);

  final bool blink;
  final bool lose;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: blink ? 2 : width,
      width: width,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      duration: const Duration(milliseconds: 20),
    );
  }
}
