import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import './commons/player_buttons.dart';
import './commons/slider.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer _audioPlayer;
  List<String> audioFiles;
  List<AudioSource> myList = [
    AudioSource.uri(Uri.parse("asset:///audio/book/guard.mp3")),
  ];
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: myList))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

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
          PlayerButtons(_audioPlayer),
          SliderBar(_audioPlayer),
        ],
      ),
    ));
  }
}
