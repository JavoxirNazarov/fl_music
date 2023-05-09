import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:top_music/common/entities/track/track.dart';

class PlayerProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  ConcatenatingAudioSource? queue;
  List<Track>? playingTraks;
  Track? currentTrack;

  PlayerProvider() {
    currentIndexStream.listen((event) {
      if (event != null && playingTraks != null) {
        final Track nextTrack = playingTraks![event];

        if (nextTrack.id != currentTrack?.id) {
          currentTrack = nextTrack;
          notifyListeners();
        }
      }
    });

    // player.playerStateStream.listen((state) {
    //   switch (state.processingState) {
    //     case ProcessingState.idle:
    //       return;
    //     case ProcessingState.loading:
    //       return;
    //     case ProcessingState.buffering:
    //       return;
    //     default:
    //       return;
    //   }
    // });
  }

  // void _onEndQueue() {
  //   playingTraks = null;
  //   currentTrack = null;
  // }

  Future<void> startTracks({
    required List<Track> tracks,
    int? playIndex,
  }) async {
    playingTraks = tracks;
    currentTrack = tracks[playIndex ?? 0];
    notifyListeners();

    queue = ConcatenatingAudioSource(
      children: tracks.map((track) {
        return track.downloadedAudioPath != null
            ? AudioSource.file(track.downloadedAudioPath!, tag: track.id)
            : AudioSource.uri(Uri.parse(track.audioUrl), tag: track.id);
      }).toList(),
    );

    await _player.setAudioSource(queue!, initialIndex: playIndex);
    _player.play();
  }

  Future<void> skipToTrack({
    required int trackIndex,
  }) {
    return _player.seek(Duration.zero, index: trackIndex);
  }

  Future<void> removeTrack({
    required int trackIndex,
  }) async {
    playingTraks?.removeAt(trackIndex);
    await queue?.removeAt(trackIndex);
  }

  Future<void> pause() => _player.pause();
  Future<void> play() => _player.play();

  Future<void> seek(Duration? position, {int? index}) =>
      _player.seek(position, index: index);

  Future<void> seekToPrevious() => _player.seekToPrevious();
  Future<void> seekToNext() => _player.seekToNext();

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<int?> get currentIndexStream => _player.currentIndexStream;
  Stream<bool> get playingStream => _player.playingStream;

  // @override
  // void dispose() {
  //   _player.dispose();
  //   super.dispose();
  // }
}
