import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable(explicitToJson: false)
class Track {
  final int id;
  final String title;
  final String image;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? downloadedAudioPath;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? downloadedImagePath;

  @JsonKey(name: "low")
  final String audioUrl;

  Track({
    required this.id,
    required this.title,
    required this.image,
    required this.audioUrl,
    this.downloadedAudioPath,
    this.downloadedImagePath,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Track copyWith({
    int? id,
    String? title,
    String? image,
    String? audioUrl,
    String? downloadedAudioPath,
    String? downloadedImagePath,
  }) {
    return Track(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      audioUrl: audioUrl ?? this.audioUrl,
      downloadedAudioPath: downloadedAudioPath ?? this.downloadedAudioPath,
      downloadedImagePath: downloadedImagePath ?? this.downloadedImagePath,
    );
  }
}
