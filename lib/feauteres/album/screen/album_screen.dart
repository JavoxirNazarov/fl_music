import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_music/common/entities/track/track.dart';
import 'package:top_music/common/ui/button/button.dart';
import 'package:top_music/common/ui/loader/loader.dart';
import 'package:top_music/feauteres/album/domain/entities/album.dart';
import 'package:top_music/feauteres/album/screen/bloc/album_screen_bloc.dart';
import 'package:top_music/feauteres/album/screen/ui/animated_header.dart';
import 'package:top_music/feauteres/player/provider/player_provider.dart';
import 'package:top_music/feauteres/player/screens/player_screen.dart';
import 'package:top_music/resources/icons.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({
    super.key,
  });

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  bool _collapsed = false;

  @override
  void initState() {
    // AlbumScreenViewModel viewModel = context.read<AlbumScreenViewModel>();
    // viewModel.getAlbumById(widget.albumId);

    super.initState();
  }

  bool _scrollListener(PointerMoveEvent e) {
    if (e.delta.dy < 5 && _collapsed) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => setState(() => _collapsed = false));
    } else if (e.delta.dy > 5 && !_collapsed) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => setState(() => _collapsed = true));
    }

    return true;
  }

  Future<void> _playAlbum(
      BuildContext context, List<Track> tracks, int? trackIndex) async {
    final playerProvider = context.read<PlayerProvider>();
    await playerProvider.startTracks(tracks: tracks, playIndex: trackIndex);
    if (mounted) {
      showPlayerScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumScreenBloc, AlbumScreenBlocState>(
      builder: (context, state) {
        if (state.loadingStatus == LoadingStatus.initial) {
          return const Loader();
        }

        Album album = state.album!;
        List<Track> tracks = album.tracks;

        return Column(
          children: [
            AnimatedHeader(
              collapsed: _collapsed,
              imageBackground: album.imageBackground,
              title: album.title,
            ),
            AppButton(
              child: const Text('downlaoad'),
              onPress: () => context
                  .read<AlbumScreenBloc>()
                  .add(DownloadAlbumTracks(tracks: tracks)),
            ),
            Expanded(
              child: Listener(
                // onPointerDown: (event) {
                //   print(event.position.dy);
                // },
                onPointerMove: _scrollListener,
                // onPointerUp: (event) {
                //   print('delta ${event.delta.dy}');
                //   print('offset ${event.position.dy}');
                // },
                // onNotification: _scrollListener,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final track = tracks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (track.downloadedAudioPath != null)
                            Container(
                              color: Colors.amber,
                              width: 10,
                              height: 10,
                            ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              index.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              track.title,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _playAlbum(context, tracks, index),
                            child: const Icon(AppIcons.like),
                          ),
                          GestureDetector(
                            onTap: () => context
                                .read<AlbumScreenBloc>()
                                .add(DownloadTrack(track: track)),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(AppIcons.menu),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: tracks.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
