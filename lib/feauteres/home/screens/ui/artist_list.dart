import 'package:flutter/material.dart';
import 'package:top_music/common/ui/artist_card/artist_card.dart';
import 'package:top_music/feauteres/home/domain/entities/artist_module_item.dart';

class ArtistLst extends StatelessWidget {
  const ArtistLst({super.key, required this.list});

  final List<ArtistModuleItem> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20.0),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ArtistCard(artist: list[index]),
          );
        },
      ),
    );
  }
}
