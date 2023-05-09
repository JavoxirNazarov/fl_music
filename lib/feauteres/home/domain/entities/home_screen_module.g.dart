// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModule _$HomeModuleFromJson(Map<String, dynamic> json) => HomeModule(
      model: json['model'] as String,
      title: json['title'] as String,
      params: HomeModuleParams.fromJson(json['params'] as Map<String, dynamic>),
    );

HomeModuleParams _$HomeModuleParamsFromJson(Map<String, dynamic> json) =>
    HomeModuleParams(
      type: json['x_type'] as String?,
      link: json['x_link'] as String,
      subscriptions: json['x_subscriptions'] as bool?,
      categories: (json['x_categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
