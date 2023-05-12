import 'package:top_music/common/libs/api_client/api_client.dart';
import 'package:top_music/feauteres/home/domain/entities/album_module_item.dart';
import 'package:top_music/feauteres/home/domain/entities/artist_module_item.dart';
import 'package:top_music/feauteres/home/domain/entities/home_screen_module.dart';
import 'package:top_music/feauteres/home/domain/entities/promo_module_item.dart';

class HomeApiClient {
  const HomeApiClient({required this.apiClient});

  final ApiClient apiClient;

  Future<List<HomeModule>> getHomePageModules({
    required String? sessionToken,
  }) async {
    List<HomeModule> parser(Map<String, dynamic> json) {
      return (json['results'] as List<dynamic>)
          .map((e) => HomeModule.fromJson(e))
          .toList();
    }

    final result = await apiClient.get(
      path: "modules/?placeholder=pl_home_modules&sections=topmusicapp",
      parser: parser,
      sessionToken: sessionToken,
    );

    return result;
  }

  Future<List<HomeModule>> getHomePageModulesData({
    required List<HomeModule> modules,
    required String? sessionToken,
  }) async {
    for (var module in modules) {
      if (module.model == "HomeBannerModule") {
        module.type = HomeModuleTypes.promo;

        List<PromoModuleItem> parser(Map<String, dynamic> json) {
          return (json['items'] as List<dynamic>)
              .map((el) => PromoModuleItem.fromJson(el))
              .toList();
        }

        final apiResponse = await apiClient.get(
          path: module.params.link,
          parser: parser,
          sessionToken: sessionToken,
          ignoreBaseApi: true,
        );

        module.data = apiResponse;
        continue;
      }
      if (module.params.type == 'author') {
        module.type = HomeModuleTypes.artist;

        List<ArtistModuleItem> parser(Map<String, dynamic> json) {
          return (json['items'] as List<dynamic>)
              .map((el) => ArtistModuleItem.fromJson(el))
              .toList();
        }

        final apiResponse = await apiClient.get(
          path: module.params.link,
          parser: parser,
          sessionToken: sessionToken,
          ignoreBaseApi: true,
        );

        module.data = apiResponse;
        continue;
      }

      final bool hasCategories = module.params.categories != null &&
          module.params.categories!.isNotEmpty;

      if (hasCategories && module.params.categories![0] == 'Album') {
        module.type = HomeModuleTypes.album;

        List<AlbumModuleItem> parser(Map<String, dynamic> json) {
          return (json['items'] as List<dynamic>)
              .map((el) => AlbumModuleItem.fromJson(el))
              .toList();
        }

        final apiResponse = await apiClient.get(
          path: module.params.link,
          parser: parser,
          sessionToken: sessionToken,
          ignoreBaseApi: true,
        );

        module.data = apiResponse;
        continue;
      }

      if (hasCategories && module.params.categories![0] == 'Playlist') {
        module.type = HomeModuleTypes.playlist;
        continue;
      }

      if (module.type == null) continue;
    }
    return modules;
  }

  Future<List<HomeModule>> getHomePage({
    required String? sessionToken,
  }) async {
    final modules = await getHomePageModules(sessionToken: sessionToken);
    final result = await getHomePageModulesData(
      modules: modules,
      sessionToken: sessionToken,
    );

    return result;
  }
}
