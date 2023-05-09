part of 'album_screen_bloc.dart';

abstract class AlbumScreenBlocEvent {
  const AlbumScreenBlocEvent();
}

class GetAlbum extends AlbumScreenBlocEvent {
  final String albumID;

  const GetAlbum({required this.albumID});
}

class DownloadTrack extends AlbumScreenBlocEvent {
  final Track track;

  const DownloadTrack({required this.track});
}

class DownloadAlbumTracks extends AlbumScreenBlocEvent {
  final List<Track> tracks;

  const DownloadAlbumTracks({required this.tracks});
}
