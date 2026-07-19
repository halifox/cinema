// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cms_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CmsResponseDto {

@FlexibleIntConverter() int get code;@JsonKey(name: 'msg')@FlexibleStringConverter() String get message;@FlexibleIntConverter() int get page;@JsonKey(name: 'pagecount')@FlexibleIntConverter() int get pageCount;@FlexibleIntConverter() int get limit;@FlexibleIntConverter() int get total;@JsonKey(name: 'list')@VodItemListConverter() List<VodItem> get items;@JsonKey(name: 'class')@CmsCategoryListConverter() List<CmsCategory> get categories;
/// Create a copy of CmsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsResponseDtoCopyWith<CmsResponseDto> get copyWith => _$CmsResponseDtoCopyWithImpl<CmsResponseDto>(this as CmsResponseDto, _$identity);

  /// Serializes this CmsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsResponseDto&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,page,pageCount,limit,total,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'CmsResponseDto(code: $code, message: $message, page: $page, pageCount: $pageCount, limit: $limit, total: $total, items: $items, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CmsResponseDtoCopyWith<$Res>  {
  factory $CmsResponseDtoCopyWith(CmsResponseDto value, $Res Function(CmsResponseDto) _then) = _$CmsResponseDtoCopyWithImpl;
@useResult
$Res call({
@FlexibleIntConverter() int code,@JsonKey(name: 'msg')@FlexibleStringConverter() String message,@FlexibleIntConverter() int page,@JsonKey(name: 'pagecount')@FlexibleIntConverter() int pageCount,@FlexibleIntConverter() int limit,@FlexibleIntConverter() int total,@JsonKey(name: 'list')@VodItemListConverter() List<VodItem> items,@JsonKey(name: 'class')@CmsCategoryListConverter() List<CmsCategory> categories
});




}
/// @nodoc
class _$CmsResponseDtoCopyWithImpl<$Res>
    implements $CmsResponseDtoCopyWith<$Res> {
  _$CmsResponseDtoCopyWithImpl(this._self, this._then);

  final CmsResponseDto _self;
  final $Res Function(CmsResponseDto) _then;

/// Create a copy of CmsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? page = null,Object? pageCount = null,Object? limit = null,Object? total = null,Object? items = null,Object? categories = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageCount: null == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<VodItem>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CmsCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [CmsResponseDto].
extension CmsResponseDtoPatterns on CmsResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CmsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CmsResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CmsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CmsResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CmsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CmsResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@FlexibleIntConverter()  int code, @JsonKey(name: 'msg')@FlexibleStringConverter()  String message, @FlexibleIntConverter()  int page, @JsonKey(name: 'pagecount')@FlexibleIntConverter()  int pageCount, @FlexibleIntConverter()  int limit, @FlexibleIntConverter()  int total, @JsonKey(name: 'list')@VodItemListConverter()  List<VodItem> items, @JsonKey(name: 'class')@CmsCategoryListConverter()  List<CmsCategory> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsResponseDto() when $default != null:
return $default(_that.code,_that.message,_that.page,_that.pageCount,_that.limit,_that.total,_that.items,_that.categories);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@FlexibleIntConverter()  int code, @JsonKey(name: 'msg')@FlexibleStringConverter()  String message, @FlexibleIntConverter()  int page, @JsonKey(name: 'pagecount')@FlexibleIntConverter()  int pageCount, @FlexibleIntConverter()  int limit, @FlexibleIntConverter()  int total, @JsonKey(name: 'list')@VodItemListConverter()  List<VodItem> items, @JsonKey(name: 'class')@CmsCategoryListConverter()  List<CmsCategory> categories)  $default,) {final _that = this;
switch (_that) {
case _CmsResponseDto():
return $default(_that.code,_that.message,_that.page,_that.pageCount,_that.limit,_that.total,_that.items,_that.categories);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@FlexibleIntConverter()  int code, @JsonKey(name: 'msg')@FlexibleStringConverter()  String message, @FlexibleIntConverter()  int page, @JsonKey(name: 'pagecount')@FlexibleIntConverter()  int pageCount, @FlexibleIntConverter()  int limit, @FlexibleIntConverter()  int total, @JsonKey(name: 'list')@VodItemListConverter()  List<VodItem> items, @JsonKey(name: 'class')@CmsCategoryListConverter()  List<CmsCategory> categories)?  $default,) {final _that = this;
switch (_that) {
case _CmsResponseDto() when $default != null:
return $default(_that.code,_that.message,_that.page,_that.pageCount,_that.limit,_that.total,_that.items,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CmsResponseDto implements CmsResponseDto {
  const _CmsResponseDto({@FlexibleIntConverter() this.code = 0, @JsonKey(name: 'msg')@FlexibleStringConverter() this.message = '', @FlexibleIntConverter() this.page = 1, @JsonKey(name: 'pagecount')@FlexibleIntConverter() this.pageCount = 1, @FlexibleIntConverter() this.limit = 0, @FlexibleIntConverter() this.total = 0, @JsonKey(name: 'list')@VodItemListConverter() final  List<VodItem> items = const <VodItem>[], @JsonKey(name: 'class')@CmsCategoryListConverter() final  List<CmsCategory> categories = const <CmsCategory>[]}): _items = items,_categories = categories;
  factory _CmsResponseDto.fromJson(Map<String, dynamic> json) => _$CmsResponseDtoFromJson(json);

@override@JsonKey()@FlexibleIntConverter() final  int code;
@override@JsonKey(name: 'msg')@FlexibleStringConverter() final  String message;
@override@JsonKey()@FlexibleIntConverter() final  int page;
@override@JsonKey(name: 'pagecount')@FlexibleIntConverter() final  int pageCount;
@override@JsonKey()@FlexibleIntConverter() final  int limit;
@override@JsonKey()@FlexibleIntConverter() final  int total;
 final  List<VodItem> _items;
@override@JsonKey(name: 'list')@VodItemListConverter() List<VodItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<CmsCategory> _categories;
@override@JsonKey(name: 'class')@CmsCategoryListConverter() List<CmsCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CmsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsResponseDtoCopyWith<_CmsResponseDto> get copyWith => __$CmsResponseDtoCopyWithImpl<_CmsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CmsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsResponseDto&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,page,pageCount,limit,total,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CmsResponseDto(code: $code, message: $message, page: $page, pageCount: $pageCount, limit: $limit, total: $total, items: $items, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$CmsResponseDtoCopyWith<$Res> implements $CmsResponseDtoCopyWith<$Res> {
  factory _$CmsResponseDtoCopyWith(_CmsResponseDto value, $Res Function(_CmsResponseDto) _then) = __$CmsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
@FlexibleIntConverter() int code,@JsonKey(name: 'msg')@FlexibleStringConverter() String message,@FlexibleIntConverter() int page,@JsonKey(name: 'pagecount')@FlexibleIntConverter() int pageCount,@FlexibleIntConverter() int limit,@FlexibleIntConverter() int total,@JsonKey(name: 'list')@VodItemListConverter() List<VodItem> items,@JsonKey(name: 'class')@CmsCategoryListConverter() List<CmsCategory> categories
});




}
/// @nodoc
class __$CmsResponseDtoCopyWithImpl<$Res>
    implements _$CmsResponseDtoCopyWith<$Res> {
  __$CmsResponseDtoCopyWithImpl(this._self, this._then);

  final _CmsResponseDto _self;
  final $Res Function(_CmsResponseDto) _then;

/// Create a copy of CmsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? page = null,Object? pageCount = null,Object? limit = null,Object? total = null,Object? items = null,Object? categories = null,}) {
  return _then(_CmsResponseDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageCount: null == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<VodItem>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CmsCategory>,
  ));
}


}


/// @nodoc
mixin _$CmsCategory {

@JsonKey(name: 'type_id')@FlexibleIntConverter() int get id;@JsonKey(name: 'type_pid')@FlexibleIntConverter() int get parentId;@JsonKey(name: 'type_name')@FlexibleStringConverter() String get name;
/// Create a copy of CmsCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CmsCategoryCopyWith<CmsCategory> get copyWith => _$CmsCategoryCopyWithImpl<CmsCategory>(this as CmsCategory, _$identity);

  /// Serializes this CmsCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CmsCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,parentId,name);

@override
String toString() {
  return 'CmsCategory(id: $id, parentId: $parentId, name: $name)';
}


}

/// @nodoc
abstract mixin class $CmsCategoryCopyWith<$Res>  {
  factory $CmsCategoryCopyWith(CmsCategory value, $Res Function(CmsCategory) _then) = _$CmsCategoryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'type_id')@FlexibleIntConverter() int id,@JsonKey(name: 'type_pid')@FlexibleIntConverter() int parentId,@JsonKey(name: 'type_name')@FlexibleStringConverter() String name
});




}
/// @nodoc
class _$CmsCategoryCopyWithImpl<$Res>
    implements $CmsCategoryCopyWith<$Res> {
  _$CmsCategoryCopyWithImpl(this._self, this._then);

  final CmsCategory _self;
  final $Res Function(CmsCategory) _then;

/// Create a copy of CmsCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? parentId = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,parentId: null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CmsCategory].
extension CmsCategoryPatterns on CmsCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CmsCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CmsCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CmsCategory value)  $default,){
final _that = this;
switch (_that) {
case _CmsCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CmsCategory value)?  $default,){
final _that = this;
switch (_that) {
case _CmsCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'type_id')@FlexibleIntConverter()  int id, @JsonKey(name: 'type_pid')@FlexibleIntConverter()  int parentId, @JsonKey(name: 'type_name')@FlexibleStringConverter()  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CmsCategory() when $default != null:
return $default(_that.id,_that.parentId,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'type_id')@FlexibleIntConverter()  int id, @JsonKey(name: 'type_pid')@FlexibleIntConverter()  int parentId, @JsonKey(name: 'type_name')@FlexibleStringConverter()  String name)  $default,) {final _that = this;
switch (_that) {
case _CmsCategory():
return $default(_that.id,_that.parentId,_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'type_id')@FlexibleIntConverter()  int id, @JsonKey(name: 'type_pid')@FlexibleIntConverter()  int parentId, @JsonKey(name: 'type_name')@FlexibleStringConverter()  String name)?  $default,) {final _that = this;
switch (_that) {
case _CmsCategory() when $default != null:
return $default(_that.id,_that.parentId,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CmsCategory implements CmsCategory {
  const _CmsCategory({@JsonKey(name: 'type_id')@FlexibleIntConverter() this.id = 0, @JsonKey(name: 'type_pid')@FlexibleIntConverter() this.parentId = 0, @JsonKey(name: 'type_name')@FlexibleStringConverter() this.name = ''});
  factory _CmsCategory.fromJson(Map<String, dynamic> json) => _$CmsCategoryFromJson(json);

@override@JsonKey(name: 'type_id')@FlexibleIntConverter() final  int id;
@override@JsonKey(name: 'type_pid')@FlexibleIntConverter() final  int parentId;
@override@JsonKey(name: 'type_name')@FlexibleStringConverter() final  String name;

/// Create a copy of CmsCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CmsCategoryCopyWith<_CmsCategory> get copyWith => __$CmsCategoryCopyWithImpl<_CmsCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CmsCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CmsCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,parentId,name);

@override
String toString() {
  return 'CmsCategory(id: $id, parentId: $parentId, name: $name)';
}


}

/// @nodoc
abstract mixin class _$CmsCategoryCopyWith<$Res> implements $CmsCategoryCopyWith<$Res> {
  factory _$CmsCategoryCopyWith(_CmsCategory value, $Res Function(_CmsCategory) _then) = __$CmsCategoryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'type_id')@FlexibleIntConverter() int id,@JsonKey(name: 'type_pid')@FlexibleIntConverter() int parentId,@JsonKey(name: 'type_name')@FlexibleStringConverter() String name
});




}
/// @nodoc
class __$CmsCategoryCopyWithImpl<$Res>
    implements _$CmsCategoryCopyWith<$Res> {
  __$CmsCategoryCopyWithImpl(this._self, this._then);

  final _CmsCategory _self;
  final $Res Function(_CmsCategory) _then;

/// Create a copy of CmsCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? parentId = null,Object? name = null,}) {
  return _then(_CmsCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,parentId: null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VodItem {

@JsonKey(name: 'vod_id')@FlexibleIntConverter() int get id;@JsonKey(name: 'type_id')@FlexibleIntConverter() int get typeId;@JsonKey(name: 'type_id_1')@FlexibleIntConverter() int get parentTypeId;@JsonKey(name: 'vod_name')@FlexibleStringConverter() String get name;@JsonKey(name: 'type_name')@FlexibleStringConverter() String get typeName;@JsonKey(name: 'vod_pic')@FlexibleStringConverter() String get picture;@JsonKey(name: 'vod_remarks')@FlexibleStringConverter() String get remarks;@JsonKey(name: 'vod_year')@FlexibleStringConverter() String get year;@JsonKey(name: 'vod_area')@FlexibleStringConverter() String get area;@JsonKey(name: 'vod_lang')@FlexibleStringConverter() String get language;@JsonKey(name: 'vod_score')@FlexibleStringConverter() String get score;@JsonKey(name: 'vod_douban_score')@FlexibleStringConverter() String get doubanScore;@JsonKey(name: 'vod_actor')@FlexibleStringConverter() String get actor;@JsonKey(name: 'vod_director')@FlexibleStringConverter() String get director;@JsonKey(name: 'vod_class')@FlexibleStringConverter() String get category;@JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter() String get summary;@JsonKey(name: 'vod_duration')@FlexibleStringConverter() String get duration;@JsonKey(name: 'vod_play_from')@FlexibleStringConverter() String get playFrom;@JsonKey(name: 'vod_play_url')@FlexibleStringConverter() String get playUrl;
/// Create a copy of VodItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VodItemCopyWith<VodItem> get copyWith => _$VodItemCopyWithImpl<VodItem>(this as VodItem, _$identity);

  /// Serializes this VodItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VodItem&&(identical(other.id, id) || other.id == id)&&(identical(other.typeId, typeId) || other.typeId == typeId)&&(identical(other.parentTypeId, parentTypeId) || other.parentTypeId == parentTypeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.picture, picture) || other.picture == picture)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.year, year) || other.year == year)&&(identical(other.area, area) || other.area == area)&&(identical(other.language, language) || other.language == language)&&(identical(other.score, score) || other.score == score)&&(identical(other.doubanScore, doubanScore) || other.doubanScore == doubanScore)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.director, director) || other.director == director)&&(identical(other.category, category) || other.category == category)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playFrom, playFrom) || other.playFrom == playFrom)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,typeId,parentTypeId,name,typeName,picture,remarks,year,area,language,score,doubanScore,actor,director,category,summary,duration,playFrom,playUrl]);

@override
String toString() {
  return 'VodItem(id: $id, typeId: $typeId, parentTypeId: $parentTypeId, name: $name, typeName: $typeName, picture: $picture, remarks: $remarks, year: $year, area: $area, language: $language, score: $score, doubanScore: $doubanScore, actor: $actor, director: $director, category: $category, summary: $summary, duration: $duration, playFrom: $playFrom, playUrl: $playUrl)';
}


}

/// @nodoc
abstract mixin class $VodItemCopyWith<$Res>  {
  factory $VodItemCopyWith(VodItem value, $Res Function(VodItem) _then) = _$VodItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'vod_id')@FlexibleIntConverter() int id,@JsonKey(name: 'type_id')@FlexibleIntConverter() int typeId,@JsonKey(name: 'type_id_1')@FlexibleIntConverter() int parentTypeId,@JsonKey(name: 'vod_name')@FlexibleStringConverter() String name,@JsonKey(name: 'type_name')@FlexibleStringConverter() String typeName,@JsonKey(name: 'vod_pic')@FlexibleStringConverter() String picture,@JsonKey(name: 'vod_remarks')@FlexibleStringConverter() String remarks,@JsonKey(name: 'vod_year')@FlexibleStringConverter() String year,@JsonKey(name: 'vod_area')@FlexibleStringConverter() String area,@JsonKey(name: 'vod_lang')@FlexibleStringConverter() String language,@JsonKey(name: 'vod_score')@FlexibleStringConverter() String score,@JsonKey(name: 'vod_douban_score')@FlexibleStringConverter() String doubanScore,@JsonKey(name: 'vod_actor')@FlexibleStringConverter() String actor,@JsonKey(name: 'vod_director')@FlexibleStringConverter() String director,@JsonKey(name: 'vod_class')@FlexibleStringConverter() String category,@JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter() String summary,@JsonKey(name: 'vod_duration')@FlexibleStringConverter() String duration,@JsonKey(name: 'vod_play_from')@FlexibleStringConverter() String playFrom,@JsonKey(name: 'vod_play_url')@FlexibleStringConverter() String playUrl
});




}
/// @nodoc
class _$VodItemCopyWithImpl<$Res>
    implements $VodItemCopyWith<$Res> {
  _$VodItemCopyWithImpl(this._self, this._then);

  final VodItem _self;
  final $Res Function(VodItem) _then;

/// Create a copy of VodItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? typeId = null,Object? parentTypeId = null,Object? name = null,Object? typeName = null,Object? picture = null,Object? remarks = null,Object? year = null,Object? area = null,Object? language = null,Object? score = null,Object? doubanScore = null,Object? actor = null,Object? director = null,Object? category = null,Object? summary = null,Object? duration = null,Object? playFrom = null,Object? playUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,typeId: null == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as int,parentTypeId: null == parentTypeId ? _self.parentTypeId : parentTypeId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,typeName: null == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String,picture: null == picture ? _self.picture : picture // ignore: cast_nullable_to_non_nullable
as String,remarks: null == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String,doubanScore: null == doubanScore ? _self.doubanScore : doubanScore // ignore: cast_nullable_to_non_nullable
as String,actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,playFrom: null == playFrom ? _self.playFrom : playFrom // ignore: cast_nullable_to_non_nullable
as String,playUrl: null == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VodItem].
extension VodItemPatterns on VodItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VodItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VodItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VodItem value)  $default,){
final _that = this;
switch (_that) {
case _VodItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VodItem value)?  $default,){
final _that = this;
switch (_that) {
case _VodItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'vod_id')@FlexibleIntConverter()  int id, @JsonKey(name: 'type_id')@FlexibleIntConverter()  int typeId, @JsonKey(name: 'type_id_1')@FlexibleIntConverter()  int parentTypeId, @JsonKey(name: 'vod_name')@FlexibleStringConverter()  String name, @JsonKey(name: 'type_name')@FlexibleStringConverter()  String typeName, @JsonKey(name: 'vod_pic')@FlexibleStringConverter()  String picture, @JsonKey(name: 'vod_remarks')@FlexibleStringConverter()  String remarks, @JsonKey(name: 'vod_year')@FlexibleStringConverter()  String year, @JsonKey(name: 'vod_area')@FlexibleStringConverter()  String area, @JsonKey(name: 'vod_lang')@FlexibleStringConverter()  String language, @JsonKey(name: 'vod_score')@FlexibleStringConverter()  String score, @JsonKey(name: 'vod_douban_score')@FlexibleStringConverter()  String doubanScore, @JsonKey(name: 'vod_actor')@FlexibleStringConverter()  String actor, @JsonKey(name: 'vod_director')@FlexibleStringConverter()  String director, @JsonKey(name: 'vod_class')@FlexibleStringConverter()  String category, @JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter()  String summary, @JsonKey(name: 'vod_duration')@FlexibleStringConverter()  String duration, @JsonKey(name: 'vod_play_from')@FlexibleStringConverter()  String playFrom, @JsonKey(name: 'vod_play_url')@FlexibleStringConverter()  String playUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VodItem() when $default != null:
return $default(_that.id,_that.typeId,_that.parentTypeId,_that.name,_that.typeName,_that.picture,_that.remarks,_that.year,_that.area,_that.language,_that.score,_that.doubanScore,_that.actor,_that.director,_that.category,_that.summary,_that.duration,_that.playFrom,_that.playUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'vod_id')@FlexibleIntConverter()  int id, @JsonKey(name: 'type_id')@FlexibleIntConverter()  int typeId, @JsonKey(name: 'type_id_1')@FlexibleIntConverter()  int parentTypeId, @JsonKey(name: 'vod_name')@FlexibleStringConverter()  String name, @JsonKey(name: 'type_name')@FlexibleStringConverter()  String typeName, @JsonKey(name: 'vod_pic')@FlexibleStringConverter()  String picture, @JsonKey(name: 'vod_remarks')@FlexibleStringConverter()  String remarks, @JsonKey(name: 'vod_year')@FlexibleStringConverter()  String year, @JsonKey(name: 'vod_area')@FlexibleStringConverter()  String area, @JsonKey(name: 'vod_lang')@FlexibleStringConverter()  String language, @JsonKey(name: 'vod_score')@FlexibleStringConverter()  String score, @JsonKey(name: 'vod_douban_score')@FlexibleStringConverter()  String doubanScore, @JsonKey(name: 'vod_actor')@FlexibleStringConverter()  String actor, @JsonKey(name: 'vod_director')@FlexibleStringConverter()  String director, @JsonKey(name: 'vod_class')@FlexibleStringConverter()  String category, @JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter()  String summary, @JsonKey(name: 'vod_duration')@FlexibleStringConverter()  String duration, @JsonKey(name: 'vod_play_from')@FlexibleStringConverter()  String playFrom, @JsonKey(name: 'vod_play_url')@FlexibleStringConverter()  String playUrl)  $default,) {final _that = this;
switch (_that) {
case _VodItem():
return $default(_that.id,_that.typeId,_that.parentTypeId,_that.name,_that.typeName,_that.picture,_that.remarks,_that.year,_that.area,_that.language,_that.score,_that.doubanScore,_that.actor,_that.director,_that.category,_that.summary,_that.duration,_that.playFrom,_that.playUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'vod_id')@FlexibleIntConverter()  int id, @JsonKey(name: 'type_id')@FlexibleIntConverter()  int typeId, @JsonKey(name: 'type_id_1')@FlexibleIntConverter()  int parentTypeId, @JsonKey(name: 'vod_name')@FlexibleStringConverter()  String name, @JsonKey(name: 'type_name')@FlexibleStringConverter()  String typeName, @JsonKey(name: 'vod_pic')@FlexibleStringConverter()  String picture, @JsonKey(name: 'vod_remarks')@FlexibleStringConverter()  String remarks, @JsonKey(name: 'vod_year')@FlexibleStringConverter()  String year, @JsonKey(name: 'vod_area')@FlexibleStringConverter()  String area, @JsonKey(name: 'vod_lang')@FlexibleStringConverter()  String language, @JsonKey(name: 'vod_score')@FlexibleStringConverter()  String score, @JsonKey(name: 'vod_douban_score')@FlexibleStringConverter()  String doubanScore, @JsonKey(name: 'vod_actor')@FlexibleStringConverter()  String actor, @JsonKey(name: 'vod_director')@FlexibleStringConverter()  String director, @JsonKey(name: 'vod_class')@FlexibleStringConverter()  String category, @JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter()  String summary, @JsonKey(name: 'vod_duration')@FlexibleStringConverter()  String duration, @JsonKey(name: 'vod_play_from')@FlexibleStringConverter()  String playFrom, @JsonKey(name: 'vod_play_url')@FlexibleStringConverter()  String playUrl)?  $default,) {final _that = this;
switch (_that) {
case _VodItem() when $default != null:
return $default(_that.id,_that.typeId,_that.parentTypeId,_that.name,_that.typeName,_that.picture,_that.remarks,_that.year,_that.area,_that.language,_that.score,_that.doubanScore,_that.actor,_that.director,_that.category,_that.summary,_that.duration,_that.playFrom,_that.playUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VodItem implements VodItem {
  const _VodItem({@JsonKey(name: 'vod_id')@FlexibleIntConverter() this.id = 0, @JsonKey(name: 'type_id')@FlexibleIntConverter() this.typeId = 0, @JsonKey(name: 'type_id_1')@FlexibleIntConverter() this.parentTypeId = 0, @JsonKey(name: 'vod_name')@FlexibleStringConverter() this.name = '', @JsonKey(name: 'type_name')@FlexibleStringConverter() this.typeName = '', @JsonKey(name: 'vod_pic')@FlexibleStringConverter() this.picture = '', @JsonKey(name: 'vod_remarks')@FlexibleStringConverter() this.remarks = '', @JsonKey(name: 'vod_year')@FlexibleStringConverter() this.year = '', @JsonKey(name: 'vod_area')@FlexibleStringConverter() this.area = '', @JsonKey(name: 'vod_lang')@FlexibleStringConverter() this.language = '', @JsonKey(name: 'vod_score')@FlexibleStringConverter() this.score = '', @JsonKey(name: 'vod_douban_score')@FlexibleStringConverter() this.doubanScore = '', @JsonKey(name: 'vod_actor')@FlexibleStringConverter() this.actor = '', @JsonKey(name: 'vod_director')@FlexibleStringConverter() this.director = '', @JsonKey(name: 'vod_class')@FlexibleStringConverter() this.category = '', @JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter() this.summary = '', @JsonKey(name: 'vod_duration')@FlexibleStringConverter() this.duration = '', @JsonKey(name: 'vod_play_from')@FlexibleStringConverter() this.playFrom = '', @JsonKey(name: 'vod_play_url')@FlexibleStringConverter() this.playUrl = ''});
  factory _VodItem.fromJson(Map<String, dynamic> json) => _$VodItemFromJson(json);

@override@JsonKey(name: 'vod_id')@FlexibleIntConverter() final  int id;
@override@JsonKey(name: 'type_id')@FlexibleIntConverter() final  int typeId;
@override@JsonKey(name: 'type_id_1')@FlexibleIntConverter() final  int parentTypeId;
@override@JsonKey(name: 'vod_name')@FlexibleStringConverter() final  String name;
@override@JsonKey(name: 'type_name')@FlexibleStringConverter() final  String typeName;
@override@JsonKey(name: 'vod_pic')@FlexibleStringConverter() final  String picture;
@override@JsonKey(name: 'vod_remarks')@FlexibleStringConverter() final  String remarks;
@override@JsonKey(name: 'vod_year')@FlexibleStringConverter() final  String year;
@override@JsonKey(name: 'vod_area')@FlexibleStringConverter() final  String area;
@override@JsonKey(name: 'vod_lang')@FlexibleStringConverter() final  String language;
@override@JsonKey(name: 'vod_score')@FlexibleStringConverter() final  String score;
@override@JsonKey(name: 'vod_douban_score')@FlexibleStringConverter() final  String doubanScore;
@override@JsonKey(name: 'vod_actor')@FlexibleStringConverter() final  String actor;
@override@JsonKey(name: 'vod_director')@FlexibleStringConverter() final  String director;
@override@JsonKey(name: 'vod_class')@FlexibleStringConverter() final  String category;
@override@JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter() final  String summary;
@override@JsonKey(name: 'vod_duration')@FlexibleStringConverter() final  String duration;
@override@JsonKey(name: 'vod_play_from')@FlexibleStringConverter() final  String playFrom;
@override@JsonKey(name: 'vod_play_url')@FlexibleStringConverter() final  String playUrl;

/// Create a copy of VodItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VodItemCopyWith<_VodItem> get copyWith => __$VodItemCopyWithImpl<_VodItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VodItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VodItem&&(identical(other.id, id) || other.id == id)&&(identical(other.typeId, typeId) || other.typeId == typeId)&&(identical(other.parentTypeId, parentTypeId) || other.parentTypeId == parentTypeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.picture, picture) || other.picture == picture)&&(identical(other.remarks, remarks) || other.remarks == remarks)&&(identical(other.year, year) || other.year == year)&&(identical(other.area, area) || other.area == area)&&(identical(other.language, language) || other.language == language)&&(identical(other.score, score) || other.score == score)&&(identical(other.doubanScore, doubanScore) || other.doubanScore == doubanScore)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.director, director) || other.director == director)&&(identical(other.category, category) || other.category == category)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playFrom, playFrom) || other.playFrom == playFrom)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,typeId,parentTypeId,name,typeName,picture,remarks,year,area,language,score,doubanScore,actor,director,category,summary,duration,playFrom,playUrl]);

@override
String toString() {
  return 'VodItem(id: $id, typeId: $typeId, parentTypeId: $parentTypeId, name: $name, typeName: $typeName, picture: $picture, remarks: $remarks, year: $year, area: $area, language: $language, score: $score, doubanScore: $doubanScore, actor: $actor, director: $director, category: $category, summary: $summary, duration: $duration, playFrom: $playFrom, playUrl: $playUrl)';
}


}

/// @nodoc
abstract mixin class _$VodItemCopyWith<$Res> implements $VodItemCopyWith<$Res> {
  factory _$VodItemCopyWith(_VodItem value, $Res Function(_VodItem) _then) = __$VodItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'vod_id')@FlexibleIntConverter() int id,@JsonKey(name: 'type_id')@FlexibleIntConverter() int typeId,@JsonKey(name: 'type_id_1')@FlexibleIntConverter() int parentTypeId,@JsonKey(name: 'vod_name')@FlexibleStringConverter() String name,@JsonKey(name: 'type_name')@FlexibleStringConverter() String typeName,@JsonKey(name: 'vod_pic')@FlexibleStringConverter() String picture,@JsonKey(name: 'vod_remarks')@FlexibleStringConverter() String remarks,@JsonKey(name: 'vod_year')@FlexibleStringConverter() String year,@JsonKey(name: 'vod_area')@FlexibleStringConverter() String area,@JsonKey(name: 'vod_lang')@FlexibleStringConverter() String language,@JsonKey(name: 'vod_score')@FlexibleStringConverter() String score,@JsonKey(name: 'vod_douban_score')@FlexibleStringConverter() String doubanScore,@JsonKey(name: 'vod_actor')@FlexibleStringConverter() String actor,@JsonKey(name: 'vod_director')@FlexibleStringConverter() String director,@JsonKey(name: 'vod_class')@FlexibleStringConverter() String category,@JsonKey(name: 'vod_blurb', readValue: readVodSummary)@CmsTextConverter() String summary,@JsonKey(name: 'vod_duration')@FlexibleStringConverter() String duration,@JsonKey(name: 'vod_play_from')@FlexibleStringConverter() String playFrom,@JsonKey(name: 'vod_play_url')@FlexibleStringConverter() String playUrl
});




}
/// @nodoc
class __$VodItemCopyWithImpl<$Res>
    implements _$VodItemCopyWith<$Res> {
  __$VodItemCopyWithImpl(this._self, this._then);

  final _VodItem _self;
  final $Res Function(_VodItem) _then;

/// Create a copy of VodItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? typeId = null,Object? parentTypeId = null,Object? name = null,Object? typeName = null,Object? picture = null,Object? remarks = null,Object? year = null,Object? area = null,Object? language = null,Object? score = null,Object? doubanScore = null,Object? actor = null,Object? director = null,Object? category = null,Object? summary = null,Object? duration = null,Object? playFrom = null,Object? playUrl = null,}) {
  return _then(_VodItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,typeId: null == typeId ? _self.typeId : typeId // ignore: cast_nullable_to_non_nullable
as int,parentTypeId: null == parentTypeId ? _self.parentTypeId : parentTypeId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,typeName: null == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String,picture: null == picture ? _self.picture : picture // ignore: cast_nullable_to_non_nullable
as String,remarks: null == remarks ? _self.remarks : remarks // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String,doubanScore: null == doubanScore ? _self.doubanScore : doubanScore // ignore: cast_nullable_to_non_nullable
as String,actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,playFrom: null == playFrom ? _self.playFrom : playFrom // ignore: cast_nullable_to_non_nullable
as String,playUrl: null == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
