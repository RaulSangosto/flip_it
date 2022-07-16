import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/main_theme.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Text(
                    "Credits",
                    style: cardTextStyle.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      children: const [
                        ListSpacer(
                          dense: true,
                        ),
                        CreditItem(
                          category: "Code",
                          icon: Icons.code_rounded,
                          name: "Raúl Sánchez",
                        ),
                        CreditItem(
                          category: "Design",
                          icon: Icons.design_services_rounded,
                          name: "Raúl Sánchez",
                        ),
                        CreditItem(
                          category: "Sound Effects",
                          icon: Icons.volume_up_rounded,
                          name: "Assets by Keney and wubitog",
                        ),
                        CreditItem(
                          category: "Music",
                          icon: Icons.library_music_rounded,
                          name: "Joshuuu",
                        ),
                        CreditSection(
                          header: "TrackList:",
                          items: [
                            CreditItem(
                              category: "Main Menu Song",
                              icon: Icons.album_rounded,
                              name: "Light Music by joshuuu",
                            ),
                            CreditItem(
                              category: "Play Song",
                              icon: Icons.album_rounded,
                              name: "Warmth by joshuuu",
                            ),
                            CreditItem(
                              category: "Win Song",
                              icon: Icons.album_rounded,
                              name: "You re in the Future by joshuuu",
                            ),
                            CreditItem(
                              category: "Lose Song",
                              icon: Icons.album_rounded,
                              name: "Forever Lost by joshuuu",
                            ),
                            CreditItem(
                              category: "Menus Song",
                              icon: Icons.album_rounded,
                              name: "Groovy Booty by joshuuu",
                            ),
                            CreditItem(
                              category: "Credits Song",
                              icon: Icons.album_rounded,
                              name: "Beach House by joshuuu",
                            ),
                          ],
                        ),
                        CreditItem(
                          category: "Made with",
                          icon: Icons.flutter_dash_rounded,
                          name: "Flutter",
                        ),
                        ListSpacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    child: const Text("Return"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListSpacer extends StatelessWidget {
  const ListSpacer({
    Key? key,
    this.dense = false,
  }) : super(key: key);

  final bool dense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense,
    );
  }
}

class CreditSection extends StatelessWidget {
  const CreditSection({
    Key? key,
    required this.header,
    required this.items,
  }) : super(key: key);

  final String header;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      contentPadding: const EdgeInsets.only(top: 20, left: 10, bottom: 20),
      title: Text(
        header,
        style: cardTextStyle.copyWith(fontSize: 25),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ),
    );
  }
}

class CreditItem extends StatelessWidget {
  const CreditItem({
    Key? key,
    required this.category,
    required this.icon,
    required this.name,
  }) : super(key: key);

  final String category;
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        category,
        style: cardTextStyle,
      ),
      subtitle: Text(
        name,
        style: bodyTextStyle,
      ),
      trailing: Icon(
        icon,
        color: darkColor,
      ),
    );
  }
}
