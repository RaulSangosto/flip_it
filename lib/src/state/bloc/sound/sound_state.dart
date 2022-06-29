part of 'sound_bloc.dart';

enum SoundType { pop, draw, click, cancel, move }

List<String> popSounds = [
  "sounds/pop1.ogg",
  "sounds/pop2.ogg",
  "sounds/pop3.ogg"
];
List<String> drawSounds = ["sounds/draw.wav"];
List<String> clickSounds = ["sounds/playcard.wav"];

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
      case SoundType.pop:
        sound = popSounds[Random().nextInt(popSounds.length)];
        break;
      case SoundType.draw:
        sound = drawSounds[Random().nextInt(drawSounds.length)];
        break;
      case SoundType.click:
        sound = clickSounds[Random().nextInt(clickSounds.length)];
        break;
      default:
        sound = popSounds[Random().nextInt(popSounds.length)];
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
