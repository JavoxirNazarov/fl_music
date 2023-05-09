import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:top_music/common/entities/track/track.dart';

part 'album.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class Album extends Equatable {
  final int id;
  final String title;
  @JsonKey(name: "image")
  final String imageBackground;
  final List<Track> tracks;

  const Album({
    required this.id,
    required this.imageBackground,
    required this.tracks,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  @override
  List<Object?> get props => [id, tracks];

  Album copyWith({
    int? id,
    String? imageBackground,
    List<Track>? tracks,
    String? title,
  }) {
    return Album(
      id: id ?? this.id,
      imageBackground: imageBackground ?? this.imageBackground,
      tracks: tracks ?? this.tracks,
      title: title ?? this.title,
    );
  }
}
