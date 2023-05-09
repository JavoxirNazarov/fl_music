part of 'album_screen_bloc.dart';

enum LoadingStatus { initial, success, failure }

class AlbumScreenBlocState extends Equatable {
  const AlbumScreenBlocState({
    this.loadingStatus = LoadingStatus.initial,
    this.album,
  });

  final LoadingStatus loadingStatus;
  final Album? album;

  @override
  List<Object?> get props => [loadingStatus, album];

  AlbumScreenBlocState copyWith({LoadingStatus? loadingStatus, Album? album}) {
    return AlbumScreenBlocState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      album: album ?? this.album,
    );
  }
}
