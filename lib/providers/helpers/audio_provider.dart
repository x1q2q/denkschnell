import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider with ChangeNotifier {
  bool _onPlay = false;
  bool get onPlay => _onPlay;
  late AudioPlayer player = AudioPlayer();
  String? _sources;
  String get sources => _sources!;

  void setSource(String source) {
    _sources = source;
  }

  Future<void> play() async {
    await player.play(AssetSource(sources));
    triggerPlay(true);
  }

  Future<void> pause() async {
    await player.pause();
    triggerPlay(false);
  }

  Future<void> stop() async {
    await player.stop();
    triggerPlay(false);
  }

  void disposeAll() async {
    _onPlay = false;
    _sources = '';
    await player.stop();
  }

  void triggerPlay(bool val) {
    _onPlay = val;
    notifyListeners();
  }
}
