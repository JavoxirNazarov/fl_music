import 'package:top_music/common/libs/api_client/api_client.dart';
import 'package:top_music/feauteres/album/domain/entities/album.dart';

class AlbumApiClient {
  final ApiClient apiClient;
  const AlbumApiClient({required this.apiClient});

  Future<Album> getAlbumById({
    required String id,
    required String? sessionToken,
  }) async {
    var result = await apiClient.get(
      path: 'albums/$id/',
      parser: Album.fromJson,
      sessionToken: sessionToken,
    );

    return result;
  }
}
