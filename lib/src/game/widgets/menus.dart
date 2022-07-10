import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../state/bloc/game/game_bloc.dart';
import '../../theme/main_theme.dart';
import 'confetti.dart';

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
              onPressed: () => GoRouter.of(context).pushNamed('options'),
              child: const Text("Settings"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(context).add(ResetGame());
                GoRouter.of(context).goNamed('main menu');
              },
              child: const Text("Go To Menu"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(context).add(ResetGame());
              },
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
                onPressed: () => GoRouter.of(context).pushNamed('options'),
                child: const Text("Settings"),
              ),
              const Spacer(),
              ElevatedButton(
                style: secondaryButton,
                onPressed: () {
                  BlocProvider.of<GameBloc>(context).add(ResetGame());
                  GoRouter.of(context).goNamed('/');
                },
                child: const Text("Go to Menu"),
              ),
              const Spacer(),
              ElevatedButton(
                style: secondaryButton,
                onPressed: () =>
                    BlocProvider.of<GameBloc>(context).add(ResetGame()),
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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No")),
        TextButton(
            onPressed: () {
              BlocProvider.of<GameBloc>(context).add(ResetGame());
              Navigator.of(context).pop();
            },
            child: const Text("Yes"))
      ],
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width - 60,
      backgroundColor: darkColor,
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const RestartGameDialog(),
                ).then((value) => Scaffold.of(context).closeEndDrawer());
              },
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
    );
  }
}
