import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_music/common/ui/mini_circle_button/mini_circle_button.dart';
import 'package:top_music/common/ui/touchable/touchable.dart';
import 'package:top_music/feauteres/home/domain/entities/album_module_item.dart';
import 'package:top_music/feauteres/navigation/navigation.dart';
import 'package:top_music/resources/fonts.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({super.key, required this.album});

  final AlbumModuleItem album;

  void _goToAlbum(BuildContext context, int id) {
    context.push(AppRouteNames.album(id));
  }

  @override
  Widget build(BuildContext context) {
    return Touchable(
      nested: true,
      onPress: () => _goToAlbum(context, album.id),
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    color: Color.fromARGB(31, 0, 0, 0),
                  )
                ],
                image: DecorationImage(
                  image: album.image != null
                      ? NetworkImage(album.image!)
                      : const AssetImage('assets/images/album_cover.jpg')
                          as ImageProvider,
                ),
              ),
              child: Align(
                alignment: const Alignment(-0.9, 0.9),
                child: Touchable(
                  nested: true,
                  onPress: () => print('object2'),
                  child: const MiniCircleButton(),
                ),
              ),
            ),
            Text(
              album.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: Fonts.sen,
                fontSize: 16,
                color: Color(0xff191C1C),
              ),
            ),
            Text(
              album.artistName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: Fonts.sen,
                fontSize: 14,
                color: Color(0xff8B8C8C),
              ),
            )
          ],
        ),
      ),
    );
  }
}
