import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_music/common/ui/horizontal_wrapper/horizontal_wrapper.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';

class SeekBar extends StatefulWidget {
  const SeekBar({super.key});

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  int seekPosition = 0;
  int duration = 0;

  StreamSubscription? positionStream;
  StreamSubscription? durationStream;

  @override
  void initState() {
    PlayerProvider playerHandler = context.read<PlayerProvider>();

    positionStream = playerHandler.positionStream.listen((event) {
      setState(() => seekPosition = event.inSeconds);
    });

    durationStream = playerHandler.durationStream.listen((event) {
      setState(() => duration = event?.inSeconds ?? 0);
    });
    super.initState();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    durationStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlayerProvider playerHandler = context.read<PlayerProvider>();

    return Column(
      children: [
        Slider(
          value: seekPosition.toDouble(),
          max: duration.toDouble(),
          onChanged: (double value) {
            setState(() => seekPosition = value.toInt());
          },
          onChangeStart: (double value) {
            positionStream?.cancel();
          },
          onChangeEnd: (double value) {
            playerHandler.seek(Duration(seconds: value.toInt()));
            positionStream = playerHandler.positionStream.listen((event) {
              setState(() => seekPosition = event.inSeconds);
            });
          },
        ),
        HorizontalWrapper(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$duration'),
              Text('$seekPosition'),
            ],
          ),
        ),
      ],
    );
  }
}
