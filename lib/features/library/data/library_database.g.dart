// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_database.dart';

// ignore_for_file: type=lint
class $StoredVodsTable extends StoredVods
    with TableInfo<$StoredVodsTable, StoredVod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredVodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentTypeIdMeta = const VerificationMeta(
    'parentTypeId',
  );
  @override
  late final GeneratedColumn<int> parentTypeId = GeneratedColumn<int>(
    'parent_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeNameMeta = const VerificationMeta(
    'typeName',
  );
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
    'type_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pictureMeta = const VerificationMeta(
    'picture',
  );
  @override
  late final GeneratedColumn<String> picture = GeneratedColumn<String>(
    'picture',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<String> year = GeneratedColumn<String>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<String> score = GeneratedColumn<String>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doubanScoreMeta = const VerificationMeta(
    'doubanScore',
  );
  @override
  late final GeneratedColumn<String> doubanScore = GeneratedColumn<String>(
    'douban_score',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorMeta = const VerificationMeta('actor');
  @override
  late final GeneratedColumn<String> actor = GeneratedColumn<String>(
    'actor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directorMeta = const VerificationMeta(
    'director',
  );
  @override
  late final GeneratedColumn<String> director = GeneratedColumn<String>(
    'director',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playFromMeta = const VerificationMeta(
    'playFrom',
  );
  @override
  late final GeneratedColumn<String> playFrom = GeneratedColumn<String>(
    'play_from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playUrlMeta = const VerificationMeta(
    'playUrl',
  );
  @override
  late final GeneratedColumn<String> playUrl = GeneratedColumn<String>(
    'play_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    typeId,
    parentTypeId,
    name,
    typeName,
    picture,
    remarks,
    year,
    area,
    language,
    score,
    doubanScore,
    actor,
    director,
    category,
    summary,
    duration,
    playFrom,
    playUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stored_vods';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredVod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('parent_type_id')) {
      context.handle(
        _parentTypeIdMeta,
        parentTypeId.isAcceptableOrUnknown(
          data['parent_type_id']!,
          _parentTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parentTypeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type_name')) {
      context.handle(
        _typeNameMeta,
        typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    if (data.containsKey('picture')) {
      context.handle(
        _pictureMeta,
        picture.isAcceptableOrUnknown(data['picture']!, _pictureMeta),
      );
    } else if (isInserting) {
      context.missing(_pictureMeta);
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    } else if (isInserting) {
      context.missing(_remarksMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    } else if (isInserting) {
      context.missing(_areaMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('douban_score')) {
      context.handle(
        _doubanScoreMeta,
        doubanScore.isAcceptableOrUnknown(
          data['douban_score']!,
          _doubanScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_doubanScoreMeta);
    }
    if (data.containsKey('actor')) {
      context.handle(
        _actorMeta,
        actor.isAcceptableOrUnknown(data['actor']!, _actorMeta),
      );
    } else if (isInserting) {
      context.missing(_actorMeta);
    }
    if (data.containsKey('director')) {
      context.handle(
        _directorMeta,
        director.isAcceptableOrUnknown(data['director']!, _directorMeta),
      );
    } else if (isInserting) {
      context.missing(_directorMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('play_from')) {
      context.handle(
        _playFromMeta,
        playFrom.isAcceptableOrUnknown(data['play_from']!, _playFromMeta),
      );
    } else if (isInserting) {
      context.missing(_playFromMeta);
    }
    if (data.containsKey('play_url')) {
      context.handle(
        _playUrlMeta,
        playUrl.isAcceptableOrUnknown(data['play_url']!, _playUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_playUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredVod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredVod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      parentTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_type_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      typeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_name'],
      )!,
      picture: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}picture'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}year'],
      )!,
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}score'],
      )!,
      doubanScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}douban_score'],
      )!,
      actor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor'],
      )!,
      director: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}director'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration'],
      )!,
      playFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}play_from'],
      )!,
      playUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}play_url'],
      )!,
    );
  }

  @override
  $StoredVodsTable createAlias(String alias) {
    return $StoredVodsTable(attachedDatabase, alias);
  }
}

