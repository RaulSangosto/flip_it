import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../state/bloc/sound/sound_bloc.dart';
import '../../theme/main_theme.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Settings",
                        style: deckTextStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const VolumeControls(),
                  const Spacer(
                    flex: 2,
                  ),
                  ElevatedButton(
                    style: secondaryButton,
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text("Back"),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VolumeControls extends StatelessWidget {
  const VolumeControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderItem(
              text: "Music",
              textColor: white,
              onChanged: (double value) {
                BlocProvider.of<SoundBloc>(context).add(SetMusicVolume(value));
              },
              value: state.controller.musicVolume,
              icon: IconButton(
                onPressed: () {
                  BlocProvider.of<SoundBloc>(context).add(ToggleMusicVolume());
                },
                icon: Icon(
                    size: 35,
                    color: white,
                    state.controller.musicMute()
                        ? Icons.music_off_rounded
                        : Icons.music_note_rounded),
              ),
            ),
            SliderItem(
              text: "Sound",
              textColor: white,
              onChanged: (double value) {
                BlocProvider.of<SoundBloc>(context).add(SetSoundVolume(value));
              },
              value: state.controller.soundVolume,
              icon: IconButton(
                onPressed: () {
                  BlocProvider.of<SoundBloc>(context).add(ToggleSoundVolume());
                },
                icon: Icon(
                    size: 35,
                    color: white,
                    state.controller.soundMute()
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded),
              ),
            ),
            SliderItem(
              text: "Dialog",
              textColor: white,
              onChanged: (double value) {
                BlocProvider.of<SoundBloc>(context).add(SetHelperVolume(value));
              },
              value: state.controller.helperVolume,
              icon: IconButton(
                onPressed: () {
                  BlocProvider.of<SoundBloc>(context).add(ToggleHelperVolume());
                },
                icon: Icon(
                    size: 35,
                    color: white,
                    state.controller.helperMute()
                        ? Icons.voice_over_off_rounded
                        : Icons.record_voice_over_rounded),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text("Credits",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: white))),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed("credits");
                  },
                  icon: const Icon(
                    Icons.badge_rounded,
                    color: white,
                    size: 35,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class SliderItem extends StatelessWidget {
  const SliderItem({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.text,
    required this.icon,
    this.textColor = darkColor,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Widget icon;
  final double value;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: textColor),
              ),
              Slider(value: value, onChanged: onChanged),
            ],
          ),
        ),
        Center(
          child: icon,
        )
      ],
    );
  }
}
