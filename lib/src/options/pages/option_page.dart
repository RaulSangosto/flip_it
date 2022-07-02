import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/bloc/sound/sound_bloc.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Options"),
                ],
              ),
              const Spacer(),
              const VolumeControls(),
              const Spacer(
                flex: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              ),
              const Spacer(),
            ],
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
            const Text("Music"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Slider(
                        value: state.musicVolume,
                        onChanged: (double value) {
                          BlocProvider.of<SoundBloc>(context)
                              .add(SetMusicVolume(value));
                        })),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<SoundBloc>(context)
                        .add(ToggleMusicVolume());
                  },
                  icon: Icon(state.musicMute()
                      ? Icons.music_off_rounded
                      : Icons.music_note_rounded),
                )
              ],
            ),
            const Text("Sound"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Slider(
                        value: state.soundVolume,
                        onChanged: (double value) {
                          BlocProvider.of<SoundBloc>(context)
                              .add(SetSoundVolume(value));
                        })),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<SoundBloc>(context)
                        .add(ToggleSoundVolume());
                  },
                  icon: Icon(state.soundMute()
                      ? Icons.volume_off_rounded
                      : Icons.volume_up_rounded),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: Text("Credits")),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.badge_rounded),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
