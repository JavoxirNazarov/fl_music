import 'package:top_music/common/entities/track/track.dart';
import 'package:top_music/common/libs/download_service/download_manager.dart';
import 'package:top_music/feauteres/album/domain/api/album_api_client.dart';
import 'package:top_music/feauteres/album/domain/entities/album.dart';
import 'package:top_music/feauteres/auth/services/session_store.dart';

class AlbumRepository {
  const AlbumRepository({
    required this.downloadService,
    required this.albumApiClient,
    required this.sessionStore,
  });

  final AlbumApiClient albumApiClient;
  final DownloadService downloadService;
  final SessionStore sessionStore;

  Future<Album> getAlbumById(String id) async {
    var result = await albumApiClient.getAlbumById(
      id: id,
      sessionToken: sessionStore.getSession(),
    );

    for (var track in result.tracks) {
      var downloadTrack =
          await downloadService.getTrackIfDowloaded(track: track);

      track.downloadedAudioPath = downloadTrack.audioPath;
      track.downloadedImagePath = downloadTrack.imagePath;
    }

    return result;
  }

  Future<DownloadedTrack> downloadTrack(Track track) async {
    return downloadService.downloadTrack(track: track);
  }
}
