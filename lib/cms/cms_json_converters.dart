import 'package:json_annotation/json_annotation.dart';

class FlexibleIntConverter implements JsonConverter<int, Object?> {
  const FlexibleIntConverter();

  @override
  int fromJson(Object? json) {
    if (json is int) return json;
    if (json is num) return json.toInt();
    return int.tryParse('$json') ?? 0;
  }

  @override
  Object toJson(int object) => object;
}

class FlexibleStringConverter implements JsonConverter<String, Object?> {
  const FlexibleStringConverter();

  @override
  String fromJson(Object? json) {
    if (json == null) return '';
    return '$json'.trim();
  }

  @override
  Object toJson(String object) => object;
}

class CmsTextConverter implements JsonConverter<String, Object?> {
  const CmsTextConverter();

  @override
  String fromJson(Object? json) {
    return FlexibleStringConverter()
        .fromJson(json)
        .replaceAll(RegExp('<[^>]*>'), '')
        .replaceAll('&amp;nbsp;', ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  Object toJson(String object) => object;
}
