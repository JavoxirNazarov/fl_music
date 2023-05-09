import 'package:flutter/material.dart';
import 'package:top_music/common/ui/gradient_icon/gradient_icon.dart';
import 'package:top_music/resources/icons.dart';

class MiniCircleButton extends StatelessWidget {
  const MiniCircleButton({super.key, this.isPlaying = false});

  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Colors.white,
      ),
      child: GradientIcon(
        icon: isPlaying ? AppIcons.pause : AppIcons.play,
        size: 12,
      ),
    );
  }
}
