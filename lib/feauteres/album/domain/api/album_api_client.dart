import 'package:top_music/common/libs/api_client/api_client.dart';
import 'package:top_music/feauteres/album/domain/entities/album.dart';

class AlbumApiClient {
  const AlbumApiClient();
  Future<Album> getAlbumById(String id) async {
    var result =
        await ApiClient.get(path: 'albums/$id/', parser: Album.fromJson);

    return result;
  }
}
