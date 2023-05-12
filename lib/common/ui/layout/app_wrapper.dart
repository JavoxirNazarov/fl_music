import 'package:flutter/material.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';
import 'package:top_music/resources/fonts.dart';
import 'package:provider/provider.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: Fonts.sen,
            color: Color(0xff191C1C),
          ),
          child: ChangeNotifierProvider(
            create: (_) => PlayerProvider(),
            child: child,
          ),
        ),
      ),
    );
  }
}
