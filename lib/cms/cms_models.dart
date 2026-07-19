import 'package:freezed_annotation/freezed_annotation.dart';

import 'cms_json_converters.dart';

part 'cms_models.freezed.dart';
part 'cms_models.g.dart';

@freezed
abstract class CmsResponseDto with _$CmsResponseDto {
  const factory CmsResponseDto({
    @FlexibleIntConverter() @Default(0) int code,
    @JsonKey(name: 'msg')
    @FlexibleStringConverter()
    @Default('')
    String message,
    @FlexibleIntConverter() @Default(1) int page,
    @JsonKey(name: 'pagecount')
    @FlexibleIntConverter()
    @Default(1)
    int pageCount,
    @FlexibleIntConverter() @Default(0) int limit,
    @FlexibleIntConverter() @Default(0) int total,
    @JsonKey(name: 'list')
    @VodItemListConverter()
    @Default(<VodItem>[])
    List<VodItem> items,
    @JsonKey(name: 'class')
    @CmsCategoryListConverter()
    @Default(<CmsCategory>[])
    List<CmsCategory> categories,
  }) = _CmsResponseDto;

  factory CmsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CmsResponseDtoFromJson(json);
}

@freezed
abstract class CmsCategory with _$CmsCategory {
  const factory CmsCategory({
    @JsonKey(name: 'type_id') @FlexibleIntConverter() @Default(0) int id,
    @JsonKey(name: 'type_pid') @FlexibleIntConverter() @Default(0) int parentId,
    @JsonKey(name: 'type_name')
    @FlexibleStringConverter()
    @Default('')
    String name,
  }) = _CmsCategory;

  factory CmsCategory.fromJson(Map<String, dynamic> json) =>
      _$CmsCategoryFromJson(json);
}

@freezed
abstract class VodItem with _$VodItem {
  const factory VodItem({
    @JsonKey(name: 'vod_id') @FlexibleIntConverter() @Default(0) int id,
    @JsonKey(name: 'type_id') @FlexibleIntConverter() @Default(0) int typeId,
    @JsonKey(name: 'type_id_1')
    @FlexibleIntConverter()
    @Default(0)
    int parentTypeId,
    @JsonKey(name: 'vod_name')
    @FlexibleStringConverter()
    @Default('')
    String name,
    @JsonKey(name: 'type_name')
    @FlexibleStringConverter()
    @Default('')
    String typeName,
    @JsonKey(name: 'vod_pic')
    @FlexibleStringConverter()
    @Default('')
    String picture,
    @JsonKey(name: 'vod_remarks')
    @FlexibleStringConverter()
    @Default('')
    String remarks,
    @JsonKey(name: 'vod_year')
    @FlexibleStringConverter()
    @Default('')
    String year,
    @JsonKey(name: 'vod_area')
    @FlexibleStringConverter()
    @Default('')
    String area,
    @JsonKey(name: 'vod_lang')
    @FlexibleStringConverter()
    @Default('')
    String language,
    @JsonKey(name: 'vod_score')
    @FlexibleStringConverter()
    @Default('')
    String score,
    @JsonKey(name: 'vod_douban_score')
    @FlexibleStringConverter()
    @Default('')
    String doubanScore,
    @JsonKey(name: 'vod_actor')
    @FlexibleStringConverter()
    @Default('')
    String actor,
    @JsonKey(name: 'vod_director')
    @FlexibleStringConverter()
    @Default('')
    String director,
    @JsonKey(name: 'vod_class')
    @FlexibleStringConverter()
    @Default('')
    String category,
    @JsonKey(name: 'vod_blurb', readValue: readVodSummary)
    @CmsTextConverter()
    @Default('')
    String summary,
    @JsonKey(name: 'vod_duration')
    @FlexibleStringConverter()
    @Default('')
    String duration,
    @JsonKey(name: 'vod_play_from')
    @FlexibleStringConverter()
    @Default('')
    String playFrom,
    @JsonKey(name: 'vod_play_url')
    @FlexibleStringConverter()
    @Default('')
    String playUrl,
  }) = _VodItem;

  factory VodItem.fromJson(Map<String, dynamic> json) =>
      _$VodItemFromJson(json);
}

extension VodItemPresentation on VodItem {
  String get displayScore {
    if (doubanScore.isNotEmpty && doubanScore != '0.0') return doubanScore;
    if (score.isNotEmpty && score != '0.0') return score;
    return '';
  }
}

class CmsPage<T> {
  const CmsPage({
    required this.page,
    required this.pageCount,
    required this.total,
    required this.items,
    this.categories = const [],
  });

  final int page;
  final int pageCount;
  final int total;
  final List<T> items;
  final List<CmsCategory> categories;

  bool get hasMore => page < pageCount;
}

extension CmsResponseMapping on CmsResponseDto {
  CmsPage<VodItem> toPage({bool includeCategories = false}) {
    if (code != 1) {
      throw StateError(message.isEmpty ? '请求失败' : message);
    }
    return CmsPage<VodItem>(
      page: page,
      pageCount: pageCount,
      total: total,
      items: items,
      categories: includeCategories ? categories : const [],
    );
  }
}

class PlayEpisode {
  const PlayEpisode({required this.name, required this.url});

  final String name;
  final String url;
}

class PlaySource {
  const PlaySource({required this.name, required this.episodes});

  final String name;
  final List<PlayEpisode> episodes;
}

List<PlaySource> parsePlaySources({
  required String playFrom,
  required String playUrl,
}) {
  final names = playFrom.split(r'$$$');
  final groups = playUrl.split(r'$$$');
  return List.generate(groups.length, (groupIndex) {
    final episodes = groups[groupIndex]
        .split('#')
        .map((entry) {
          final separator = entry.indexOf(r'$');
          if (separator <= 0 || separator == entry.length - 1) return null;
          return PlayEpisode(
            name: entry.substring(0, separator).trim(),
            url: entry.substring(separator + 1).trim(),
          );
        })
        .whereType<PlayEpisode>()
        .toList(growable: false);
    return PlaySource(
      name: groupIndex < names.length && names[groupIndex].trim().isNotEmpty
          ? names[groupIndex].trim()
          : '线路 ${groupIndex + 1}',
      episodes: episodes,
    );
  }).where((source) => source.episodes.isNotEmpty).toList(growable: false);
}

Object? readVodSummary(Map<dynamic, dynamic> json, String key) {
  final blurb = FlexibleStringConverter().fromJson(json['vod_blurb']);
  return blurb.isNotEmpty ? blurb : json['vod_content'];
}

class VodItemListConverter implements JsonConverter<List<VodItem>, Object?> {
  const VodItemListConverter();

  @override
  List<VodItem> fromJson(Object? json) {
    if (json is! List) return const [];
    return json
        .whereType<Map>()
        .map((item) => VodItem.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }

  @override
  Object toJson(List<VodItem> object) {
    return object.map((item) => item.toJson()).toList(growable: false);
  }
}

class CmsCategoryListConverter
    implements JsonConverter<List<CmsCategory>, Object?> {
  const CmsCategoryListConverter();

  @override
  List<CmsCategory> fromJson(Object? json) {
    if (json is! List) return const [];
    return json
        .whereType<Map>()
        .map((item) => CmsCategory.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }

  @override
  Object toJson(List<CmsCategory> object) {
    return object.map((item) => item.toJson()).toList(growable: false);
  }
}
