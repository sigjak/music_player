import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Names extends StatelessWidget {
  const Names(this._audioPlayer);
  final AudioPlayer _audioPlayer;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackEvent>(
      stream: _audioPlayer.playbackEventStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return ElevatedButton(
            onPressed: () {
              print(state.processingState);
            },
            child: Text('State'));
      },
    );
  }
}
