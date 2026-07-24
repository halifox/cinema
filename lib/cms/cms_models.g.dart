// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CmsResponseDto _$CmsResponseDtoFromJson(Map<String, dynamic> json) =>
    _CmsResponseDto(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['msg'] as String? ?? '',
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageCount: (json['pagecount'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      items:
          (json['list'] as List<dynamic>?)
              ?.map((e) => VodItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categories:
          (json['class'] as List<dynamic>?)
              ?.map((e) => CmsCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CmsResponseDtoToJson(_CmsResponseDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.message,
      'page': instance.page,
      'pagecount': instance.pageCount,
      'limit': instance.limit,
      'total': instance.total,
      'list': instance.items,
      'class': instance.categories,
    };

_CmsCategory _$CmsCategoryFromJson(Map<String, dynamic> json) => _CmsCategory(
  id: (json['type_id'] as num?)?.toInt() ?? 0,
  parentId: (json['type_pid'] as num?)?.toInt() ?? 0,
  name: json['type_name'] as String? ?? '',
);

Map<String, dynamic> _$CmsCategoryToJson(_CmsCategory instance) =>
    <String, dynamic>{
      'type_id': instance.id,
      'type_pid': instance.parentId,
      'type_name': instance.name,
    };

_VodItem _$VodItemFromJson(Map<String, dynamic> json) => _VodItem(
  id: (json['vod_id'] as num?)?.toInt() ?? 0,
  typeId: (json['type_id'] as num?)?.toInt() ?? 0,
  parentTypeId: (json['type_id_1'] as num?)?.toInt() ?? 0,
  name: json['vod_name'] as String? ?? '',
  typeName: json['type_name'] as String? ?? '',
  picture: json['vod_pic'] as String? ?? '',
  remarks: json['vod_remarks'] as String? ?? '',
  year: json['vod_year'] as String? ?? '',
  area: json['vod_area'] as String? ?? '',
  language: json['vod_lang'] as String? ?? '',
  score: json['vod_score'] as String? ?? '',
  doubanScore: json['vod_douban_score'] as String? ?? '',
  actor: json['vod_actor'] as String? ?? '',
  director: json['vod_director'] as String? ?? '',
  category: json['vod_class'] as String? ?? '',
  summary: json['vod_content'] as String? ?? '',
  duration: json['vod_duration'] as String? ?? '',
  playFrom: json['vod_play_from'] as String? ?? '',
  playUrl: json['vod_play_url'] as String? ?? '',
);

Map<String, dynamic> _$VodItemToJson(_VodItem instance) => <String, dynamic>{
  'vod_id': instance.id,
  'type_id': instance.typeId,
  'type_id_1': instance.parentTypeId,
  'vod_name': instance.name,
  'type_name': instance.typeName,
  'vod_pic': instance.picture,
  'vod_remarks': instance.remarks,
  'vod_year': instance.year,
  'vod_area': instance.area,
  'vod_lang': instance.language,
  'vod_score': instance.score,
  'vod_douban_score': instance.doubanScore,
  'vod_actor': instance.actor,
  'vod_director': instance.director,
  'vod_class': instance.category,
  'vod_content': instance.summary,
  'vod_duration': instance.duration,
  'vod_play_from': instance.playFrom,
  'vod_play_url': instance.playUrl,
};
