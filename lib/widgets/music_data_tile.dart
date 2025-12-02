import 'package:flutter/material.dart';
import 'package:moonwave/pages/music_player_page.dart';
import 'package:moonwave/providers/songs_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../services/audio_service.dart';

class MusicDataTile extends StatefulWidget {
  final SongModel song;
  final int index;
  const MusicDataTile({super.key, required this.song, required this.index});

  @override
  State<MusicDataTile> createState() => _MusicDataTileState();
}

class _MusicDataTileState extends State<MusicDataTile> {
  final AudioService player = AudioService();

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<SongsProvider>(context, listen: false).currentSongIndex = widget.index;
        player.play(widget.song.data);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MusicPlayerPage()
          )
        );
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 12),
        padding: EdgeInsets.all(12),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 24,
          children: [
            QueryArtworkWidget(
              artworkWidth: 60,
              artworkHeight: 60,
              id: widget.song.id,
              type: ArtworkType.AUDIO,
              artworkQuality: FilterQuality.high,
              artworkBorder: BorderRadius.circular(12),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.song.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),

                  Text(
                      widget.song.artist ?? 'Unknown',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      )
                  ),
                ],
              ),
            ),

            Text(
              formatDuration(Duration(milliseconds: widget.song.duration ?? 0)),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