class StoredVod extends DataClass implements Insertable<StoredVod> {
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
  const StoredVod({
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type_id'] = Variable<int>(typeId);
    map['parent_type_id'] = Variable<int>(parentTypeId);
    map['name'] = Variable<String>(name);
    map['type_name'] = Variable<String>(typeName);
    map['picture'] = Variable<String>(picture);
    map['remarks'] = Variable<String>(remarks);
    map['year'] = Variable<String>(year);
    map['area'] = Variable<String>(area);
    map['language'] = Variable<String>(language);
    map['score'] = Variable<String>(score);
    map['douban_score'] = Variable<String>(doubanScore);
    map['actor'] = Variable<String>(actor);
    map['director'] = Variable<String>(director);
    map['category'] = Variable<String>(category);
    map['summary'] = Variable<String>(summary);
    map['duration'] = Variable<String>(duration);
    map['play_from'] = Variable<String>(playFrom);
    map['play_url'] = Variable<String>(playUrl);
    return map;
  }

  StoredVodsCompanion toCompanion(bool nullToAbsent) {
    return StoredVodsCompanion(
      id: Value(id),
      typeId: Value(typeId),
      parentTypeId: Value(parentTypeId),
      name: Value(name),
      typeName: Value(typeName),
      picture: Value(picture),
      remarks: Value(remarks),
      year: Value(year),
      area: Value(area),
      language: Value(language),
      score: Value(score),
      doubanScore: Value(doubanScore),
      actor: Value(actor),
      director: Value(director),
      category: Value(category),
      summary: Value(summary),
      duration: Value(duration),
      playFrom: Value(playFrom),
      playUrl: Value(playUrl),
    );
  }

  factory StoredVod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredVod(
      id: serializer.fromJson<int>(json['id']),
      typeId: serializer.fromJson<int>(json['typeId']),
      parentTypeId: serializer.fromJson<int>(json['parentTypeId']),
      name: serializer.fromJson<String>(json['name']),
      typeName: serializer.fromJson<String>(json['typeName']),
      picture: serializer.fromJson<String>(json['picture']),
      remarks: serializer.fromJson<String>(json['remarks']),
      year: serializer.fromJson<String>(json['year']),
      area: serializer.fromJson<String>(json['area']),
      language: serializer.fromJson<String>(json['language']),
      score: serializer.fromJson<String>(json['score']),
      doubanScore: serializer.fromJson<String>(json['doubanScore']),
      actor: serializer.fromJson<String>(json['actor']),
      director: serializer.fromJson<String>(json['director']),
      category: serializer.fromJson<String>(json['category']),
      summary: serializer.fromJson<String>(json['summary']),
      duration: serializer.fromJson<String>(json['duration']),
      playFrom: serializer.fromJson<String>(json['playFrom']),
      playUrl: serializer.fromJson<String>(json['playUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'typeId': serializer.toJson<int>(typeId),
      'parentTypeId': serializer.toJson<int>(parentTypeId),
      'name': serializer.toJson<String>(name),
      'typeName': serializer.toJson<String>(typeName),
      'picture': serializer.toJson<String>(picture),
      'remarks': serializer.toJson<String>(remarks),
      'year': serializer.toJson<String>(year),
      'area': serializer.toJson<String>(area),
      'language': serializer.toJson<String>(language),
      'score': serializer.toJson<String>(score),
      'doubanScore': serializer.toJson<String>(doubanScore),
      'actor': serializer.toJson<String>(actor),
      'director': serializer.toJson<String>(director),
      'category': serializer.toJson<String>(category),
      'summary': serializer.toJson<String>(summary),
      'duration': serializer.toJson<String>(duration),
      'playFrom': serializer.toJson<String>(playFrom),
      'playUrl': serializer.toJson<String>(playUrl),
    };
  }

  StoredVod copyWith({
    int? id,
    int? typeId,
    int? parentTypeId,
    String? name,
    String? typeName,
    String? picture,
    String? remarks,
    String? year,
    String? area,
    String? language,
    String? score,
    String? doubanScore,
    String? actor,
    String? director,
    String? category,
    String? summary,
    String? duration,
    String? playFrom,
    String? playUrl,
  }) => StoredVod(
    id: id ?? this.id,
    typeId: typeId ?? this.typeId,
    parentTypeId: parentTypeId ?? this.parentTypeId,
    name: name ?? this.name,
    typeName: typeName ?? this.typeName,
    picture: picture ?? this.picture,
    remarks: remarks ?? this.remarks,
    year: year ?? this.year,
    area: area ?? this.area,
    language: language ?? this.language,
    score: score ?? this.score,
    doubanScore: doubanScore ?? this.doubanScore,
    actor: actor ?? this.actor,
    director: director ?? this.director,
    category: category ?? this.category,
    summary: summary ?? this.summary,
    duration: duration ?? this.duration,
    playFrom: playFrom ?? this.playFrom,
    playUrl: playUrl ?? this.playUrl,
  );
  StoredVod copyWithCompanion(StoredVodsCompanion data) {
    return StoredVod(
      id: data.id.present ? data.id.value : this.id,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      parentTypeId: data.parentTypeId.present
          ? data.parentTypeId.value
          : this.parentTypeId,
      name: data.name.present ? data.name.value : this.name,
      typeName: data.typeName.present ? data.typeName.value : this.typeName,
      picture: data.picture.present ? data.picture.value : this.picture,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      year: data.year.present ? data.year.value : this.year,
      area: data.area.present ? data.area.value : this.area,
      language: data.language.present ? data.language.value : this.language,
      score: data.score.present ? data.score.value : this.score,
      doubanScore: data.doubanScore.present
          ? data.doubanScore.value
          : this.doubanScore,
      actor: data.actor.present ? data.actor.value : this.actor,
      director: data.director.present ? data.director.value : this.director,
      category: data.category.present ? data.category.value : this.category,
      summary: data.summary.present ? data.summary.value : this.summary,
      duration: data.duration.present ? data.duration.value : this.duration,
      playFrom: data.playFrom.present ? data.playFrom.value : this.playFrom,
      playUrl: data.playUrl.present ? data.playUrl.value : this.playUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredVod(')
          ..write('id: $id, ')
          ..write('typeId: $typeId, ')
          ..write('parentTypeId: $parentTypeId, ')
          ..write('name: $name, ')
          ..write('typeName: $typeName, ')
          ..write('picture: $picture, ')
          ..write('remarks: $remarks, ')
          ..write('year: $year, ')
          ..write('area: $area, ')
          ..write('language: $language, ')
          ..write('score: $score, ')
          ..write('doubanScore: $doubanScore, ')
          ..write('actor: $actor, ')
          ..write('director: $director, ')
          ..write('category: $category, ')
          ..write('summary: $summary, ')
          ..write('duration: $duration, ')
          ..write('playFrom: $playFrom, ')
          ..write('playUrl: $playUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    typeId,
    parentTypeId,
    name,
    typeName,
    picture,
    remarks,
    year,
    area,
    language,
    score,
    doubanScore,
    actor,
    director,
    category,
    summary,
    duration,
    playFrom,
    playUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredVod &&
          other.id == this.id &&
          other.typeId == this.typeId &&
          other.parentTypeId == this.parentTypeId &&
          other.name == this.name &&
          other.typeName == this.typeName &&
          other.picture == this.picture &&
          other.remarks == this.remarks &&
          other.year == this.year &&
          other.area == this.area &&
          other.language == this.language &&
          other.score == this.score &&
          other.doubanScore == this.doubanScore &&
          other.actor == this.actor &&
          other.director == this.director &&
          other.category == this.category &&
          other.summary == this.summary &&
          other.duration == this.duration &&
          other.playFrom == this.playFrom &&
          other.playUrl == this.playUrl);
}

class StoredVodsCompanion extends UpdateCompanion<StoredVod> {
  final Value<int> id;
  final Value<int> typeId;
  final Value<int> parentTypeId;
  final Value<String> name;
  final Value<String> typeName;
  final Value<String> picture;
  final Value<String> remarks;
  final Value<String> year;
  final Value<String> area;
  final Value<String> language;
  final Value<String> score;
  final Value<String> doubanScore;
  final Value<String> actor;
  final Value<String> director;
  final Value<String> category;
  final Value<String> summary;
  final Value<String> duration;
  final Value<String> playFrom;
  final Value<String> playUrl;
  const StoredVodsCompanion({
    this.id = const Value.absent(),
    this.typeId = const Value.absent(),
    this.parentTypeId = const Value.absent(),
    this.name = const Value.absent(),
    this.typeName = const Value.absent(),
    this.picture = const Value.absent(),
    this.remarks = const Value.absent(),
    this.year = const Value.absent(),
    this.area = const Value.absent(),
    this.language = const Value.absent(),
    this.score = const Value.absent(),
    this.doubanScore = const Value.absent(),
    this.actor = const Value.absent(),
    this.director = const Value.absent(),
    this.category = const Value.absent(),
    this.summary = const Value.absent(),
    this.duration = const Value.absent(),
    this.playFrom = const Value.absent(),
    this.playUrl = const Value.absent(),
  });
  StoredVodsCompanion.insert({
    this.id = const Value.absent(),
    required int typeId,
    required int parentTypeId,
    required String name,
    required String typeName,
    required String picture,
    required String remarks,
    required String year,
    required String area,
    required String language,
    required String score,
    required String doubanScore,
    required String actor,
    required String director,
    required String category,
    required String summary,
    required String duration,
    required String playFrom,
    required String playUrl,
  }) : typeId = Value(typeId),
       parentTypeId = Value(parentTypeId),
       name = Value(name),
       typeName = Value(typeName),
       picture = Value(picture),
       remarks = Value(remarks),
       year = Value(year),
       area = Value(area),
       language = Value(language),
       score = Value(score),
       doubanScore = Value(doubanScore),
       actor = Value(actor),
       director = Value(director),
       category = Value(category),
       summary = Value(summary),
       duration = Value(duration),
       playFrom = Value(playFrom),
       playUrl = Value(playUrl);
  static Insertable<StoredVod> custom({
    Expression<int>? id,
    Expression<int>? typeId,
    Expression<int>? parentTypeId,
    Expression<String>? name,
    Expression<String>? typeName,
    Expression<String>? picture,
    Expression<String>? remarks,
    Expression<String>? year,
    Expression<String>? area,
    Expression<String>? language,
    Expression<String>? score,
    Expression<String>? doubanScore,
    Expression<String>? actor,
    Expression<String>? director,
    Expression<String>? category,
    Expression<String>? summary,
    Expression<String>? duration,
    Expression<String>? playFrom,
    Expression<String>? playUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (typeId != null) 'type_id': typeId,
      if (parentTypeId != null) 'parent_type_id': parentTypeId,
      if (name != null) 'name': name,
      if (typeName != null) 'type_name': typeName,
      if (picture != null) 'picture': picture,
      if (remarks != null) 'remarks': remarks,
      if (year != null) 'year': year,
      if (area != null) 'area': area,
      if (language != null) 'language': language,
      if (score != null) 'score': score,
      if (doubanScore != null) 'douban_score': doubanScore,
      if (actor != null) 'actor': actor,
      if (director != null) 'director': director,
      if (category != null) 'category': category,
      if (summary != null) 'summary': summary,
      if (duration != null) 'duration': duration,
      if (playFrom != null) 'play_from': playFrom,
      if (playUrl != null) 'play_url': playUrl,
    });
  }

  StoredVodsCompanion copyWith({
    Value<int>? id,
    Value<int>? typeId,
    Value<int>? parentTypeId,
    Value<String>? name,
    Value<String>? typeName,
    Value<String>? picture,
    Value<String>? remarks,
    Value<String>? year,
    Value<String>? area,
    Value<String>? language,
    Value<String>? score,
    Value<String>? doubanScore,
    Value<String>? actor,
    Value<String>? director,
    Value<String>? category,
    Value<String>? summary,
    Value<String>? duration,
    Value<String>? playFrom,
    Value<String>? playUrl,
  }) {
    return StoredVodsCompanion(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      parentTypeId: parentTypeId ?? this.parentTypeId,
      name: name ?? this.name,
      typeName: typeName ?? this.typeName,
      picture: picture ?? this.picture,
      remarks: remarks ?? this.remarks,
      year: year ?? this.year,
      area: area ?? this.area,
      language: language ?? this.language,
      score: score ?? this.score,
      doubanScore: doubanScore ?? this.doubanScore,
      actor: actor ?? this.actor,
      director: director ?? this.director,
      category: category ?? this.category,
      summary: summary ?? this.summary,
      duration: duration ?? this.duration,
      playFrom: playFrom ?? this.playFrom,
      playUrl: playUrl ?? this.playUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (parentTypeId.present) {
      map['parent_type_id'] = Variable<int>(parentTypeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String>(picture.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (score.present) {
      map['score'] = Variable<String>(score.value);
    }
    if (doubanScore.present) {
      map['douban_score'] = Variable<String>(doubanScore.value);
    }
    if (actor.present) {
      map['actor'] = Variable<String>(actor.value);
    }
    if (director.present) {
      map['director'] = Variable<String>(director.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (playFrom.present) {
      map['play_from'] = Variable<String>(playFrom.value);
    }
    if (playUrl.present) {
      map['play_url'] = Variable<String>(playUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredVodsCompanion(')
          ..write('id: $id, ')
          ..write('typeId: $typeId, ')
          ..write('parentTypeId: $parentTypeId, ')
          ..write('name: $name, ')
          ..write('typeName: $typeName, ')
          ..write('picture: $picture, ')
          ..write('remarks: $remarks, ')
          ..write('year: $year, ')
          ..write('area: $area, ')
          ..write('language: $language, ')
          ..write('score: $score, ')
          ..write('doubanScore: $doubanScore, ')
          ..write('actor: $actor, ')
          ..write('director: $director, ')
          ..write('category: $category, ')
          ..write('summary: $summary, ')
          ..write('duration: $duration, ')
          ..write('playFrom: $playFrom, ')
          ..write('playUrl: $playUrl')
          ..write(')'))
        .toString();
  }
}

class $VodFavoritesTable extends VodFavorites
    with TableInfo<$VodFavoritesTable, VodFavorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VodFavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vodIdMeta = const VerificationMeta('vodId');
  @override
  late final GeneratedColumn<int> vodId = GeneratedColumn<int>(
    'vod_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stored_vods (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [vodId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vod_favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<VodFavorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vod_id')) {
      context.handle(
        _vodIdMeta,
        vodId.isAcceptableOrUnknown(data['vod_id']!, _vodIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vodId};
  @override
  VodFavorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VodFavorite(
      vodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vod_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VodFavoritesTable createAlias(String alias) {
    return $VodFavoritesTable(attachedDatabase, alias);
  }
}

class VodFavorite extends DataClass implements Insertable<VodFavorite> {
  final int vodId;
  final DateTime createdAt;
  const VodFavorite({required this.vodId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vod_id'] = Variable<int>(vodId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VodFavoritesCompanion toCompanion(bool nullToAbsent) {
    return VodFavoritesCompanion(
      vodId: Value(vodId),
      createdAt: Value(createdAt),
    );
  }

  factory VodFavorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VodFavorite(
      vodId: serializer.fromJson<int>(json['vodId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vodId': serializer.toJson<int>(vodId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VodFavorite copyWith({int? vodId, DateTime? createdAt}) => VodFavorite(
    vodId: vodId ?? this.vodId,
    createdAt: createdAt ?? this.createdAt,
  );
  VodFavorite copyWithCompanion(VodFavoritesCompanion data) {
    return VodFavorite(
      vodId: data.vodId.present ? data.vodId.value : this.vodId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VodFavorite(')
          ..write('vodId: $vodId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vodId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VodFavorite &&
          other.vodId == this.vodId &&
          other.createdAt == this.createdAt);
}

class VodFavoritesCompanion extends UpdateCompanion<VodFavorite> {
  final Value<int> vodId;
  final Value<DateTime> createdAt;
  const VodFavoritesCompanion({
    this.vodId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VodFavoritesCompanion.insert({
    this.vodId = const Value.absent(),
    required DateTime createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<VodFavorite> custom({
    Expression<int>? vodId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (vodId != null) 'vod_id': vodId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VodFavoritesCompanion copyWith({
    Value<int>? vodId,
    Value<DateTime>? createdAt,
  }) {
    return VodFavoritesCompanion(
      vodId: vodId ?? this.vodId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vodId.present) {
      map['vod_id'] = Variable<int>(vodId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VodFavoritesCompanion(')
          ..write('vodId: $vodId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $VodViewingHistoriesTable extends VodViewingHistories
    with TableInfo<$VodViewingHistoriesTable, VodViewingHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VodViewingHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vodIdMeta = const VerificationMeta('vodId');
  @override
  late final GeneratedColumn<int> vodId = GeneratedColumn<int>(
    'vod_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES stored_vods (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeNameMeta = const VerificationMeta(
    'episodeName',
  );
  @override
  late final GeneratedColumn<String> episodeName = GeneratedColumn<String>(
    'episode_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeUrlMeta = const VerificationMeta(
    'episodeUrl',
  );
  @override
  late final GeneratedColumn<String> episodeUrl = GeneratedColumn<String>(
    'episode_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _watchedAtMeta = const VerificationMeta(
    'watchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> watchedAt = GeneratedColumn<DateTime>(
    'watched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    vodId,
    sourceName,
    episodeName,
    episodeUrl,
    watchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vod_viewing_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<VodViewingHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vod_id')) {
      context.handle(
        _vodIdMeta,
        vodId.isAcceptableOrUnknown(data['vod_id']!, _vodIdMeta),
      );
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceNameMeta);
    }
    if (data.containsKey('episode_name')) {
      context.handle(
        _episodeNameMeta,
        episodeName.isAcceptableOrUnknown(
          data['episode_name']!,
          _episodeNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_episodeNameMeta);
    }
    if (data.containsKey('episode_url')) {
      context.handle(
        _episodeUrlMeta,
        episodeUrl.isAcceptableOrUnknown(data['episode_url']!, _episodeUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_episodeUrlMeta);
    }
    if (data.containsKey('watched_at')) {
      context.handle(
        _watchedAtMeta,
        watchedAt.isAcceptableOrUnknown(data['watched_at']!, _watchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_watchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vodId};
  @override
  VodViewingHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VodViewingHistory(
      vodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vod_id'],
      )!,
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      )!,
      episodeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_name'],
      )!,
      episodeUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_url'],
      )!,
      watchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}watched_at'],
      )!,
    );
  }

  @override
  $VodViewingHistoriesTable createAlias(String alias) {
    return $VodViewingHistoriesTable(attachedDatabase, alias);
  }
}

class VodViewingHistory extends DataClass
    implements Insertable<VodViewingHistory> {
  final int vodId;
  final String sourceName;
  final String episodeName;
  final String episodeUrl;
  final DateTime watchedAt;
  const VodViewingHistory({
    required this.vodId,
    required this.sourceName,
    required this.episodeName,
    required this.episodeUrl,
    required this.watchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vod_id'] = Variable<int>(vodId);
    map['source_name'] = Variable<String>(sourceName);
    map['episode_name'] = Variable<String>(episodeName);
    map['episode_url'] = Variable<String>(episodeUrl);
    map['watched_at'] = Variable<DateTime>(watchedAt);
    return map;
  }

  VodViewingHistoriesCompanion toCompanion(bool nullToAbsent) {
    return VodViewingHistoriesCompanion(
      vodId: Value(vodId),
      sourceName: Value(sourceName),
      episodeName: Value(episodeName),
      episodeUrl: Value(episodeUrl),
      watchedAt: Value(watchedAt),
    );
  }

  factory VodViewingHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VodViewingHistory(
      vodId: serializer.fromJson<int>(json['vodId']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      episodeName: serializer.fromJson<String>(json['episodeName']),
      episodeUrl: serializer.fromJson<String>(json['episodeUrl']),
      watchedAt: serializer.fromJson<DateTime>(json['watchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vodId': serializer.toJson<int>(vodId),
      'sourceName': serializer.toJson<String>(sourceName),
      'episodeName': serializer.toJson<String>(episodeName),
      'episodeUrl': serializer.toJson<String>(episodeUrl),
      'watchedAt': serializer.toJson<DateTime>(watchedAt),
    };
  }

  VodViewingHistory copyWith({
    int? vodId,
    String? sourceName,
    String? episodeName,
    String? episodeUrl,
    DateTime? watchedAt,
  }) => VodViewingHistory(
    vodId: vodId ?? this.vodId,
    sourceName: sourceName ?? this.sourceName,
    episodeName: episodeName ?? this.episodeName,
    episodeUrl: episodeUrl ?? this.episodeUrl,
    watchedAt: watchedAt ?? this.watchedAt,
  );
  VodViewingHistory copyWithCompanion(VodViewingHistoriesCompanion data) {
    return VodViewingHistory(
      vodId: data.vodId.present ? data.vodId.value : this.vodId,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      episodeName: data.episodeName.present
          ? data.episodeName.value
          : this.episodeName,
      episodeUrl: data.episodeUrl.present
          ? data.episodeUrl.value
          : this.episodeUrl,
      watchedAt: data.watchedAt.present ? data.watchedAt.value : this.watchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VodViewingHistory(')
          ..write('vodId: $vodId, ')
          ..write('sourceName: $sourceName, ')
          ..write('episodeName: $episodeName, ')
          ..write('episodeUrl: $episodeUrl, ')
          ..write('watchedAt: $watchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(vodId, sourceName, episodeName, episodeUrl, watchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VodViewingHistory &&
          other.vodId == this.vodId &&
          other.sourceName == this.sourceName &&
          other.episodeName == this.episodeName &&
          other.episodeUrl == this.episodeUrl &&
          other.watchedAt == this.watchedAt);
}

class VodViewingHistoriesCompanion extends UpdateCompanion<VodViewingHistory> {
  final Value<int> vodId;
  final Value<String> sourceName;
  final Value<String> episodeName;
  final Value<String> episodeUrl;
  final Value<DateTime> watchedAt;
  const VodViewingHistoriesCompanion({
    this.vodId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.episodeName = const Value.absent(),
    this.episodeUrl = const Value.absent(),
    this.watchedAt = const Value.absent(),
  });
  VodViewingHistoriesCompanion.insert({
    this.vodId = const Value.absent(),
    required String sourceName,
    required String episodeName,
    required String episodeUrl,
    required DateTime watchedAt,
  }) : sourceName = Value(sourceName),
       episodeName = Value(episodeName),
       episodeUrl = Value(episodeUrl),
       watchedAt = Value(watchedAt);
  static Insertable<VodViewingHistory> custom({
    Expression<int>? vodId,
    Expression<String>? sourceName,
    Expression<String>? episodeName,
    Expression<String>? episodeUrl,
    Expression<DateTime>? watchedAt,
  }) {
    return RawValuesInsertable({
      if (vodId != null) 'vod_id': vodId,
      if (sourceName != null) 'source_name': sourceName,
      if (episodeName != null) 'episode_name': episodeName,
      if (episodeUrl != null) 'episode_url': episodeUrl,
      if (watchedAt != null) 'watched_at': watchedAt,
    });
  }

  VodViewingHistoriesCompanion copyWith({
    Value<int>? vodId,
    Value<String>? sourceName,
    Value<String>? episodeName,
    Value<String>? episodeUrl,
    Value<DateTime>? watchedAt,
  }) {
    return VodViewingHistoriesCompanion(
      vodId: vodId ?? this.vodId,
      sourceName: sourceName ?? this.sourceName,
      episodeName: episodeName ?? this.episodeName,
      episodeUrl: episodeUrl ?? this.episodeUrl,
      watchedAt: watchedAt ?? this.watchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vodId.present) {
      map['vod_id'] = Variable<int>(vodId.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (episodeName.present) {
      map['episode_name'] = Variable<String>(episodeName.value);
    }
    if (episodeUrl.present) {
      map['episode_url'] = Variable<String>(episodeUrl.value);
    }
    if (watchedAt.present) {
      map['watched_at'] = Variable<DateTime>(watchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VodViewingHistoriesCompanion(')
          ..write('vodId: $vodId, ')
          ..write('sourceName: $sourceName, ')
          ..write('episodeName: $episodeName, ')
          ..write('episodeUrl: $episodeUrl, ')
          ..write('watchedAt: $watchedAt')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoriesTable extends SearchHistories
    with TableInfo<$SearchHistoriesTable, SearchHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _normalizedQueryMeta = const VerificationMeta(
    'normalizedQuery',
  );
  @override
  late final GeneratedColumn<String> normalizedQuery = GeneratedColumn<String>(
    'normalized_query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchedAtMeta = const VerificationMeta(
    'searchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> searchedAt = GeneratedColumn<DateTime>(
    'searched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [normalizedQuery, query, searchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('normalized_query')) {
      context.handle(
        _normalizedQueryMeta,
        normalizedQuery.isAcceptableOrUnknown(
          data['normalized_query']!,
          _normalizedQueryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedQueryMeta);
    }
    if (data.containsKey('query')) {
      context.handle(
        _queryMeta,
        query.isAcceptableOrUnknown(data['query']!, _queryMeta),
      );
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('searched_at')) {
      context.handle(
        _searchedAtMeta,
        searchedAt.isAcceptableOrUnknown(data['searched_at']!, _searchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_searchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {normalizedQuery};
  @override
  SearchHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistory(
      normalizedQuery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_query'],
      )!,
      query: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query'],
      )!,
      searchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}searched_at'],
      )!,
    );
  }

  @override
  $SearchHistoriesTable createAlias(String alias) {
    return $SearchHistoriesTable(attachedDatabase, alias);
  }
}

class SearchHistory extends DataClass implements Insertable<SearchHistory> {
  final String normalizedQuery;
  final String query;
  final DateTime searchedAt;
  const SearchHistory({
    required this.normalizedQuery,
    required this.query,
    required this.searchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['normalized_query'] = Variable<String>(normalizedQuery);
    map['query'] = Variable<String>(query);
    map['searched_at'] = Variable<DateTime>(searchedAt);
    return map;
  }

  SearchHistoriesCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoriesCompanion(
      normalizedQuery: Value(normalizedQuery),
      query: Value(query),
      searchedAt: Value(searchedAt),
    );
  }

  factory SearchHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistory(
      normalizedQuery: serializer.fromJson<String>(json['normalizedQuery']),
      query: serializer.fromJson<String>(json['query']),
      searchedAt: serializer.fromJson<DateTime>(json['searchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'normalizedQuery': serializer.toJson<String>(normalizedQuery),
      'query': serializer.toJson<String>(query),
      'searchedAt': serializer.toJson<DateTime>(searchedAt),
    };
  }

  SearchHistory copyWith({
    String? normalizedQuery,
    String? query,
    DateTime? searchedAt,
  }) => SearchHistory(
    normalizedQuery: normalizedQuery ?? this.normalizedQuery,
    query: query ?? this.query,
    searchedAt: searchedAt ?? this.searchedAt,
  );
  SearchHistory copyWithCompanion(SearchHistoriesCompanion data) {
    return SearchHistory(
      normalizedQuery: data.normalizedQuery.present
          ? data.normalizedQuery.value
          : this.normalizedQuery,
      query: data.query.present ? data.query.value : this.query,
      searchedAt: data.searchedAt.present
          ? data.searchedAt.value
          : this.searchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistory(')
          ..write('normalizedQuery: $normalizedQuery, ')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(normalizedQuery, query, searchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.normalizedQuery == this.normalizedQuery &&
          other.query == this.query &&
          other.searchedAt == this.searchedAt);
}

class SearchHistoriesCompanion extends UpdateCompanion<SearchHistory> {
  final Value<String> normalizedQuery;
  final Value<String> query;
  final Value<DateTime> searchedAt;
  final Value<int> rowid;
  const SearchHistoriesCompanion({
    this.normalizedQuery = const Value.absent(),
    this.query = const Value.absent(),
    this.searchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchHistoriesCompanion.insert({
    required String normalizedQuery,
    required String query,
    required DateTime searchedAt,
    this.rowid = const Value.absent(),
  }) : normalizedQuery = Value(normalizedQuery),
       query = Value(query),
       searchedAt = Value(searchedAt);
  static Insertable<SearchHistory> custom({
    Expression<String>? normalizedQuery,
    Expression<String>? query,
    Expression<DateTime>? searchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (normalizedQuery != null) 'normalized_query': normalizedQuery,
      if (query != null) 'query': query,
      if (searchedAt != null) 'searched_at': searchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchHistoriesCompanion copyWith({
    Value<String>? normalizedQuery,
    Value<String>? query,
    Value<DateTime>? searchedAt,
    Value<int>? rowid,
  }) {
    return SearchHistoriesCompanion(
      normalizedQuery: normalizedQuery ?? this.normalizedQuery,
      query: query ?? this.query,
      searchedAt: searchedAt ?? this.searchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (normalizedQuery.present) {
      map['normalized_query'] = Variable<String>(normalizedQuery.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (searchedAt.present) {
      map['searched_at'] = Variable<DateTime>(searchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoriesCompanion(')
          ..write('normalizedQuery: $normalizedQuery, ')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LibraryDatabase extends GeneratedDatabase {
  _$LibraryDatabase(QueryExecutor e) : super(e);
  $LibraryDatabaseManager get managers => $LibraryDatabaseManager(this);
  late final $StoredVodsTable storedVods = $StoredVodsTable(this);
  late final $VodFavoritesTable vodFavorites = $VodFavoritesTable(this);
  late final $VodViewingHistoriesTable vodViewingHistories =
      $VodViewingHistoriesTable(this);
  late final $SearchHistoriesTable searchHistories = $SearchHistoriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    storedVods,
    vodFavorites,
    vodViewingHistories,
    searchHistories,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'stored_vods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vod_favorites', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'stored_vods',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vod_viewing_histories', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$StoredVodsTableCreateCompanionBuilder =
    StoredVodsCompanion Function({
      Value<int> id,
      required int typeId,
      required int parentTypeId,
      required String name,
      required String typeName,
      required String picture,
      required String remarks,
      required String year,
      required String area,
      required String language,
      required String score,
      required String doubanScore,
      required String actor,
      required String director,
      required String category,
      required String summary,
      required String duration,
      required String playFrom,
      required String playUrl,
    });
typedef $$StoredVodsTableUpdateCompanionBuilder =
    StoredVodsCompanion Function({
      Value<int> id,
      Value<int> typeId,
      Value<int> parentTypeId,
      Value<String> name,
      Value<String> typeName,
      Value<String> picture,
      Value<String> remarks,
      Value<String> year,
      Value<String> area,
      Value<String> language,
      Value<String> score,
      Value<String> doubanScore,
      Value<String> actor,
      Value<String> director,
      Value<String> category,
      Value<String> summary,
      Value<String> duration,
      Value<String> playFrom,
      Value<String> playUrl,
    });

final class $$StoredVodsTableReferences
    extends BaseReferences<_$LibraryDatabase, $StoredVodsTable, StoredVod> {
  $$StoredVodsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VodFavoritesTable, List<VodFavorite>>
  _vodFavoritesRefsTable(_$LibraryDatabase db) => MultiTypedResultKey.fromTable(
    db.vodFavorites,
    aliasName: 'stored_vods__id__vod_favorites__vod_id',
  );

  $$VodFavoritesTableProcessedTableManager get vodFavoritesRefs {
    final manager = $$VodFavoritesTableTableManager(
      $_db,
      $_db.vodFavorites,
    ).filter((f) => f.vodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vodFavoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VodViewingHistoriesTable, List<VodViewingHistory>>
  _vodViewingHistoriesRefsTable(_$LibraryDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.vodViewingHistories,
        aliasName: 'stored_vods__id__vod_viewing_histories__vod_id',
      );

  $$VodViewingHistoriesTableProcessedTableManager get vodViewingHistoriesRefs {
    final manager = $$VodViewingHistoriesTableTableManager(
      $_db,
      $_db.vodViewingHistories,
    ).filter((f) => f.vodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vodViewingHistoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StoredVodsTableFilterComposer
    extends Composer<_$LibraryDatabase, $StoredVodsTable> {
  $$StoredVodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parentTypeId => $composableBuilder(
    column: $table.parentTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeName => $composableBuilder(
    column: $table.typeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get picture => $composableBuilder(
    column: $table.picture,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doubanScore => $composableBuilder(
    column: $table.doubanScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get director => $composableBuilder(
    column: $table.director,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playFrom => $composableBuilder(
    column: $table.playFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playUrl => $composableBuilder(
    column: $table.playUrl,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vodFavoritesRefs(
    Expression<bool> Function($$VodFavoritesTableFilterComposer f) f,
  ) {
    final $$VodFavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vodFavorites,
      getReferencedColumn: (t) => t.vodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VodFavoritesTableFilterComposer(
            $db: $db,
            $table: $db.vodFavorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vodViewingHistoriesRefs(
    Expression<bool> Function($$VodViewingHistoriesTableFilterComposer f) f,
  ) {
    final $$VodViewingHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vodViewingHistories,
      getReferencedColumn: (t) => t.vodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VodViewingHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.vodViewingHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoredVodsTableOrderingComposer
    extends Composer<_$LibraryDatabase, $StoredVodsTable> {
  $$StoredVodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parentTypeId => $composableBuilder(
    column: $table.parentTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeName => $composableBuilder(
    column: $table.typeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get picture => $composableBuilder(
    column: $table.picture,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doubanScore => $composableBuilder(
    column: $table.doubanScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get director => $composableBuilder(
    column: $table.director,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playFrom => $composableBuilder(
    column: $table.playFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playUrl => $composableBuilder(
    column: $table.playUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredVodsTableAnnotationComposer
    extends Composer<_$LibraryDatabase, $StoredVodsTable> {
  $$StoredVodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get typeId =>
      $composableBuilder(column: $table.typeId, builder: (column) => column);

  GeneratedColumn<int> get parentTypeId => $composableBuilder(
    column: $table.parentTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get typeName =>
      $composableBuilder(column: $table.typeName, builder: (column) => column);

  GeneratedColumn<String> get picture =>
      $composableBuilder(column: $table.picture, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get doubanScore => $composableBuilder(
    column: $table.doubanScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actor =>
      $composableBuilder(column: $table.actor, builder: (column) => column);

  GeneratedColumn<String> get director =>
      $composableBuilder(column: $table.director, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get playFrom =>
      $composableBuilder(column: $table.playFrom, builder: (column) => column);

  GeneratedColumn<String> get playUrl =>
      $composableBuilder(column: $table.playUrl, builder: (column) => column);

  Expression<T> vodFavoritesRefs<T extends Object>(
    Expression<T> Function($$VodFavoritesTableAnnotationComposer a) f,
  ) {
    final $$VodFavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vodFavorites,
      getReferencedColumn: (t) => t.vodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VodFavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.vodFavorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vodViewingHistoriesRefs<T extends Object>(
    Expression<T> Function($$VodViewingHistoriesTableAnnotationComposer a) f,
  ) {
    final $$VodViewingHistoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.vodViewingHistories,
          getReferencedColumn: (t) => t.vodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VodViewingHistoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.vodViewingHistories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$StoredVodsTableTableManager
    extends
        RootTableManager<
          _$LibraryDatabase,
          $StoredVodsTable,
          StoredVod,
          $$StoredVodsTableFilterComposer,
          $$StoredVodsTableOrderingComposer,
          $$StoredVodsTableAnnotationComposer,
          $$StoredVodsTableCreateCompanionBuilder,
          $$StoredVodsTableUpdateCompanionBuilder,
          (StoredVod, $$StoredVodsTableReferences),
          StoredVod,
          PrefetchHooks Function({
            bool vodFavoritesRefs,
            bool vodViewingHistoriesRefs,
          })
        > {
  $$StoredVodsTableTableManager(_$LibraryDatabase db, $StoredVodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredVodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredVodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredVodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> parentTypeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> typeName = const Value.absent(),
                Value<String> picture = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String> year = const Value.absent(),
                Value<String> area = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> score = const Value.absent(),
                Value<String> doubanScore = const Value.absent(),
                Value<String> actor = const Value.absent(),
                Value<String> director = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String> duration = const Value.absent(),
                Value<String> playFrom = const Value.absent(),
                Value<String> playUrl = const Value.absent(),
              }) => StoredVodsCompanion(
                id: id,
                typeId: typeId,
                parentTypeId: parentTypeId,
                name: name,
                typeName: typeName,
                picture: picture,
                remarks: remarks,
                year: year,
                area: area,
                language: language,
                score: score,
                doubanScore: doubanScore,
                actor: actor,
                director: director,
                category: category,
                summary: summary,
                duration: duration,
                playFrom: playFrom,
                playUrl: playUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int typeId,
                required int parentTypeId,
                required String name,
                required String typeName,
                required String picture,
                required String remarks,
                required String year,
                required String area,
                required String language,
                required String score,
                required String doubanScore,
                required String actor,
                required String director,
                required String category,
                required String summary,
                required String duration,
                required String playFrom,
                required String playUrl,
              }) => StoredVodsCompanion.insert(
                id: id,
                typeId: typeId,
                parentTypeId: parentTypeId,
                name: name,
                typeName: typeName,
                picture: picture,
                remarks: remarks,
                year: year,
                area: area,
                language: language,
                score: score,
                doubanScore: doubanScore,
                actor: actor,
                director: director,
                category: category,
                summary: summary,
                duration: duration,
                playFrom: playFrom,
                playUrl: playUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StoredVodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vodFavoritesRefs = false, vodViewingHistoriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vodFavoritesRefs) db.vodFavorites,
                    if (vodViewingHistoriesRefs) db.vodViewingHistories,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vodFavoritesRefs)
                        await $_getPrefetchedData<
                          StoredVod,
                          $StoredVodsTable,
                          VodFavorite
                        >(
                          currentTable: table,
                          referencedTable: $$StoredVodsTableReferences
                              ._vodFavoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoredVodsTableReferences(
                                db,
                                table,
                                p0,
                              ).vodFavoritesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vodViewingHistoriesRefs)
                        await $_getPrefetchedData<
                          StoredVod,
                          $StoredVodsTable,
                          VodViewingHistory
                        >(
                          currentTable: table,
                          referencedTable: $$StoredVodsTableReferences
                              ._vodViewingHistoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoredVodsTableReferences(
                                db,
                                table,
                                p0,
                              ).vodViewingHistoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vodId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StoredVodsTableProcessedTableManager =
    ProcessedTableManager<
      _$LibraryDatabase,
      $StoredVodsTable,
      StoredVod,
      $$StoredVodsTableFilterComposer,
      $$StoredVodsTableOrderingComposer,
      $$StoredVodsTableAnnotationComposer,
      $$StoredVodsTableCreateCompanionBuilder,
      $$StoredVodsTableUpdateCompanionBuilder,
      (StoredVod, $$StoredVodsTableReferences),
      StoredVod,
      PrefetchHooks Function({
        bool vodFavoritesRefs,
        bool vodViewingHistoriesRefs,
      })
    >;
typedef $$VodFavoritesTableCreateCompanionBuilder =
    VodFavoritesCompanion Function({
      Value<int> vodId,
      required DateTime createdAt,
    });
typedef $$VodFavoritesTableUpdateCompanionBuilder =
    VodFavoritesCompanion Function({
      Value<int> vodId,
      Value<DateTime> createdAt,
    });

final class $$VodFavoritesTableReferences
    extends BaseReferences<_$LibraryDatabase, $VodFavoritesTable, VodFavorite> {
  $$VodFavoritesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StoredVodsTable _vodIdTable(_$LibraryDatabase db) =>
      db.storedVods.createAlias('vod_favorites__vod_id__stored_vods__id');

  $$StoredVodsTableProcessedTableManager get vodId {
    final $_column = $_itemColumn<int>('vod_id')!;

    final manager = $$StoredVodsTableTableManager(
      $_db,
      $_db.storedVods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VodFavoritesTableFilterComposer
    extends Composer<_$LibraryDatabase, $VodFavoritesTable> {
  $$VodFavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StoredVodsTableFilterComposer get vodId {
    final $$StoredVodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vodId,
      referencedTable: $db.storedVods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoredVodsTableFilterComposer(
            $db: $db,
            $table: $db.storedVods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VodFavoritesTableOrderingComposer
    extends Composer<_$LibraryDatabase, $VodFavoritesTable> {
  $$VodFavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoredVodsTableOrderingComposer get vodId {
    final $$StoredVodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vodId,
      referencedTable: $db.storedVods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoredVodsTableOrderingComposer(
            $db: $db,
            $table: $db.storedVods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VodFavoritesTableAnnotationComposer
    extends Composer<_$LibraryDatabase, $VodFavoritesTable> {
  $$VodFavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StoredVodsTableAnnotationComposer get vodId {
    final $$StoredVodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vodId,
      referencedTable: $db.storedVods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoredVodsTableAnnotationComposer(
            $db: $db,
            $table: $db.storedVods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VodFavoritesTableTableManager
    extends
        RootTableManager<
          _$LibraryDatabase,
          $VodFavoritesTable,
          VodFavorite,
          $$VodFavoritesTableFilterComposer,
          $$VodFavoritesTableOrderingComposer,
          $$VodFavoritesTableAnnotationComposer,
          $$VodFavoritesTableCreateCompanionBuilder,
          $$VodFavoritesTableUpdateCompanionBuilder,
          (VodFavorite, $$VodFavoritesTableReferences),
          VodFavorite,
          PrefetchHooks Function({bool vodId})
        > {
  $$VodFavoritesTableTableManager(
    _$LibraryDatabase db,
    $VodFavoritesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VodFavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VodFavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VodFavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> vodId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VodFavoritesCompanion(vodId: vodId, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> vodId = const Value.absent(),
                required DateTime createdAt,
              }) => VodFavoritesCompanion.insert(
                vodId: vodId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VodFavoritesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vodId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vodId,
                                referencedTable: $$VodFavoritesTableReferences
                                    ._vodIdTable(db),
                                referencedColumn: $$VodFavoritesTableReferences
                                    ._vodIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VodFavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$LibraryDatabase,
      $VodFavoritesTable,
      VodFavorite,
      $$VodFavoritesTableFilterComposer,
      $$VodFavoritesTableOrderingComposer,
      $$VodFavoritesTableAnnotationComposer,
      $$VodFavoritesTableCreateCompanionBuilder,
      $$VodFavoritesTableUpdateCompanionBuilder,
      (VodFavorite, $$VodFavoritesTableReferences),
      VodFavorite,
      PrefetchHooks Function({bool vodId})
    >;
typedef $$VodViewingHistoriesTableCreateCompanionBuilder =
    VodViewingHistoriesCompanion Function({
      Value<int> vodId,
      required String sourceName,
      required String episodeName,
      required String episodeUrl,
      required DateTime watchedAt,
    });
typedef $$VodViewingHistoriesTableUpdateCompanionBuilder =
    VodViewingHistoriesCompanion Function({
      Value<int> vodId,
      Value<String> sourceName,
      Value<String> episodeName,
      Value<String> episodeUrl,
      Value<DateTime> watchedAt,
    });

final class $$VodViewingHistoriesTableReferences
    extends
        BaseReferences<
          _$LibraryDatabase,
          $VodViewingHistoriesTable,
          VodViewingHistory
        > {
  $$VodViewingHistoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoredVodsTable _vodIdTable(_$LibraryDatabase db) => db.storedVods
      .createAlias('vod_viewing_histories__vod_id__stored_vods__id');

  $$StoredVodsTableProcessedTableManager get vodId {
    final $_column = $_itemColumn<int>('vod_id')!;

    final manager = $$StoredVodsTableTableManager(
      $_db,
      $_db.storedVods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VodViewingHistoriesTableFilterComposer
    extends Composer<_$LibraryDatabase, $VodViewingHistoriesTable> {
  $$VodViewingHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get episodeName => $composableBuilder(
    column: $table.episodeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get episodeUrl => $composableBuilder(
    column: $table.episodeUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get watchedAt => $composableBuilder(
    column: $table.watchedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StoredVodsTableFilterComposer get vodId {
    final $$StoredVodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vodId,
      referencedTable: $db.storedVods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoredVodsTableFilterComposer(
            $db: $db,
            $table: $db.storedVods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VodViewingHistoriesTableOrderingComposer
    extends Composer<_$LibraryDatabase, $VodViewingHistoriesTable> {
  $$VodViewingHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get episodeName => $composableBuilder(
    column: $table.episodeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get episodeUrl => $composableBuilder(
    column: $table.episodeUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get watchedAt => $composableBuilder(
    column: $table.watchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoredVodsTableOrderingComposer get vodId {
    final $$StoredVodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vodId,
      referencedTable: $db.storedVods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoredVodsTableOrderingComposer(
            $db: $db,
            $table: $db.storedVods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VodViewingHistoriesTableAnnotationComposer
    extends Composer<_$LibraryDatabase, $VodViewingHistoriesTable> {
  $$VodViewingHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get episodeName => $composableBuilder(
    column: $table.episodeName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get episodeUrl => $composableBuilder(
    column: $table.episodeUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get watchedAt =>
      $composableBuilder(column: $table.watchedAt, builder: (column) => column);

  $$StoredVodsTableAnnotationComposer get vodId {
    final $$StoredVodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vodId,
      referencedTable: $db.storedVods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoredVodsTableAnnotationComposer(
            $db: $db,
            $table: $db.storedVods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VodViewingHistoriesTableTableManager
    extends
        RootTableManager<
          _$LibraryDatabase,
          $VodViewingHistoriesTable,
          VodViewingHistory,
          $$VodViewingHistoriesTableFilterComposer,
          $$VodViewingHistoriesTableOrderingComposer,
          $$VodViewingHistoriesTableAnnotationComposer,
          $$VodViewingHistoriesTableCreateCompanionBuilder,
          $$VodViewingHistoriesTableUpdateCompanionBuilder,
          (VodViewingHistory, $$VodViewingHistoriesTableReferences),
          VodViewingHistory,
          PrefetchHooks Function({bool vodId})
        > {
  $$VodViewingHistoriesTableTableManager(
    _$LibraryDatabase db,
    $VodViewingHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VodViewingHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VodViewingHistoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VodViewingHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> vodId = const Value.absent(),
                Value<String> sourceName = const Value.absent(),
                Value<String> episodeName = const Value.absent(),
                Value<String> episodeUrl = const Value.absent(),
                Value<DateTime> watchedAt = const Value.absent(),
              }) => VodViewingHistoriesCompanion(
                vodId: vodId,
                sourceName: sourceName,
                episodeName: episodeName,
                episodeUrl: episodeUrl,
                watchedAt: watchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> vodId = const Value.absent(),
                required String sourceName,
                required String episodeName,
                required String episodeUrl,
                required DateTime watchedAt,
              }) => VodViewingHistoriesCompanion.insert(
                vodId: vodId,
                sourceName: sourceName,
                episodeName: episodeName,
                episodeUrl: episodeUrl,
                watchedAt: watchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VodViewingHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vodId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vodId,
                                referencedTable:
                                    $$VodViewingHistoriesTableReferences
                                        ._vodIdTable(db),
                                referencedColumn:
                                    $$VodViewingHistoriesTableReferences
                                        ._vodIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VodViewingHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$LibraryDatabase,
      $VodViewingHistoriesTable,
      VodViewingHistory,
      $$VodViewingHistoriesTableFilterComposer,
      $$VodViewingHistoriesTableOrderingComposer,
      $$VodViewingHistoriesTableAnnotationComposer,
      $$VodViewingHistoriesTableCreateCompanionBuilder,
      $$VodViewingHistoriesTableUpdateCompanionBuilder,
      (VodViewingHistory, $$VodViewingHistoriesTableReferences),
      VodViewingHistory,
      PrefetchHooks Function({bool vodId})
    >;
typedef $$SearchHistoriesTableCreateCompanionBuilder =
    SearchHistoriesCompanion Function({
      required String normalizedQuery,
      required String query,
      required DateTime searchedAt,
      Value<int> rowid,
    });
typedef $$SearchHistoriesTableUpdateCompanionBuilder =
    SearchHistoriesCompanion Function({
      Value<String> normalizedQuery,
      Value<String> query,
      Value<DateTime> searchedAt,
      Value<int> rowid,
    });

class $$SearchHistoriesTableFilterComposer
    extends Composer<_$LibraryDatabase, $SearchHistoriesTable> {
  $$SearchHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get normalizedQuery => $composableBuilder(
    column: $table.normalizedQuery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get searchedAt => $composableBuilder(
    column: $table.searchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchHistoriesTableOrderingComposer
    extends Composer<_$LibraryDatabase, $SearchHistoriesTable> {
  $$SearchHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get normalizedQuery => $composableBuilder(
    column: $table.normalizedQuery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get searchedAt => $composableBuilder(
    column: $table.searchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchHistoriesTableAnnotationComposer
    extends Composer<_$LibraryDatabase, $SearchHistoriesTable> {
  $$SearchHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get normalizedQuery => $composableBuilder(
    column: $table.normalizedQuery,
    builder: (column) => column,
  );

  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumn<DateTime> get searchedAt => $composableBuilder(
    column: $table.searchedAt,
    builder: (column) => column,
  );
}

class $$SearchHistoriesTableTableManager
    extends
        RootTableManager<
          _$LibraryDatabase,
          $SearchHistoriesTable,
          SearchHistory,
          $$SearchHistoriesTableFilterComposer,
          $$SearchHistoriesTableOrderingComposer,
          $$SearchHistoriesTableAnnotationComposer,
          $$SearchHistoriesTableCreateCompanionBuilder,
          $$SearchHistoriesTableUpdateCompanionBuilder,
          (
            SearchHistory,
            BaseReferences<
              _$LibraryDatabase,
              $SearchHistoriesTable,
              SearchHistory
            >,
          ),
          SearchHistory,
          PrefetchHooks Function()
        > {
  $$SearchHistoriesTableTableManager(
    _$LibraryDatabase db,
    $SearchHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> normalizedQuery = const Value.absent(),
                Value<String> query = const Value.absent(),
                Value<DateTime> searchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchHistoriesCompanion(
                normalizedQuery: normalizedQuery,
                query: query,
                searchedAt: searchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String normalizedQuery,
                required String query,
                required DateTime searchedAt,
                Value<int> rowid = const Value.absent(),
              }) => SearchHistoriesCompanion.insert(
                normalizedQuery: normalizedQuery,
                query: query,
                searchedAt: searchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$LibraryDatabase,
      $SearchHistoriesTable,
      SearchHistory,
      $$SearchHistoriesTableFilterComposer,
      $$SearchHistoriesTableOrderingComposer,
      $$SearchHistoriesTableAnnotationComposer,
      $$SearchHistoriesTableCreateCompanionBuilder,
      $$SearchHistoriesTableUpdateCompanionBuilder,
      (
        SearchHistory,
        BaseReferences<_$LibraryDatabase, $SearchHistoriesTable, SearchHistory>,
      ),
      SearchHistory,
      PrefetchHooks Function()
    >;

class $LibraryDatabaseManager {
  final _$LibraryDatabase _db;
  $LibraryDatabaseManager(this._db);
  $$StoredVodsTableTableManager get storedVods =>
      $$StoredVodsTableTableManager(_db, _db.storedVods);
  $$VodFavoritesTableTableManager get vodFavorites =>
      $$VodFavoritesTableTableManager(_db, _db.vodFavorites);
  $$VodViewingHistoriesTableTableManager get vodViewingHistories =>
      $$VodViewingHistoriesTableTableManager(_db, _db.vodViewingHistories);
  $$SearchHistoriesTableTableManager get searchHistories =>
      $$SearchHistoriesTableTableManager(_db, _db.searchHistories);
}
