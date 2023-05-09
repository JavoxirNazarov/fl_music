import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';

class TrackCarousel extends StatefulWidget {
  const TrackCarousel({super.key});

  @override
  State<TrackCarousel> createState() => _TrackCarouselState();
}

class _TrackCarouselState extends State<TrackCarousel> {
  PageController scrollController = PageController();
  StreamSubscription? indexSubscription;
  int prevScrollIndex = 0;

  @override
  void initState() {
    final playerHandler = context.read<PlayerProvider>();

    indexSubscription = playerHandler.currentIndexStream.listen((scrollIndex) {
      if (scrollIndex != null && prevScrollIndex != scrollIndex) {
        prevScrollIndex = scrollIndex;
        scrollController.animateToPage(
          scrollIndex,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    indexSubscription?.cancel();
    super.dispose();
  }

  void onPageChanged(int value, BuildContext context) {
    prevScrollIndex = value;

    final playerHandler = context.read<PlayerProvider>();
    playerHandler.seek(
      Duration.zero,
      index: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerHandler = context.watch<PlayerProvider>();
    final playingTraks = playerHandler.playingTraks ?? [];
    final currentTrack = playerHandler.currentTrack;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 350,
            child: PageView.builder(
              onPageChanged: (value) => onPageChanged(value, context),
              controller: scrollController,
              itemBuilder: (context, index) => Image(
                fit: BoxFit.cover,
                image: playingTraks[index].downloadedImagePath != null
                    ? FileImage(File(playingTraks[index].downloadedImagePath!))
                        as ImageProvider
                    : NetworkImage(playingTraks[index].image),
              ),
              itemCount: playingTraks.length,
            ),
          ),
        ),
        Text(currentTrack?.title ?? ''),
      ],
    );
  }
}
