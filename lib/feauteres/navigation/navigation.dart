import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_music/common/libs/api_client/api_client.dart';
import 'package:top_music/common/libs/download_service/download_manager.dart';
import 'package:top_music/common/ui/layout/app_layout.dart';
import 'package:top_music/feauteres/album/domain/api/album_api_client.dart';
import 'package:top_music/feauteres/auth/services/session_store.dart';
import 'package:top_music/feauteres/album/domain/repository/album_repository.dart';
import 'package:top_music/feauteres/album/screen/album_screen.dart';
import 'package:top_music/feauteres/album/screen/bloc/album_screen_bloc.dart';
import 'package:top_music/feauteres/auth/screens/login_screen.dart';
import 'package:top_music/feauteres/home/domain/api/home_api_client.dart';
import 'package:top_music/feauteres/home/screens/home_screen.dart';

abstract class AppRouteNames {
  static const String main = "/";
  static const String login = "/login/:token";
  static String album(int id) => "/album/$id";
}

class AppNavigation {
  final SessionStore sessionStore = SessionStore();
  final ApiClient apiCLient = const ApiClient();
  final DownloadService downloadService = const DownloadService();

  late AlbumApiClient albumApiClient = AlbumApiClient(apiClient: apiCLient);
  late HomeApiClient homeApiClient = HomeApiClient(apiClient: apiCLient);

  late final GoRouter router = GoRouter(
      initialLocation: sessionStore.getSession() != null
          ? AppRouteNames.main
          : AppRouteNames.login,
      routes: [
        GoRoute(
          path: AppRouteNames.login,
          builder: (_, __) => LoginScreen(
            sessionStore: sessionStore,
          ),
        ),
        ShellRoute(
          builder: (context, state, child) => AppLayout(child: child),
          routes: [
            GoRoute(
              path: AppRouteNames.main,
              builder: (_, __) => HomeScreen(
                homeApiClient: homeApiClient,
                sessionStore: sessionStore,
              ),
            ),
            GoRoute(
              path: "/album/:id",
              builder: (_, state) => BlocProvider(
                create: (context) => AlbumScreenBloc(
                  repository: AlbumRepository(
                    downloadService: downloadService,
                    albumApiClient: albumApiClient,
                    sessionStore: sessionStore,
                  ),
                )..add(GetAlbum(albumID: state.params['id']!)),
                child: const AlbumScreen(),
              ),
            )
          ],
        )
      ]);
}
