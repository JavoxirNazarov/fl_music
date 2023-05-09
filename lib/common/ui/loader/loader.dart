import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      "assets/animations/loader.gif",
      width: 75,
      height: 75,
    ));
  }
}
