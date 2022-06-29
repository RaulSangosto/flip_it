import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class MainMenuPage extends StatelessWidget {
  MainMenuPage({Key? key}) : super(key: key);

  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/options');
            },
            icon: const Icon(Icons.settings))
      ]),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Flip it!",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "A game about time",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/board/play');
              },
              child: const Text("Play"),
            ),
            const Spacer(),
            const Text("Created by Raúl"),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
