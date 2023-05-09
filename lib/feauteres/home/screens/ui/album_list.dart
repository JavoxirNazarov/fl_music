import 'package:flutter/material.dart';
import 'package:top_music/common/ui/album_card/album_card.dart';
import 'package:top_music/feauteres/home/domain/entities/album_module_item.dart';

class ALbumList extends StatelessWidget {
  const ALbumList({super.key, required this.list});

  final List<AlbumModuleItem> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20.0),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: AlbumCard(album: list[index]),
          );
        },
      ),
    );
  }
}
