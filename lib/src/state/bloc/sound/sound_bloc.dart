import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  SoundBloc() : super(SoundInitial()) {
    on<ToggleMusicVolume>((event, emit) => emit(_toggleMusicVolume(event)));
    on<ToggleSoundVolume>((event, emit) => emit(_toggleSoundVolume(event)));
    on<SetMusicVolume>((event, emit) => emit(_setMusicVolume(event)));
    on<SetSoundVolume>((event, emit) => emit(_setSoundVolume(event)));
    on<PlaySound>((event, emit) => emit(_playSound(event)));
  }

  SoundActive _toggleMusicVolume(ToggleMusicVolume event) {
    final double volume = state.musicVolume == 0.0 ? 0.5 : 0.0;
    return SoundActive(
      volume,
      state.soundVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
    );
  }

  SoundActive _toggleSoundVolume(ToggleSoundVolume event) {
    final double volume = state.soundVolume == 0.0 ? 0.5 : 0.0;
    return SoundActive(
      state.musicVolume,
      volume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
    );
  }

  SoundActive _setMusicVolume(SetMusicVolume event) {
    return SoundActive(
      event.value.clamp(0.0, 1.0),
      state.soundVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
    );
  }

  SoundActive _setSoundVolume(SetSoundVolume event) {
    return SoundActive(
      state.musicVolume,
      event.value.clamp(0.0, 1.0),
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
    );
  }

  SoundState _playSound(PlaySound event) {
    state.playSound(event.sound);
    var activeAudioPlayer = state.activeAudioPlayer + 1;
    if (activeAudioPlayer >= state.audioPlayers.length) activeAudioPlayer = 0;

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      state.poliphony,
      state.audioPlayers,
      activeAudioPlayer,
    );
  }
}
