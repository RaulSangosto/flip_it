import 'dart:math';

import 'package:flipit/src/state/bloc/sound/sound_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/sound/sound_model.dart';
import '../../theme/main_theme.dart';
import 'confetti.dart';

void _goSettings(BuildContext context) {
  GoRouter.of(context).pushNamed('options');
  BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.close));
}

void _goRetry(BuildContext context) {
  BlocProvider.of<GameBloc>(context).add(ResetGame());
  BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.closeHelp));
}

void _goMainMenu(BuildContext context) {
  BlocProvider.of<GameBloc>(context).add(ResetGame());
  BlocProvider.of<SoundBloc>(context).add(PlaySound(SoundType.logoOpen));
  GoRouter.of(context).goNamed('main menu');
}

class LoseMenu extends StatelessWidget {
  const LoseMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: darkColor.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 10,
            ),
            ElevatedButton(
              onPressed: () => _goSettings(context),
              child: const Text("Settings"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _goMainMenu(context),
              child: const Text("Go To Menu"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _goRetry(context),
              child: const Text("Play Again"),
            ),
            const Spacer(
              flex: 7,
            ),
          ],
        ),
      ),
    );
  }
}

class WinMenu extends StatelessWidget {
  const WinMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: darkColor.withOpacity(.6),
        ),
        const SizedBox.expand(
          child: IgnorePointer(
            child: Confetti(
              isStopped: false,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 10,
              ),
              ElevatedButton(
                style: secondaryButton,
                onPressed: () => _goSettings(context),
                child: const Text("Settings"),
              ),
              const Spacer(),
              ElevatedButton(
                style: secondaryButton,
                onPressed: () => _goMainMenu(context),
                child: const Text("Go to Menu"),
              ),
              const Spacer(),
              ElevatedButton(
                style: secondaryButton,
                onPressed: () => _goRetry(context),
                child: const Text("Play Again"),
              ),
              const Spacer(
                flex: 7,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RestartGameDialog extends StatelessWidget {
  const RestartGameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Restart Game?"),
      content: const Text("Are you sure you want to remove your progress?"),
      actions: [
        TextButton(
            onPressed: () => GoRouter.of(context).pop(),
            child: const Text("No")),
        TextButton(
            onPressed: () {
              BlocProvider.of<GameBloc>(context).add(ResetGame());
              GoRouter.of(context).pop();
            },
            child: const Text("Yes"))
      ],
    );
  }
}

class DrawerMenu extends StatelessWidget {
  DrawerMenu({
    Key? key,
    this.onRestart,
  }) : super(key: key);

  Function(BuildContext)? onRestart;

  void _onRestartOpenDialog(context) {
    showDialog(
      context: context,
      builder: (_) => const RestartGameDialog(),
    ).then((value) => Scaffold.of(context).closeEndDrawer());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: min(MediaQuery.of(context).size.width - 60, 800),
      backgroundColor: darkColor,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "Options",
                  style: deckTextStyle,
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Scaffold.of(context).closeEndDrawer();
                  GoRouter.of(context).pushNamed('options');
                },
                style: secondaryButton,
                child: const Text("Settings"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () => onRestart ?? _onRestartOpenDialog(context),
                style: secondaryButton,
                child: const Text("Restart"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Scaffold.of(context).closeEndDrawer();
                  GoRouter.of(context).goNamed('main menu');
                },
                style: secondaryButton,
                child: const Text("Exit"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Scaffold.of(context).closeEndDrawer();
                },
                style: secondaryButton,
                child: const Text("Resume"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
