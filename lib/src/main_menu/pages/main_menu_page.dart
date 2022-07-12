import '../../ui/logo.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/background.dart';

class MainMenuPage extends StatelessWidget {
  MainMenuPage({Key? key}) : super(key: key);

  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgrounCirclesPainter(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed('options');
              },
              icon: const Icon(Icons.settings))
        ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LogoAnimated(
                  key: ValueKey("logo"),
                ),
                const Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('play');
                  },
                  child: const Text("Play"),
                ),
                const Spacer(),
                const Text("Created by Raúl"),
                const Text("Sound Effects by Kenney"),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
