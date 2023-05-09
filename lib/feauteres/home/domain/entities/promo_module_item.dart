import 'package:top_music/common/entities/image_thumb.dart';
import 'package:top_music/theming/app_styles.dart';

class PromoModuleItem {
  final String url;
  final String image;

  const PromoModuleItem({
    required this.url,
    required this.image,
  });

  factory PromoModuleItem.fromJson(Map<String, dynamic> json) {
    List<ImageThumb> thumbs = (json['thumbs'] as List<dynamic>)
        .map((el) => ImageThumb.fromJson(el))
        .toList();

    final ImageThumb image = thumbs.firstWhere(
        (element) => element.height <= AppStyles.sizes.promoImageMinimalSize,
        orElse: () => thumbs[0]);

    return PromoModuleItem(
      image: image.url,
      url: json['url'],
    );
  }
}
