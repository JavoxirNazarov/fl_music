import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_music/common/ui/horizontal_wrapper/horizontal_wrapper.dart';
import 'package:top_music/common/ui/touchable/touchable.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';
import 'package:top_music/feauteres/player/screens/ui/play_pause_btn.dart';
import 'package:top_music/feauteres/player/screens/ui/seek_bar.dart';
import 'package:top_music/feauteres/player/screens/ui/track_carousel.dart';
import 'package:top_music/resources/icons.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final playerHandler = context.read<PlayerProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HorizontalWrapper(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(AppIcons.chevronDown),
                  onTap: () => Navigator.of(context).pop(),
                ),
                const Text('ALBUM'),
                const Icon(AppIcons.menu)
              ],
            ),
          ),
          const TrackCarousel(),
          const SeekBar(),
          HorizontalWrapper(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(AppIcons.repeat),
                Touchable(
                  onPress: playerHandler.seekToPrevious,
                  child: const Icon(AppIcons.prev),
                ),
                const PlayPauseBtn(),
                Touchable(
                  onPress: playerHandler.seekToNext,
                  child: const Icon(AppIcons.next),
                ),
                const Icon(AppIcons.shuffle)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showPlayerScreen(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => const PlayerScreen(),
  );
}
