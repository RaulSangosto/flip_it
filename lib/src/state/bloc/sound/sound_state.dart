part of 'sound_bloc.dart';

@immutable
abstract class SoundState {
  final SoundController controller;

  const SoundState(this.controller);
}

class SoundInitial extends SoundState {
  SoundInitial()
      : super(SoundController(
          .5,
          .5,
          .5,
          2,
          0,
          AudioPlayer(),
          AudioPlayer(),
          List.generate(2, (index) => AudioPlayer()),
        ));
}

class SoundActive extends SoundState {
  const SoundActive(
    super.controller,
  );
}
