import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> play(String path) => _player.play(DeviceFileSource(path));

  Future<void> pause() => _player.pause();
}