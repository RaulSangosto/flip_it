import 'package:flipit/src/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: const Icon(Icons.close_rounded))
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Features:",
            style: cardTextStyle.copyWith(fontSize: 40),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ListView(
                padding: const EdgeInsets.only(top: 10),
                children: [
                  ListTile(
                      title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        color: darkColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Color Palethes",
                        style: cardTextStyle,
                      ),
                    ],
                  )),
                  ListTile(
                      title: Text(
                    "More Card colors",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  )),
                  ListTile(
                      title: Text(
                    "More Backgrounds",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  )),
                  ListTile(
                      title: Text(
                    "New Game Mode",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  )),
                  ListTile(
                      title: Text(
                    "My Gratitude",
                    textAlign: TextAlign.center,
                    style: cardTextStyle,
                  )),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: primaryButtonStyle,
            child: const Text("Upgrade!"),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
