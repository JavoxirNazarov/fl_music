import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:top_music/common/entities/track/track.dart';

enum DownloadItemType { image, track }

class DownloadedTrack {
  const DownloadedTrack({required this.audioPath, required this.imagePath});

  final String? audioPath;
  final String? imagePath;
}

class DownloadService {
  const DownloadService();

  static late Directory _audioDirectoy;
  static late Directory _imageDirectoy;

  static initDirectories() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    _imageDirectoy = await Directory('$dir/img/').create(recursive: true);
    _audioDirectoy = await Directory('$dir/audio/').create(recursive: true);
  }

  String _getExtension(String url) => url.substring(url.lastIndexOf('.'));

  Future<bool> _checkExists(String path) {
    File file = File(path);
    return file.exists();
  }

  Future<String> _getPath(Track track, DownloadItemType type) async {
    Map<DownloadItemType, String> pathMap = {
      DownloadItemType.image:
          '${_imageDirectoy.path}${track.id}${_getExtension(track.image)}',
      DownloadItemType.track:
          '${_audioDirectoy.path}${track.id}${_getExtension(track.audioUrl)}'
    };

    return pathMap[type]!;
  }

  Future<DownloadedTrack> downloadTrack({required Track track}) async {
    String audioPath = await _getPath(track, DownloadItemType.track);
    String imagePath = await _getPath(track, DownloadItemType.image);

    File audioFile = File(audioPath);
    File imageFile = File(imagePath);

    var request = await http.get(Uri.parse(track.audioUrl));
    var bytes = request.bodyBytes;
    await audioFile.writeAsBytes(bytes);

    var imageRequest = await http.get(Uri.parse(track.image));
    var imageBytes = imageRequest.bodyBytes;
    await imageFile.writeAsBytes(imageBytes);

    return DownloadedTrack(audioPath: audioPath, imagePath: imagePath);
  }

  Future<DownloadedTrack> getTrackIfDowloaded({required Track track}) async {
    String audioPath = await _getPath(track, DownloadItemType.track);
    String imagePath = await _getPath(track, DownloadItemType.image);

    return DownloadedTrack(
      audioPath: await _checkExists(audioPath) ? audioPath : null,
      imagePath: await _checkExists(imagePath) ? imagePath : null,
    );
  }

  Future<void> deleteTrackFromDownloads({required Track track}) async {
    String audioPath = await _getPath(track, DownloadItemType.track);
    String imagePath = await _getPath(track, DownloadItemType.image);

    File audioFile = File(audioPath);
    File imageFile = File(imagePath);

    await Future.wait([audioFile.delete(), imageFile.delete()]);
  }
}
