part of 'sound_bloc.dart';

@immutable
abstract class SoundState {
  final SoundController controller;

  const SoundState(this.controller);
}

class SoundInitial extends SoundState {
  SoundInitial() : super(SoundController.initial());
}

class SoundActive extends SoundState {
  const SoundActive(
    super.controller,
  );
}
