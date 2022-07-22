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

class ToggleHelperVolume extends SoundEvent {}

class SetHelperVolume extends SoundEvent {
  final double value;

  SetHelperVolume(this.value);
}

class PlaySound extends SoundEvent {
  final SoundType sound;

  PlaySound(this.sound);
}

class PlaySong extends SoundEvent {
  final ThemeSongs song;

  PlaySong(this.song);
}

class PauseSound extends SoundEvent {}

class ResumeSound extends SoundEvent {}

class StopSong extends SoundEvent {}

class SelectHelperItem extends SoundEvent {}

class StartTalkHelper extends SoundEvent {}

class StopTalkHelper extends SoundEvent {}
