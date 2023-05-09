import 'package:top_music/common/libs/api_client/api_client.dart';
import 'package:top_music/feauteres/home/domain/entities/album_module_item.dart';
import 'package:top_music/feauteres/home/domain/entities/artist_module_item.dart';
import 'package:top_music/feauteres/home/domain/entities/home_screen_module.dart';
import 'package:top_music/feauteres/home/domain/entities/promo_module_item.dart';

class HomeApiClient {
  Future<List<HomeModule>> getHomePageModules() async {
    List<HomeModule> parser(Map<String, dynamic> json) {
      return (json['results'] as List<dynamic>)
          .map((e) => HomeModule.fromJson(e))
          .toList();
    }

    final result = await ApiClient.get(
      path: "modules/?placeholder=pl_home_modules&sections=topmusicapp",
      parser: parser,
      withAuth: true,
    );

    return result;
  }

  Future<List<HomeModule>> getHomePageModulesData(
    List<HomeModule> modules,
  ) async {
    for (var module in modules) {
      if (module.model == "HomeBannerModule") {
        module.type = HomeModuleTypes.promo;

        List<PromoModuleItem> parser(Map<String, dynamic> json) {
          return (json['items'] as List<dynamic>)
              .map((el) => PromoModuleItem.fromJson(el))
              .toList();
        }

        final apiResponse = await ApiClient.get(
          path: module.params.link,
          parser: parser,
          withAuth: true,
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

        final apiResponse = await ApiClient.get(
          path: module.params.link,
          parser: parser,
          withAuth: true,
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

        final apiResponse = await ApiClient.get(
          path: module.params.link,
          parser: parser,
          withAuth: true,
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

  Future<List<HomeModule>> getHomePage() async {
    final modules = await getHomePageModules();
    final result = await getHomePageModulesData(modules);

    return result;
  }
}
