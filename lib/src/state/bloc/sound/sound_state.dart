part of 'sound_bloc.dart';

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

List<String> placeSounds = [
  "sounds/pop1.ogg",
  "sounds/pop2.ogg",
  "sounds/pop3.ogg"
];
List<String> improveSounds = [
  "sounds/ui/drop_004.ogg",
  "sounds/ui/drop_002.ogg",
];

List<String> selectSounds = [
  "sounds/ui/glitch_004.ogg",
];
List<String> specialSounds = [
  "sounds/ui/confirmation_003.ogg"
  // "sounds/ui/select_005.ogg",
  // "sounds/ui/select_004.ogg",
];
List<String> winSounds = ["sounds/ui/confirmation_002.ogg"];
List<String> loseSounds = ["sounds/ui/minimize_006.ogg"];
List<String> drawSounds = ["sounds/draw.wav"];
List<String> clickSounds = ["sounds/ui/bong_001.ogg"];
List<String> openHelpSounds = ["sounds/ui/drop_001.ogg"];
List<String> closeHelpSounds = ["sounds/ui/error_004.ogg"];
List<String> openSounds = ["sounds/ui/switch_006.ogg"];
List<String> closeSounds = ["sounds/ui/switch_005.ogg"];
List<String> logoOpenSounds = ["sounds/ui/impactMining_001.ogg"];

@immutable
abstract class SoundState {
  final double musicVolume;
  final double soundVolume;
  final double helperVolume;
  final int poliphony;
  final int activeAudioPlayer;
  final AudioPlayer helperAudioPlayer;
  final AudioPlayer musicAudioPlayer;
  late List<AudioPlayer> audioPlayers;

  SoundState(
    this.musicVolume,
    this.soundVolume,
    this.helperVolume,
    this.poliphony,
    this.audioPlayers,
    this.activeAudioPlayer,
    this.helperAudioPlayer,
    this.musicAudioPlayer,
  );

  bool musicMute() => musicVolume == 0;

  bool soundMute() => soundVolume == 0;

  bool helperMute() => helperVolume == 0;

  // void _setPreferencesVolume(String key, double value) async {
  //   final preferences = await sharedPreferences;
  //   preferences.setDouble(key, value);
  // }

  // Future<double> _getPreferencesVolume(String key) async {
  //   final preferences = await sharedPreferences;
  //   return preferences.getDouble(key) ?? .5;
  // }

  // void recoverPreferenceValues() async {
  //   final keys = ["music", "sound", "helper"];
  //   for (var key in keys) {
  //     final value = await _getPreferencesVolume(key);
  //     _setPreferencesVolume(key, value);
  //   }
  // }

  void setMusicVolume(double value) {
    musicAudioPlayer.setVolume(value * .5);
    // _setPreferencesVolume("music", value);
  }

  void setSoundVolume(double value) {
    final audioPlayer = audioPlayers[activeAudioPlayer];
    audioPlayer.setVolume(value);
    // _setPreferencesVolume("sound", value);
  }

  void setHelperVolume(double value) {
    helperAudioPlayer.setVolume(value * .5);
    // _setPreferencesVolume("helper", value);
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
    musicAudioPlayer.setReleaseMode(ReleaseMode.loop);
    final assetSong = _getAssetSong(song);
    setMusicVolume(musicVolume);
    musicAudioPlayer.play(
      assetSong,
      volume: musicVolume,
    );
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
}

class SoundInitial extends SoundState {
  SoundInitial()
      : super(
          .5,
          .5,
          .5,
          2,
          List.generate(2, (index) => AudioPlayer()),
          0,
          AudioPlayer(),
          AudioPlayer(),
        );
}

class SoundActive extends SoundState {
  SoundActive(
    super.musicVolume,
    super.soundVolume,
    super.helperVolume,
    super.poliphony,
    super.audioPlayers,
    super.activeAudioPlayer,
    super.helperAudioPlayer,
    super.musicAudioPlayer,
  );
}
