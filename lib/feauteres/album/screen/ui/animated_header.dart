import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'package:top_music/resources/icons.dart';

class AnimatedHeader extends StatelessWidget {
  const AnimatedHeader({
    super.key,
    required this.collapsed,
    required this.imageBackground,
    required this.title,
  });

  final bool collapsed;
  final String? imageBackground;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      duration: const Duration(milliseconds: 300),
      height: collapsed ? 132 : 262,
      width: double.infinity,
      child: Stack(
        children: [
          if (imageBackground != null)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: collapsed ? 0 : 1,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Image.network(
                  width: double.infinity,
                  imageBackground!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(AppIcons.arrowBack),
                  ),
                  if (title != null)
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: collapsed ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          title!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff191C1C),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  const Icon(AppIcons.like)
                ],
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   height: 48,
            //   decoration: const BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(20),
            //       topRight: Radius.circular(20),
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color.fromRGBO(0, 0, 0, 0.08),
            //         blurRadius: 4,
            //         offset: Offset(0, -2),
            //       )
            //     ],
            //   ),
            //   child: const SizedBox.shrink(),
            // ),
          ]),
        ],
      ),
    );
  }
}
