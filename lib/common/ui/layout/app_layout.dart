import 'package:flutter/material.dart';
import 'package:top_music/common/ui/layout/bottom_navbar.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';
import 'package:top_music/feauteres/player/ui/mini_player.dart';
import 'package:provider/provider.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      const BottomNavBar()
    ]);
  }
}
