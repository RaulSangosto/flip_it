import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/bloc/sound/sound_bloc.dart';
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
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth >= constraints.maxHeight) {
        return MainMenuPhonePage(key: const Key('main menu'));
      } else {
        return MainMenuPhonePage(key: const Key('main menu'));
      }
    });
  }
}

class MainMenuPhonePage extends StatelessWidget {
  MainMenuPhonePage({Key? key}) : super(key: key);

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
                const Expanded(
                  flex: 3,
                  child: LogoAnimated(
                    key: ValueKey("logo"),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('play');
                  },
                  child: const Text("Play"),
                ),
                const Spacer(),
                const Text("Created by Raúl"),
                BlocBuilder<SoundBloc, SoundState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () => BlocProvider.of<SoundBloc>(context)
                          .add(ToggleMusicVolume()),
                      icon: Icon(state.controller.musicMute()
                          ? Icons.music_off_rounded
                          : Icons.music_note_rounded),
                    );
                  },
                ),
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

class MainMenuDesktopPage extends StatelessWidget {
  MainMenuDesktopPage({Key? key}) : super(key: key);

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoAnimated(
                  key: ValueKey("logo"),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed('play');
                      },
                      child: const Text("Play"),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("Created by Raúl"),
                    BlocBuilder<SoundBloc, SoundState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () => BlocProvider.of<SoundBloc>(context)
                              .add(ToggleMusicVolume()),
                          icon: Icon(state.controller.musicMute()
                              ? Icons.music_off_rounded
                              : Icons.music_note_rounded),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
