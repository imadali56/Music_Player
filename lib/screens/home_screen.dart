import 'package:flutter/material.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/screens/song_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // get the playlist provider
  late final dynamic playlistProvider;

  @override
  void initState(){
    super.initState();
    // get playlist provider
    playlistProvider= Provider.of<PlayListProvider>(context, listen: false);
  }
  // go to song
  void goToSong(int songIndex){
    // update current song index

playlistProvider.currentSongIndex= songIndex;
    // navigate to song page
    Navigator.push(context, MaterialPageRoute(builder: (context) => SongScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('P L A Y L I S T', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
          // get the playlist

          final List<Song> playlist= value.playList;

          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index){
                // get individual song
                final Song song = playlist[index];
                // return list tile ui
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        song.albumArtImagePath,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Text(
                      song.songName,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    subtitle: Text(
                      song.artistName,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    trailing: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.black54,
                      size: 28,
                    ),

                    onTap: () => goToSong(index),
                  ),
                );

              });
          // return listview ui
        }
      ),
    );
  }
}
