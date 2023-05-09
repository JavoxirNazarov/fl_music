import 'package:top_music/common/entities/track/track.dart';
import 'package:top_music/common/libs/download_service/download_manager.dart';
import 'package:top_music/feauteres/album/domain/api/album_api_client.dart';
import 'package:top_music/feauteres/album/domain/entities/album.dart';

class AlbumRepository {
  const AlbumRepository({required this.downloadService});

  final AlbumApiClient _albumApiClient = const AlbumApiClient();
  final DownloadService downloadService;

  Future<Album> getAlbumById(String id) async {
    var result = await _albumApiClient.getAlbumById(id);

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
