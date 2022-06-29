import 'package:crossingwords/src/ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              onPressed: () =>
                  BlocProvider.of<GameBloc>(context).add(ResetGame()),
              child: const Text("Reset"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(context).add(ResetGame());
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text("Exit"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/options'),
              child: const Text("Options"),
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
    return const SizedBox.expand(
      child: IgnorePointer(
        child: Confetti(
          isStopped: false,
        ),
      ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Text(
            "Settings",
            style: deckTextStyle,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Scaffold.of(context).closeEndDrawer();
              Navigator.pushNamed(context, "/options");
            },
            style: secondaryButton,
            child: const Text("Settings"),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const RestartGameDialog(),
              ).then((value) => Scaffold.of(context).closeEndDrawer());
            },
            style: secondaryButton,
            child: const Text("Restart"),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Scaffold.of(context).closeEndDrawer();
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            style: secondaryButton,
            child: const Text("Exit"),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              Scaffold.of(context).closeEndDrawer();
            },
            style: secondaryButton,
            child: const Text("Resume"),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
