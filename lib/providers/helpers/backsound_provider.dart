import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BacksoundProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Future<void> playAudio(String assets) async {
    if (!isPlaying) {
      await _audioPlayer.play(AssetSource(assets));
      isPlaying = true;
    } else {
      await _audioPlayer.pause();
      isPlaying = false;
    }
    notifyListeners();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
