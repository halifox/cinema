// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CmsResponseDto _$CmsResponseDtoFromJson(Map<String, dynamic> json) =>
    _CmsResponseDto(
      code: json['code'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['code']),
      message: json['msg'] == null
          ? ''
          : const FlexibleStringConverter().fromJson(json['msg']),
      page: json['page'] == null
          ? 1
          : const FlexibleIntConverter().fromJson(json['page']),
      pageCount: json['pagecount'] == null
          ? 1
          : const FlexibleIntConverter().fromJson(json['pagecount']),
      limit: json['limit'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['limit']),
      total: json['total'] == null
          ? 0
          : const FlexibleIntConverter().fromJson(json['total']),
      items: json['list'] == null
          ? const <VodItem>[]
          : const VodItemListConverter().fromJson(json['list']),
      categories: json['class'] == null
          ? const <CmsCategory>[]
          : const CmsCategoryListConverter().fromJson(json['class']),
    );

Map<String, dynamic> _$CmsResponseDtoToJson(_CmsResponseDto instance) =>
    <String, dynamic>{
      'code': const FlexibleIntConverter().toJson(instance.code),
      'msg': const FlexibleStringConverter().toJson(instance.message),
      'page': const FlexibleIntConverter().toJson(instance.page),
      'pagecount': const FlexibleIntConverter().toJson(instance.pageCount),
      'limit': const FlexibleIntConverter().toJson(instance.limit),
      'total': const FlexibleIntConverter().toJson(instance.total),
      'list': const VodItemListConverter().toJson(instance.items),
      'class': const CmsCategoryListConverter().toJson(instance.categories),
    };

_CmsCategory _$CmsCategoryFromJson(Map<String, dynamic> json) => _CmsCategory(
  id: json['type_id'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['type_id']),
  parentId: json['type_pid'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['type_pid']),
  name: json['type_name'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['type_name']),
);

Map<String, dynamic> _$CmsCategoryToJson(_CmsCategory instance) =>
    <String, dynamic>{
      'type_id': const FlexibleIntConverter().toJson(instance.id),
      'type_pid': const FlexibleIntConverter().toJson(instance.parentId),
      'type_name': const FlexibleStringConverter().toJson(instance.name),
    };

_VodItem _$VodItemFromJson(Map<String, dynamic> json) => _VodItem(
  id: json['vod_id'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['vod_id']),
  typeId: json['type_id'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['type_id']),
  parentTypeId: json['type_id_1'] == null
      ? 0
      : const FlexibleIntConverter().fromJson(json['type_id_1']),
  name: json['vod_name'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_name']),
  typeName: json['type_name'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['type_name']),
  picture: json['vod_pic'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_pic']),
  remarks: json['vod_remarks'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_remarks']),
  year: json['vod_year'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_year']),
  area: json['vod_area'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_area']),
  language: json['vod_lang'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_lang']),
  score: json['vod_score'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_score']),
  doubanScore: json['vod_douban_score'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_douban_score']),
  actor: json['vod_actor'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_actor']),
  director: json['vod_director'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_director']),
  category: json['vod_class'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_class']),
  summary: readVodSummary(json, 'vod_blurb') == null
      ? ''
      : const CmsTextConverter().fromJson(readVodSummary(json, 'vod_blurb')),
  duration: json['vod_duration'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_duration']),
  playFrom: json['vod_play_from'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_play_from']),
  playUrl: json['vod_play_url'] == null
      ? ''
      : const FlexibleStringConverter().fromJson(json['vod_play_url']),
);

Map<String, dynamic> _$VodItemToJson(_VodItem instance) => <String, dynamic>{
  'vod_id': const FlexibleIntConverter().toJson(instance.id),
  'type_id': const FlexibleIntConverter().toJson(instance.typeId),
  'type_id_1': const FlexibleIntConverter().toJson(instance.parentTypeId),
  'vod_name': const FlexibleStringConverter().toJson(instance.name),
  'type_name': const FlexibleStringConverter().toJson(instance.typeName),
  'vod_pic': const FlexibleStringConverter().toJson(instance.picture),
  'vod_remarks': const FlexibleStringConverter().toJson(instance.remarks),
  'vod_year': const FlexibleStringConverter().toJson(instance.year),
  'vod_area': const FlexibleStringConverter().toJson(instance.area),
  'vod_lang': const FlexibleStringConverter().toJson(instance.language),
  'vod_score': const FlexibleStringConverter().toJson(instance.score),
  'vod_douban_score': const FlexibleStringConverter().toJson(
    instance.doubanScore,
  ),
  'vod_actor': const FlexibleStringConverter().toJson(instance.actor),
  'vod_director': const FlexibleStringConverter().toJson(instance.director),
  'vod_class': const FlexibleStringConverter().toJson(instance.category),
  'vod_blurb': const CmsTextConverter().toJson(instance.summary),
  'vod_duration': const FlexibleStringConverter().toJson(instance.duration),
  'vod_play_from': const FlexibleStringConverter().toJson(instance.playFrom),
  'vod_play_url': const FlexibleStringConverter().toJson(instance.playUrl),
};
