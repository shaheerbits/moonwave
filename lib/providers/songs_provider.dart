import 'package:flutter/widgets.dart';
import 'package:moonwave/services/audio_query_service.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsProvider extends ChangeNotifier {
  final AudioQueryService _audioQueryService = AudioQueryService();

  List<SongModel> _songs = [];

  List<SongModel> get songs => _songs;

  Future<void> loadSongs() async {
    final result = await _audioQueryService.fetchSongs();
    _songs = result;
    notifyListeners();
  }
}