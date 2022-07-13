import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  SoundBloc() : super(SoundInitial()) {
    on<ToggleMusicVolume>((event, emit) => emit(_toggleMusicVolume(event)));
    on<ToggleSoundVolume>((event, emit) => emit(_toggleSoundVolume(event)));
    on<ToggleHelperVolume>((event, emit) => emit(_toggleHelperVolume(event)));
    on<SetMusicVolume>((event, emit) => emit(_setMusicVolume(event)));
    on<SetSoundVolume>((event, emit) => emit(_setSoundVolume(event)));
    on<SetHelperVolume>((event, emit) => emit(_setHelperVolume(event)));
    on<PlaySound>((event, emit) => emit(_playSound(event)));
    on<PlaySong>((event, emit) => emit(_playSong(event)));
    on<StopSong>((event, emit) => emit(_stopSong(event)));
    on<SelectHelperItem>((event, emit) => emit(_selectHelperItem()));
    on<StartTalkHelper>((event, emit) => emit(_startTalkHelper()));
    on<StopTalkHelper>((event, emit) => emit(_stopTalkHelper()));
  }

  SoundActive _toggleMusicVolume(ToggleMusicVolume event) {
    final double volume = state.musicVolume == 0.0 ? 0.5 : 0.0;
    state.setMusicVolume(volume);

    return SoundActive(
      volume,
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundActive _toggleSoundVolume(ToggleSoundVolume event) {
    final double volume = state.soundVolume == 0.0 ? 0.5 : 0.0;
    state.setSoundVolume(volume);

    return SoundActive(
      state.musicVolume,
      volume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundActive _toggleHelperVolume(ToggleHelperVolume event) {
    final double volume = state.helperVolume == 0.0 ? 0.5 : 0.0;
    state.setHelperVolume(volume);

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      volume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundActive _setMusicVolume(SetMusicVolume event) {
    state.setMusicVolume(event.value);

    return SoundActive(
      event.value.clamp(0.0, 1.0),
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundActive _setSoundVolume(SetSoundVolume event) {
    state.setSoundVolume(event.value);

    return SoundActive(
      state.musicVolume,
      event.value.clamp(0.0, 1.0),
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundActive _setHelperVolume(SetHelperVolume event) {
    state.setHelperVolume(event.value);

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      event.value.clamp(0.0, 1.0),
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundState _playSound(PlaySound event) {
    state.playSound(event.sound);
    var activeAudioPlayer = state.activeAudioPlayer + 1;
    if (activeAudioPlayer >= state.audioPlayers.length) activeAudioPlayer = 0;

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundState _playSong(PlaySong event) {
    state.stopSong();
    state.playSong(event.song);

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundState _stopSong(StopSong event) {
    state.stopSong();

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundState _startTalkHelper() {
    state.startTalkHelper();

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundState _stopTalkHelper() {
    state.stopTalkHelper();

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      state.activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }

  SoundState _selectHelperItem() {
    state.startTalkHelper();
    state.playSound(SoundType.select);
    var activeAudioPlayer = state.activeAudioPlayer + 1;
    if (activeAudioPlayer >= state.audioPlayers.length) activeAudioPlayer = 0;

    return SoundActive(
      state.musicVolume,
      state.soundVolume,
      state.helperVolume,
      state.poliphony,
      state.audioPlayers,
      activeAudioPlayer,
      state.helperAudioPlayer,
      state.musicAudioPlayer,
    );
  }
}
