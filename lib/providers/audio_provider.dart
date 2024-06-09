import 'package:audioplayers/audioplayers.dart';
import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AudioProvider extends ChangeNotifier {
  final player = AudioPlayer();

  String? _url;

  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  String? get url => _url;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = const Duration(seconds: 89);

  get currentPosition => _currentPosition;

  get totalDuration => _totalDuration;

  set currentPositions(Duration value) {
    _currentPosition = value;
    notifyListeners();
  }

  AudioProvider() {
    /// Compulsory
    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        _isPlaying = false;
      } else if (event == PlayerState.playing) {
        _isPlaying = true;
      } else if (event == PlayerState.paused) {
        _isPlaying = false;
      }
      notifyListeners();
    });

    player.onDurationChanged.listen((duration) {
      if (duration > Duration.zero) {
        _totalDuration = duration;
        notifyListeners();
      }
    });

    player.onPositionChanged.listen((duration) {
      _currentPosition = duration;
      notifyListeners();
    });
  }

  void setUrl(String? url) async {
    if (_url == url) return;
    _url = url;
    // Load the song

    Source source = UrlSource(_url!);
    player.setSource(source);
    notifyListeners();
  }

  Future<void> play() async {
    if (_url != null) {
      Source source = UrlSource(
        _url!,
      );

      await player.play(source);
    }

    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pause(bool isRestartCurrentPosition) async {
    await player.pause();
    _isPlaying = false;
    if (isRestartCurrentPosition) {
      _currentPosition = Duration.zero;
    }
    notifyListeners();
  }

  /// Funcion para avanzar la cancion
  void seekToSec(Duration newPos) {
    player.seek(newPos); // Jumps to the given position within the audio file
    notifyListeners();
  }

  void addTime() {
    Duration newPos = Duration(seconds: (_currentPosition.inSeconds + 5));
    player.seek(newPos); // Jumps to the given position within the audio file
    toastMessage(S.current.add_time_audio);
    notifyListeners();
  }

  // void stop() async {
  //   await player.stop();
  //   _currentPosition = Duration.zero;
  //   _totalDuration = const Duration(seconds: 89);
  //   _isPlaying = false;
  //   notifyListeners();
  // }

  void substractTime() {
    Duration newPos = Duration(seconds: (_currentPosition.inSeconds - 5));
    player.seek(newPos); // Jumps to the given position within the audio file
    toastMessage(S.current.substract_time_audio);
    notifyListeners();
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
      backgroundColor: Colors.black.withOpacity(0.5),
      textColor: Colors.white,
    );
  }
}
