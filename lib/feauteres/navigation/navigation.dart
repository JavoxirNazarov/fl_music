import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_music/common/libs/download_service/download_manager.dart';
import 'package:top_music/feauteres/album/domain/repository/album_repository.dart';
import 'package:top_music/feauteres/album/screen/album_screen.dart';
import 'package:top_music/feauteres/album/screen/bloc/album_screen_bloc.dart';
import 'package:top_music/feauteres/auth/screens/login_screen.dart';
import 'package:top_music/feauteres/auth/services/session_store.dart';
import 'package:top_music/feauteres/home/domain/api/home_api_client.dart';
import 'package:top_music/feauteres/home/screens/home_screen.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';
import 'package:top_music/feauteres/player/ui/mini_player.dart';
import 'package:top_music/resources/icons.dart';

abstract class AppRouteNames {
  static const String main = "/";
  static const String login = "/login/:token";
  static String album(int id) => "/album/$id";
}

class AppNavigation {
  final GoRouter router = GoRouter(
      initialLocation: SessionStore.intance.getSession() != null
          ? AppRouteNames.main
          : AppRouteNames.login,
      routes: [
        GoRoute(
          path: AppRouteNames.login,
          builder: (_, __) => const LoginScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) => Column(children: [
            Expanded(
              child: Stack(
                children: [
                  child,
                  if (context.watch<PlayerProvider>().currentTrack != null)
                    const Positioned(
                      bottom: 0,
                      child: MiniPlayer(),
                    )
                ],
              ),
            ),
            BottomNavigationBar(
              currentIndex: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.home),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.myMusic),
                  label: 'Music',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.search),
                  label: 'Research',
                ),
              ],
            )
          ]),
          routes: [
            GoRoute(
              path: AppRouteNames.main,
              builder: (_, __) => HomeScreen(
                homeApiClient: HomeApiClient(),
              ),
            ),
            GoRoute(
                path: "/album/:id",
                builder: (_, state) => BlocProvider(
                      create: (context) => AlbumScreenBloc(
                        repository: const AlbumRepository(
                          downloadService: DownloadService(),
                        ),
                      )..add(GetAlbum(albumID: state.params['id']!)),
                      child: const AlbumScreen(),
                    ))
          ],
        )
      ]);
}
