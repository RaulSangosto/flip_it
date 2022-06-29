part of 'sound_bloc.dart';

@immutable
abstract class SoundEvent {}

class ToggleMusicVolume extends SoundEvent {}

class SetMusicVolume extends SoundEvent {
  final double value;

  SetMusicVolume(this.value);
}

class ToggleSoundVolume extends SoundEvent {}

class SetSoundVolume extends SoundEvent {
  final double value;

  SetSoundVolume(this.value);
}

class PlaySound extends SoundEvent {
  final SoundType sound;

  PlaySound(this.sound);
}
