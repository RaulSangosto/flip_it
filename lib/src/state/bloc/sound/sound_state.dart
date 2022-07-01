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
  "sounds/ui/drop_002.ogg",
  "sounds/ui/drop_003.ogg",
];
List<String> specialSounds = [
  "sounds/ui/select_005.ogg",
  "sounds/ui/select_004.ogg",
];
List<String> winSounds = ["sounds/ui/confirmation_002.ogg"];
List<String> loseSounds = ["sounds/ui/minimize_006.ogg"];
List<String> drawSounds = ["sounds/draw.wav"];
List<String> clickSounds = ["sounds/ui/bong_001.ogg"];

@immutable
abstract class SoundState {
  final double musicVolume;
  final double soundVolume;
  final int poliphony;
  final int activeAudioPlayer;
  final List<AudioPlayer> audioPlayers;
  static final playerCache = AudioCache();

  const SoundState(
    this.musicVolume,
    this.soundVolume,
    this.poliphony,
    this.audioPlayers,
    this.activeAudioPlayer,
  );

  void playSound(SoundType type) async {
    debugPrint(activeAudioPlayer.toString());
    audioPlayers[activeAudioPlayer.clamp(0, audioPlayers.length - 1)].play(
      await _getRandomSoundType(type),
      volume: musicVolume,
    );
  }

  Future<Source> _getRandomSoundType(SoundType type) async {
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
      default:
        sound = placeSounds[Random().nextInt(placeSounds.length)];
    }
    final soundFile = await playerCache.load(sound);
    return DeviceFileSource(soundFile.path);
  }
}

class SoundInitial extends SoundState {
  final int activeSoundPlayer = 0;
  SoundInitial() : super(.5, .5, 2, List.generate(2, (_) => AudioPlayer()), 0);
}

class SoundActive extends SoundState {
  const SoundActive(
    super.musicVolume,
    super.soundVolume,
    super.poliphony,
    super.audioPlayers,
    super.activeAudioPlayer,
  );

  bool musicMute() => musicVolume == 0;

  bool soundMute() => soundVolume == 0;
}
