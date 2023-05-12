import 'package:flutter/material.dart';
import 'package:top_music/common/ui/block_label/block_label.dart';
import 'package:top_music/common/ui/loader/loader.dart';
import 'package:top_music/feauteres/auth/services/session_store.dart';
import 'package:top_music/feauteres/home/domain/api/home_api_client.dart';
import 'package:top_music/feauteres/home/domain/entities/album_module_item.dart';
import 'package:top_music/feauteres/home/domain/entities/artist_module_item.dart';
import 'package:top_music/feauteres/home/domain/entities/home_screen_module.dart';
import 'package:top_music/feauteres/home/domain/entities/promo_module_item.dart';
import 'package:top_music/feauteres/home/screens/ui/album_list.dart';
import 'package:top_music/feauteres/home/screens/ui/artist_list.dart';
import 'package:top_music/feauteres/home/screens/ui/banner_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.homeApiClient,
    required this.sessionStore,
  });

  final HomeApiClient homeApiClient;
  final SessionStore sessionStore;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeModule> _modules = [];

  @override
  void initState() {
    _getHomePage();
    super.initState();
  }

  Future<void> _getHomePage() async {
    final res = await widget.homeApiClient.getHomePage(
      sessionToken: widget.sessionStore.getSession(),
    );
    setState(() => _modules = res);
  }

  Widget renderRow(HomeModule module) {
    if (module.type == HomeModuleTypes.artist) {
      return ArtistLst(list: module.data as List<ArtistModuleItem>);
    }

    if (module.type == HomeModuleTypes.promo) {
      return BannerList(list: module.data as List<PromoModuleItem>);
    }

    if (module.type == HomeModuleTypes.album) {
      return ALbumList(list: module.data as List<AlbumModuleItem>);
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: _modules.isEmpty
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: _modules
                    .map(
                      (module) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              bottom: 12,
                              top: 12,
                            ),
                            child: BlockLabel(title: module.title),
                          ),
                          renderRow(module)
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
