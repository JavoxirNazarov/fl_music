import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_music/common/ui/touchable/touchable.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';
import 'package:top_music/resources/icons.dart';

class PlayPauseBtn extends StatelessWidget {
  const PlayPauseBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final playerHandler = context.read<PlayerProvider>();
    return StreamBuilder<bool>(
      stream: playerHandler.playingStream,
      builder: (context, snapshot) {
        bool isPlaying = snapshot.data ?? false;
        return Touchable(
            onPress: isPlaying ? playerHandler.pause : playerHandler.play,
            child: Icon(isPlaying ? AppIcons.play : AppIcons.pause));
      },
    );
  }
}
