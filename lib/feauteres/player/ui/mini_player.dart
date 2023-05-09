import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_music/common/ui/gradient_icon/gradient_icon.dart';
import 'package:top_music/common/ui/touchable/touchable.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';
import 'package:top_music/feauteres/player/screens/player_screen.dart';
import 'package:top_music/resources/icons.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    final playerHandler = context.read<PlayerProvider>();
    return GestureDetector(
      onTap: () => showPlayerScreen(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(children: [
          StreamBuilder<bool>(
            stream: playerHandler.playingStream,
            builder: (context, snapshot) {
              bool isPlaying = snapshot.data ?? false;
              return Touchable(
                onPress: isPlaying ? playerHandler.pause : playerHandler.play,
                child: GradientIcon(
                  icon: isPlaying ? AppIcons.play : AppIcons.pause,
                  size: 20,
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
