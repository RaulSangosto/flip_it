import 'package:easy_localization/easy_localization.dart';
import 'package:flipit/src/app/pages/app_lifecycle/lifeciclestate.dart';
import 'package:flipit/src/theme/main_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import '../../ui/logo.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/background.dart';
import '../../ui/widgets.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends LifecycleState<MainMenuPage> {
  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgrounCirclesPainter(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed('options');
                },
                iconSize: 30,
                icon: const Icon(
                  Icons.settings,
                  color: darkColor,
                ),
              ),
              CircleIconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed('shop');
                },
                radius: 25,
                icon: const Icon(
                  Icons.shopping_bag_rounded,
                  color: white,
                  size: 25,
                ),
                backgroundColor: darkColor,
              ),
            ],
          ),
        ),
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
                  child: const Text("play_button").tr(),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('tutorial');
                  },
                  child: const Text("how_to_play_button").tr(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () =>
                            GoRouter.of(context).pushNamed("credits"),
                        child: const Text("author_name")
                            .tr(args: ["Raúl Sánchez"])),
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
