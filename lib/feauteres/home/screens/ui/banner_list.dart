import 'package:flutter/material.dart';
import 'package:top_music/common/ui/touchable/touchable.dart';
import 'package:top_music/feauteres/home/domain/entities/promo_module_item.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerList extends StatelessWidget {
  const BannerList({super.key, required this.list});

  final List<PromoModuleItem> list;

  _launchUrl(String uriString) {
    launchUrl(Uri.parse(uriString), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 146,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20.0),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Touchable(
            onPress: () => _launchUrl(list[index].url),
            child: Container(
              width: 260,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: DecorationImage(image: NetworkImage(list[index].image)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
