import 'package:json_annotation/json_annotation.dart';
part 'home_screen_module.g.dart';

enum HomeModuleTypes {
  promo,
  album,
  playlist,
  extendedPlaylist,
  artist,
  track,
  genre,
  category,
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class HomeModule {
  final String model;
  final String title;
  final HomeModuleParams params;

  @JsonKey(includeFromJson: false)
  HomeModuleTypes? type;
  @JsonKey(includeFromJson: false)
  List<dynamic> data = [];

  HomeModule({
    required this.model,
    required this.title,
    required this.params,
    this.type,
  });

  factory HomeModule.fromJson(Map<String, dynamic> json) =>
      _$HomeModuleFromJson(json);
}

@JsonSerializable(createToJson: false)
class HomeModuleParams {
  @JsonKey(name: "x_link")
  final String link;

  @JsonKey(name: "x_type")
  final String? type;

  @JsonKey(name: "x_subscriptions")
  final bool? subscriptions;

  @JsonKey(name: "x_categories")
  final List<String>? categories;

  const HomeModuleParams({
    required this.type,
    required this.link,
    required this.subscriptions,
    required this.categories,
  });

  factory HomeModuleParams.fromJson(Map<String, dynamic> json) =>
      _$HomeModuleParamsFromJson(json);
}
