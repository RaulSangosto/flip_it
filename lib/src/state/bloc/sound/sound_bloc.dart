import 'package:flipit/src/state/bloc/sound/sound_model.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> with HydratedMixin {
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
    final double volume = state.controller.musicVolume == 0.0 ? 0.5 : 0.0;
    state.controller.setMusicVolume(volume);

    return SoundActive(state.controller.copyWith(musicVolume: volume));
  }

  SoundActive _toggleSoundVolume(ToggleSoundVolume event) {
    final double volume = state.controller.soundVolume == 0.0 ? 0.5 : 0.0;
    state.controller.setSoundVolume(volume);

    return SoundActive(state.controller.copyWith(soundVolume: volume));
  }

  SoundActive _toggleHelperVolume(ToggleHelperVolume event) {
    final double volume = state.controller.helperVolume == 0.0 ? 0.5 : 0.0;
    state.controller.setHelperVolume(volume);

    return SoundActive(state.controller.copyWith(helperVolume: volume));
  }

  SoundActive _setMusicVolume(SetMusicVolume event) {
    state.controller.setMusicVolume(event.value);

    return SoundActive(state.controller.copyWith(
      musicVolume: event.value.clamp(0.0, 1.0),
    ));
  }

  SoundActive _setSoundVolume(SetSoundVolume event) {
    state.controller.setSoundVolume(event.value);

    return SoundActive(state.controller.copyWith(
      soundVolume: event.value.clamp(0.0, 1.0),
    ));
  }

  SoundActive _setHelperVolume(SetHelperVolume event) {
    state.controller.setHelperVolume(event.value);

    return SoundActive(state.controller.copyWith(
      helperVolume: event.value.clamp(0.0, 1.0),
    ));
  }

  SoundState _playSound(PlaySound event) {
    state.controller.playSound(event.sound);
    var activeAudioPlayer = state.controller.activeAudioPlayer + 1;
    if (activeAudioPlayer >= state.controller.audioPlayers.length) {
      activeAudioPlayer = 0;
    }

    return SoundActive(
        state.controller.copyWith(activeAudioPlayer: activeAudioPlayer));
  }

  SoundState _playSong(PlaySong event) {
    state.controller.playSong(event.song);

    return SoundActive(state.controller.copyWith());
  }

  SoundState _stopSong(StopSong event) {
    state.controller.stopSong();

    return SoundActive(state.controller.copyWith());
  }

  SoundState _startTalkHelper() {
    state.controller.startTalkHelper();

    return SoundActive(state.controller.copyWith());
  }

  SoundState _stopTalkHelper() {
    state.controller.stopTalkHelper();

    return SoundActive(state.controller.copyWith());
  }

  SoundState _selectHelperItem() {
    state.controller.startTalkHelper();
    state.controller.playSound(SoundType.select);
    var activeAudioPlayer = state.controller.activeAudioPlayer + 1;
    if (activeAudioPlayer >= state.controller.audioPlayers.length) {
      activeAudioPlayer = 0;
    }

    return SoundActive(state.controller.copyWith(
      activeAudioPlayer: activeAudioPlayer,
    ));
  }

  @override
  SoundState? fromJson(Map<String, dynamic> json) {
    try {
      final controller = SoundController.fromJson(json);
      return SoundActive(controller);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SoundState state) {
    if (state is SoundActive) {
      return state.controller.toJson();
    }
    return null;
  }
}
