class CmsCategory {
  const CmsCategory({
    required this.id,
    required this.parentId,
    required this.name,
  });

  factory CmsCategory.fromJson(Map<String, dynamic> json) {
    return CmsCategory(
      id: jsonInt(json['type_id']),
      parentId: jsonInt(json['type_pid']),
      name: jsonText(json['type_name']),
    );
  }

  final int id;
  final int parentId;
  final String name;
}

class VodItem {
  const VodItem({
    required this.id,
    required this.typeId,
    required this.parentTypeId,
    required this.name,
    required this.typeName,
    required this.picture,
    required this.remarks,
    required this.year,
    required this.area,
    required this.language,
    required this.score,
    required this.doubanScore,
    required this.actor,
    required this.director,
    required this.category,
    required this.summary,
    required this.duration,
    required this.playFrom,
    required this.playUrl,
  });

  factory VodItem.fromJson(Map<String, dynamic> json) {
    return VodItem(
      id: jsonInt(json['vod_id']),
      typeId: jsonInt(json['type_id']),
      parentTypeId: jsonInt(json['type_id_1']),
      name: jsonText(json['vod_name']),
      typeName: jsonText(json['type_name']),
      picture: jsonText(json['vod_pic']),
      remarks: jsonText(json['vod_remarks']),
      year: jsonText(json['vod_year']),
      area: jsonText(json['vod_area']),
      language: jsonText(json['vod_lang']),
      score: jsonText(json['vod_score']),
      doubanScore: jsonText(json['vod_douban_score']),
      actor: jsonText(json['vod_actor']),
      director: jsonText(json['vod_director']),
      category: jsonText(json['vod_class']),
      summary: cleanCmsText(
        jsonText(json['vod_blurb']).isNotEmpty
            ? jsonText(json['vod_blurb'])
            : jsonText(json['vod_content']),
      ),
      duration: jsonText(json['vod_duration']),
      playFrom: jsonText(json['vod_play_from']),
      playUrl: jsonText(json['vod_play_url']),
    );
  }

  final int id;
  final int typeId;
  final int parentTypeId;
  final String name;
  final String typeName;
  final String picture;
  final String remarks;
  final String year;
  final String area;
  final String language;
  final String score;
  final String doubanScore;
  final String actor;
  final String director;
  final String category;
  final String summary;
  final String duration;
  final String playFrom;
  final String playUrl;

  Map<String, dynamic> toJson() {
    return {
      'vod_id': id,
      'type_id': typeId,
      'type_id_1': parentTypeId,
      'vod_name': name,
      'type_name': typeName,
      'vod_pic': picture,
      'vod_remarks': remarks,
      'vod_year': year,
      'vod_area': area,
      'vod_lang': language,
      'vod_score': score,
      'vod_douban_score': doubanScore,
      'vod_actor': actor,
      'vod_director': director,
      'vod_class': category,
      'vod_blurb': summary,
      'vod_duration': duration,
      'vod_play_from': playFrom,
      'vod_play_url': playUrl,
    };
  }

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

int jsonInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse('$value') ?? 0;
}

String jsonText(Object? value) {
  if (value == null) return '';
  return '$value'.trim();
}

String cleanCmsText(String value) {
  return value
      .replaceAll(RegExp('<[^>]*>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
