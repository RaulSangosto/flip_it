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
  late List<AudioPlayer> audioPlayers;

  SoundState(
    this.musicVolume,
    this.soundVolume,
    this.helperVolume,
    this.poliphony,
    this.audioPlayers,
    this.activeAudioPlayer,
    this.helperAudioPlayer,
  );

  bool musicMute() => musicVolume == 0;

  bool soundMute() => soundVolume == 0;

  bool helperMute() => helperVolume == 0;

  void playSound(SoundType type) {
    final audioPlayer =
        audioPlayers[activeAudioPlayer.clamp(0, audioPlayers.length - 1)];
    audioPlayer.stop();
    debugPrint(activeAudioPlayer.toString());
    final sound = _getRandomSoundType(type);
    audioPlayer.play(
      sound,
      volume: soundVolume,
    );
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
    helperAudioPlayer.play(
      AssetSource("sounds/helper/talking.ogg"),
      position: position,
      volume: helperVolume * .5,
    );
  }

  void stopTalkHelper() {
    helperAudioPlayer.stop();
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
  );
}
