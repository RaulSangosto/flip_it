import 'package:easy_localization/easy_localization.dart';
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
                    "credits_title",
                    style: cardTextStyle.copyWith(fontSize: 30),
                  ).tr(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      children: [
                        const ListSpacer(
                          dense: true,
                        ),
                        CreditItem(
                          category: "credits_code_title".tr(),
                          icon: Icons.code_rounded,
                          name: "Raúl Sánchez",
                        ),
                        CreditItem(
                          category: "credits_design_title".tr(),
                          icon: Icons.design_services_rounded,
                          name: "Raúl Sánchez",
                        ),
                        CreditItem(
                          category: "credits_sound_title".tr(),
                          icon: Icons.volume_up_rounded,
                          name: "credits_sound_author"
                              .tr(args: ["Keney", "Wubitog"]),
                        ),
                        CreditItem(
                          category: "credits_music_title".tr(),
                          icon: Icons.library_music_rounded,
                          name: "Joshuuu",
                        ),
                        CreditSection(
                          header: "TrackList:",
                          items: [
                            CreditItem(
                              category: "credits_song_title_main_menu".tr(),
                              icon: Icons.album_rounded,
                              name: "credits_song_author_main_menu"
                                  .tr(args: ["Light Music", "Joshuuu"]),
                            ),
                            CreditItem(
                              category: "credits_song_title_play".tr(),
                              icon: Icons.album_rounded,
                              name: "credits_song_author_main_menu"
                                  .tr(args: ["Warmth", "Joshuuu"]),
                            ),
                            CreditItem(
                              category: "credits_song_title_win".tr(),
                              icon: Icons.album_rounded,
                              name: "credits_song_author_main_menu".tr(
                                  args: ["You re in the Future", "Joshuuu"]),
                            ),
                            CreditItem(
                              category: "credits_song_title_lose".tr(),
                              icon: Icons.album_rounded,
                              name: "credits_song_author_main_menu"
                                  .tr(args: ["Forever Lost", "Joshuuu"]),
                            ),
                            CreditItem(
                              category: "credits_song_title_menus".tr(),
                              icon: Icons.album_rounded,
                              name: "credits_song_author_main_menu"
                                  .tr(args: ["Groovy Booty", "Joshuuu"]),
                            ),
                            CreditItem(
                              category: "credits_song_title_credits".tr(),
                              icon: Icons.album_rounded,
                              name: "credits_song_author_main_menu"
                                  .tr(args: ["Beach House", "Joshuuu"]),
                            ),
                          ],
                        ),
                        CreditItem(
                          category: "credits_tool_title".tr(),
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
