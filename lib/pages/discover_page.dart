import 'package:flutter/material.dart';
import 'package:moonwave/providers/songs_provider.dart';
import 'package:moonwave/services/audio_service.dart';
import 'package:moonwave/widgets/neu_box.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late SongsProvider songsProvider;
  AudioService player = AudioService();

  @override
  void initState() {
    super.initState();
    songsProvider = context.read<SongsProvider>();
    initSongs();
  }

  Future<void> initSongs() async {
    var status = await Permission.audio.request();

    if(status.isGranted) {
      songsProvider.loadSongs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SONICRA', style: TextStyle(letterSpacing: 2.8, fontWeight: FontWeight.bold),),
      ),
      drawer: Drawer(),
      body: Consumer<SongsProvider>(
        builder: (context, songsProvider, _) {
          final songs = songsProvider.songs;
          return Container(
            color: Theme.of(context).colorScheme.surface,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return NeuBox(
                  child: ListTile(
                    onTap: () {
                      player.play(song.data);
                    },
                    horizontalTitleGap: 24,
                    leading: QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(10),
                    ),
                    title: Text(
                      song.title,
                      maxLines: 1, overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      )
                    ),
                    subtitle: Text(song.artist ?? 'Unknown Artist', style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade300,
                    ),),
                  )
                );
              }
            ),
          );
        },
      ),
    );
  }
}
