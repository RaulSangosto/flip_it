import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flipit/src/state/bloc/sound/sound_data.dart';

enum SoundType {
  place,
  improve,
  special,
  draw,
  click,
  select,
  cancel,
  move,
  win,
  lose,
  open,
  close,
  openHelp,
  closeHelp,
  logoOpen,
}

enum ThemeSongs {
  mainMenu,
  playArea,
  menus,
  win,
  lose,
  credits,
}

class MusicPlayer {
  static final MusicPlayer _instance = MusicPlayer._();
  late AudioPlayer musicPlayer;
  late AudioPlayer helperPlayer;

  static MusicPlayer get instance => _instance;

  MusicPlayer._() {
    musicPlayer = AudioPlayer();
    helperPlayer = AudioPlayer();
  }
}

class SoundController {
  final double musicVolume;
  final double soundVolume;
  final double helperVolume;
  final int poliphony;
  final int activeAudioPlayer;
  final AudioPlayer helperAudioPlayer = MusicPlayer.instance.helperPlayer;
  final AudioPlayer musicAudioPlayer = MusicPlayer.instance.musicPlayer;
  final List<AudioPlayer> audioPlayers;
  ThemeSongs? currentSong;

  SoundController(
    this.musicVolume,
    this.soundVolume,
    this.helperVolume,
    this.poliphony,
    this.activeAudioPlayer,
    this.audioPlayers,
  );

  factory SoundController.initial() {
    return SoundController(
      .5,
      .5,
      .5,
      2,
      0,
      List.generate(2, (index) => AudioPlayer()),
    );
  }

  SoundController copyWith({
    double? musicVolume,
    double? soundVolume,
    double? helperVolume,
    int? poliphony,
    int? activeAudioPlayer,
    AudioPlayer? helperAudioPlayer,
    List<AudioPlayer>? audioPlayers,
  }) {
    return SoundController(
      musicVolume ?? this.musicVolume,
      soundVolume ?? this.soundVolume,
      helperVolume ?? this.helperVolume,
      poliphony ?? this.poliphony,
      activeAudioPlayer ?? this.activeAudioPlayer,
      audioPlayers ?? this.audioPlayers,
    );
  }

  bool musicMute() => musicVolume == 0;

  bool soundMute() => soundVolume == 0;

  bool helperMute() => helperVolume == 0;

  void setMusicVolume(double value) {
    musicAudioPlayer.setVolume(value * .5);
    // _setPreferencesVolume("music", value);
  }

  void setSoundVolume(double value) {
    final audioPlayer = audioPlayers[activeAudioPlayer];
    audioPlayer.setVolume(value);
  }

  void setHelperVolume(double value) {
    helperAudioPlayer.setVolume(value * .5);
  }

  void playSound(SoundType type) {
    final audioPlayer =
        audioPlayers[activeAudioPlayer.clamp(0, audioPlayers.length - 1)];
    audioPlayer.stop();
    final sound = _getRandomSoundType(type);
    setSoundVolume(soundVolume);
    audioPlayer.play(
      sound,
      volume: soundVolume,
    );
  }

  void playSong(ThemeSongs song) {
    currentSong = song;
    musicAudioPlayer.setReleaseMode(ReleaseMode.loop);
    final assetSong = _getAssetSong(song);
    setMusicVolume(musicVolume);
    musicAudioPlayer.play(
      assetSong,
      volume: musicVolume,
    );
  }

  void startTalkHelper() {
    final position = Duration(milliseconds: (Random().nextInt(10000)));
    helperAudioPlayer.stop();
    setHelperVolume(helperVolume);
    helperAudioPlayer.play(
      AssetSource("sounds/helper/talking.ogg"),
      position: position,
      volume: helperVolume,
    );
  }

  void stopTalkHelper() {
    helperAudioPlayer.stop();
  }

  void stopSong() {
    musicAudioPlayer.pause();
  }

  Source _getAssetSong(ThemeSongs song) {
    String asset = "music/";
    switch (song) {
      case ThemeSongs.mainMenu:
        asset += "spinning_out.ogg";
        break;
      case ThemeSongs.playArea:
        asset += "warmth.ogg";
        break;
      case ThemeSongs.menus:
        asset += "groovy_booty.ogg";
        break;
      case ThemeSongs.win:
        asset += "you_re_in_the_future.ogg";
        break;
      case ThemeSongs.lose:
        asset += "forever_lost.ogg";
        break;
      case ThemeSongs.credits:
        asset += "beach_house.ogg";
        break;
      default:
    }
    return AssetSource(asset);
  }

  Source _getRandomSoundType(SoundType type) {
    String sound;
    switch (type) {
      case SoundType.place:
        sound = placeSounds[Random().nextInt(placeSounds.length)];
        break;
      case SoundType.improve:
        sound = improveSounds[Random().nextInt(improveSounds.length)];
        break;
      case SoundType.special:
        sound = specialSounds[Random().nextInt(specialSounds.length)];
        break;
      case SoundType.select:
        sound = selectSounds[Random().nextInt(selectSounds.length)];
        break;
      case SoundType.draw:
        sound = drawSounds[Random().nextInt(drawSounds.length)];
        break;
      case SoundType.click:
        sound = clickSounds[Random().nextInt(clickSounds.length)];
        break;
      case SoundType.win:
        sound = winSounds[Random().nextInt(winSounds.length)];
        break;
      case SoundType.lose:
        sound = loseSounds[Random().nextInt(loseSounds.length)];
        break;
      case SoundType.openHelp:
        sound = openHelpSounds[Random().nextInt(openHelpSounds.length)];
        break;
      case SoundType.closeHelp:
        sound = closeHelpSounds[Random().nextInt(closeHelpSounds.length)];
        break;
      case SoundType.open:
        sound = openSounds[Random().nextInt(openSounds.length)];
        break;
      case SoundType.close:
        sound = closeSounds[Random().nextInt(closeSounds.length)];
        break;
      case SoundType.logoOpen:
        sound = logoOpenSounds[Random().nextInt(logoOpenSounds.length)];
        break;
      default:
        sound = placeSounds[Random().nextInt(placeSounds.length)];
    }
    return AssetSource(sound);
  }

  factory SoundController.fromJson(Map<String, dynamic> json) {
    final poliphony = json["poliphony"];
    return SoundController(
      json["musicVolume"],
      json["soundVolume"],
      json["helperVolume"],
      poliphony,
      json["activeAudioPlayer"],
      List.generate(poliphony, (index) => AudioPlayer()),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json["musicVolume"] = musicVolume;
    json["soundVolume"] = soundVolume;
    json["helperVolume"] = helperVolume;
    json["poliphony"] = poliphony;
    json["activeAudioPlayer"] = activeAudioPlayer;
    return json;
  }
}
