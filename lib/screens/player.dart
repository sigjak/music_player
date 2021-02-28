import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import './commons/player_buttons.dart';
import './commons/slider.dart';
import './commons/name.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer _audioPlayer;
  List<String> audioFiles;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    // _audioPlayer
    //     .setAudioSource(ConcatenatingAudioSource(children: [
    //   AudioSource.uri(
    //     Uri.parse("asset:///audio/book/John Grisham -TheGuardians_01.mp3,"),
    //   ),
    //   AudioSource.uri(
    //     Uri.parse("asset:///audio/book/John Grisham -TheGuardians_02.mp3,"),
    //   ),
    //   // AudioSource.uri(
    //   //   Uri.parse("asset:///audio/book/John Grisham -TheGuardians_03.mp3,"),
    //   // ),
    // ]))
    //     .catchError((error) {
    //   // catch load errors: 404, invalid url ...
    //   print("An error occured $error");
    // });
    // Set a sequence of audio sources that will be played by the audio player.
    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      // AudioSource.uri(Uri.parse(
      //     "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3")),
      // AudioSource.uri(Uri.parse(
      //     "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3")),
      // AudioSource.uri(Uri.parse(
      //     "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),

      AudioSource.uri(Uri.parse("asset:///audio/book/guard1.mp3")),
      AudioSource.uri(Uri.parse("asset:///audio/book/guard2.mp3")),
      AudioSource.uri(Uri.parse("asset:///audio/book/guard3.mp3")),
      AudioSource.uri(Uri.parse("asset:///audio/book/guard4.mp3")),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  // initAll() async {
  //   List<AudioSource> aa = await getAssetFiles();
  // }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<List<String>> getAssetFiles() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    List<String> myfiles = [];
    List<String> gg =
        manifestMap.keys.where((key) => key.contains('.mp3')).toList();
    print(gg);
    gg.forEach((element) {
      String temp = element.replaceAll('%20', ' ');
      myfiles.add(temp);
    });
    return myfiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Names(_audioPlayer),
          ElevatedButton(
              onPressed: () async {
                await getAssetFiles();
              },
              child: Text('Get')),
          ElevatedButton(
              onPressed: () async {
                await _audioPlayer.seek(Duration(milliseconds: 4000), index: 1);
              },
              child: Text('jump')),
          PlayerButtons(_audioPlayer),
          SliderBar(_audioPlayer),
        ],
      ),
    ));
  }
}
