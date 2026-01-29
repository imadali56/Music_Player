import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Added Hive import

class PlayListProvider extends ChangeNotifier {
  // play list of song
  final List<Song> _playList = [
    // song 1
    Song(
      songName: 'Kaise Dunia',
      artistName: 'Arijit Singh',
      albumArtImagePath: 'assets/images/Aesthetic_1',
      audioPath: 'assets/songs/song_1.mp3',
    ),
// song 2
    Song(
      songName: 'Saiyaara',
      artistName: ' Irshad Kamil',
      albumArtImagePath: 'assets/images/aesthetic_2',
      audioPath: 'assets/songs/Saiyaara.mp3',
    ),
// song 3
    Song(
      songName: 'Dil Mera 💔',
      artistName: 'Masood Rana',
      albumArtImagePath: 'assets/images/aesthetic_3',
      audioPath: 'assets/songs/song_3.mp3',
    ),
    // song 4
    Song(
      songName: 'Chinaar',
      artistName: 'Karan Khan',
      albumArtImagePath: 'assets/images/aesthetic_4.jfif',
      audioPath: 'assets/songs/pa_sha_me.mp3',
    ),
    // song 5
    Song(
      songName: 'Tere Bin',
      artistName: 'Jubin Nautiyal',
      albumArtImagePath: 'assets/images/aesthetic_5.jfif',
      audioPath: 'assets/songs/tere_bin.mp3',
    ),
    // song 6
    Song(
      songName: 'Za os hum Kala',
      artistName: 'Karan Khan',
      albumArtImagePath: 'assets/images/aesthetic_6.jfif',
      audioPath: 'assets/songs/za_os_hum_kala.mp3',
    ),
    // song 7
    Song(
      songName: 'Tera Kasoor',
      artistName: 'Vishal Mishra',
      albumArtImagePath: 'assets/images/aesthetic_7.jfif',
      audioPath: 'assets/songs/tera_kasoor.mp3',
    ),
  ];

  // current song playing index
  int? _currentSongIndex;

  // --- AUDIO PLAYER--- //
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Access Hive Box
  final _myBox = Hive.box('music_box');

  // constructor
  PlayListProvider() {
    listenToDuration();
    loadLastSong(); // Load saved song index on startup
  }

  // Load last played song from Hive
  void loadLastSong() {
    _currentSongIndex = _myBox.get('LAST_INDEX', defaultValue: 0);
    notifyListeners();
  }

  // Initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath.replaceFirst('assets/', '');

    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position in current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong(){
    if(_currentSongIndex != null){
      if(_currentSongIndex! < _playList.length -1){
        // goto the next song if not's the last song
        currentSongIndex= _currentSongIndex! + 1;
      }
      else{
        // if it's the last song, loop back to the first song
        currentSongIndex= 0;

      }
    }
  }

  // play previous song
  void playPreviousSong()async{
    // if more than 2 second have passed, restart the current song
    if(_currentDuration.inSeconds > 2){
      seek(Duration.zero);
    }
    // if it's within first 2 second of the song, goto previous song
    else{
      if(_currentSongIndex! > 0){
        currentSongIndex = _currentSongIndex! - 1;
      }
      else{
        // if it's the first song, loop back to last
        currentSongIndex= _playList.length - 1;
      }
    }
  }
  // listen to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose audio player

  // getters
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;


  // setters
  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;

    if(newIndex != null){
      // Save index to Hive
      _myBox.put('LAST_INDEX', newIndex);
      play(); // play the song at the new index
    }
    // update ui
    notifyListeners();
  }
}