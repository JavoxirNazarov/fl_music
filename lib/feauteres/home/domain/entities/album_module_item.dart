import 'package:top_music/common/entities/image_thumb.dart';
import 'package:top_music/theming/app_styles.dart';

class AlbumModuleItem {
  final int id;

  final String? image;
  final String title;
  final String artistName;

  const AlbumModuleItem({
    required this.image,
    required this.id,
    required this.title,
    required this.artistName,
  });

  factory AlbumModuleItem.fromJson(Map<String, dynamic> json) {
    List<ImageThumb>? thumbs = json['thumbs'] == null
        ? null
        : (json['thumbs'] as List<dynamic>)
            .map((el) => ImageThumb.fromJson(el))
            .toList();

    final ImageThumb? image = thumbs?.firstWhere(
        (element) => element.height <= AppStyles.sizes.moduleImageMinimalSize,
        orElse: () => thumbs[0]);

    List<dynamic> artists = json['artists'] ?? json['authors'];

    return AlbumModuleItem(
      id: json['django_id'],
      image: image?.url,
      title: json['title'],
      artistName: artists[0]['name'],
    );
  }
}
