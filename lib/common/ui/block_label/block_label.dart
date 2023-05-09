import 'package:flutter/material.dart';

class BlockLabel extends StatelessWidget {
  const BlockLabel({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xff191C1C),
      ),
    );
  }
}
