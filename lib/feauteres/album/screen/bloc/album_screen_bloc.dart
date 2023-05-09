import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_music/common/entities/track/track.dart';
import 'package:top_music/feauteres/album/domain/entities/album.dart';
import 'package:top_music/feauteres/album/domain/repository/album_repository.dart';

part 'album_screen_event.dart';
part 'album_screen_state.dart';

class AlbumScreenBloc extends Bloc<AlbumScreenBlocEvent, AlbumScreenBlocState> {
  final AlbumRepository repository;

  AlbumScreenBloc({required this.repository})
      : super(const AlbumScreenBlocState()) {
    on<GetAlbum>(_getAlbum);
    on<DownloadTrack>((event, emit) => _downloadTrack(event.track, emit));
    on<DownloadAlbumTracks>(_downloadAllTracks);
  }

  _getAlbum(GetAlbum event, Emitter<AlbumScreenBlocState> emit) async {
    try {
      var response = await repository.getAlbumById(event.albumID);
      emit(state.copyWith(
        album: response,
        loadingStatus: LoadingStatus.success,
      ));
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }

  Future<void> _downloadTrack(
    Track track,
    Emitter<AlbumScreenBlocState> emit,
  ) async {
    var downloadedTrack = await repository.downloadTrack(track);
    var tracks = state.album?.tracks
        .map((el) => el.id == track.id
            ? el.copyWith(
                downloadedAudioPath: downloadedTrack.audioPath,
                downloadedImagePath: downloadedTrack.imagePath)
            : el)
        .toList();

    emit(state.copyWith(album: state.album?.copyWith(tracks: tracks)));
  }

  _downloadAllTracks(
    DownloadAlbumTracks event,
    Emitter<AlbumScreenBlocState> emit,
  ) async {
    for (var track in event.tracks) {
      await _downloadTrack(track, emit);
    }
  }
}
