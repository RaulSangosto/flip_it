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
                    CreditItem(
                      category: "Code",
                      icon: Icons.code_off_rounded,
                      name: "Raúl Sánchez",
                    ),
                    CreditItem(
                      category: "Design",
                      icon: Icons.design_services_rounded,
                      name: "Raúl Sánchez",
                    ),
                    CreditItem(
                      category: "Sound Effects",
                      icon: Icons.music_note_rounded,
                      name: "Keney",
                    ),
                    CreditItem(
                      category: "Music",
                      icon: Icons.library_music_rounded,
                      name: "Raúl Sánchez",
                    ),
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
