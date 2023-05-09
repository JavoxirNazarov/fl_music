import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_music/common/ui/touchable/touchable.dart';
import 'package:top_music/feauteres/home/domain/entities/artist_module_item.dart';
import 'package:top_music/feauteres/navigation/navigation.dart';
import 'package:top_music/resources/fonts.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({super.key, required this.artist});

  final ArtistModuleItem artist;

  void _goToAlbum(BuildContext context, int id) {
    context.push(AppRouteNames.album(id));
  }

  @override
  Widget build(BuildContext context) {
    return Touchable(
      // onPress: () => _goToAlbum(context, artist.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(70)),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  color: Color.fromARGB(31, 0, 0, 0),
                )
              ],
              image: DecorationImage(
                image: artist.image != null
                    ? NetworkImage(artist.image!)
                    : const AssetImage('assets/images/album_cover.jpg')
                        as ImageProvider,
              ),
            ),
          ),
          Text(
            artist.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: Fonts.sen,
              fontSize: 16,
              color: Color(0xff191C1C),
            ),
          ),
        ],
      ),
    );
  }
}
