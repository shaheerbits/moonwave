import 'package:flutter/material.dart';
import 'package:moonwave/providers/songs_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../widgets/music_data_tile.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late SongsProvider songsProvider;

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
      backgroundColor: Colors.transparent,
      drawer: Drawer(),
      body: Consumer<SongsProvider>(
        builder: (context, songsProvider, _) {
          final songs = songsProvider.songs;
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.8],
                colors: [
                  Color.fromRGBO(54, 60, 68, 1),
                  Color.fromRGBO(46, 49, 54, 1),
                ]
              )
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              'All Your ',
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900
                              ),
                            ),

                            Text(
                              'Music',
                              style: TextStyle(
                                  color: Colors.limeAccent,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return MusicDataTile(song: song, index: index,);
                      }
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
