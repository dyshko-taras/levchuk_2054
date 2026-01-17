// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _badgeIconMeta = const VerificationMeta(
    'badgeIcon',
  );
  @override
  late final GeneratedColumn<String> badgeIcon = GeneratedColumn<String>(
    'badge_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _homeKitTemplateIdMeta = const VerificationMeta(
    'homeKitTemplateId',
  );
  @override
  late final GeneratedColumn<String> homeKitTemplateId =
      GeneratedColumn<String>(
        'home_kit_template_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('default'),
      );
  static const VerificationMeta _homePrimaryColorMeta = const VerificationMeta(
    'homePrimaryColor',
  );
  @override
  late final GeneratedColumn<int> homePrimaryColor = GeneratedColumn<int>(
    'home_primary_color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _homeSecondaryColorMeta =
      const VerificationMeta('homeSecondaryColor');
  @override
  late final GeneratedColumn<int> homeSecondaryColor = GeneratedColumn<int>(
    'home_secondary_color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _awayKitTemplateIdMeta = const VerificationMeta(
    'awayKitTemplateId',
  );
  @override
  late final GeneratedColumn<String> awayKitTemplateId =
      GeneratedColumn<String>(
        'away_kit_template_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('default'),
      );
  static const VerificationMeta _awayPrimaryColorMeta = const VerificationMeta(
    'awayPrimaryColor',
  );
  @override
  late final GeneratedColumn<int> awayPrimaryColor = GeneratedColumn<int>(
    'away_primary_color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _awaySecondaryColorMeta =
      const VerificationMeta('awaySecondaryColor');
  @override
  late final GeneratedColumn<int> awaySecondaryColor = GeneratedColumn<int>(
    'away_secondary_color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    badgeIcon,
    homeKitTemplateId,
    homePrimaryColor,
    homeSecondaryColor,
    awayKitTemplateId,
    awayPrimaryColor,
    awaySecondaryColor,
    isDefault,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<Team> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('badge_icon')) {
      context.handle(
        _badgeIconMeta,
        badgeIcon.isAcceptableOrUnknown(data['badge_icon']!, _badgeIconMeta),
      );
    }
    if (data.containsKey('home_kit_template_id')) {
      context.handle(
        _homeKitTemplateIdMeta,
        homeKitTemplateId.isAcceptableOrUnknown(
          data['home_kit_template_id']!,
          _homeKitTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('home_primary_color')) {
      context.handle(
        _homePrimaryColorMeta,
        homePrimaryColor.isAcceptableOrUnknown(
          data['home_primary_color']!,
          _homePrimaryColorMeta,
        ),
      );
    }
    if (data.containsKey('home_secondary_color')) {
      context.handle(
        _homeSecondaryColorMeta,
        homeSecondaryColor.isAcceptableOrUnknown(
          data['home_secondary_color']!,
          _homeSecondaryColorMeta,
        ),
      );
    }
    if (data.containsKey('away_kit_template_id')) {
      context.handle(
        _awayKitTemplateIdMeta,
        awayKitTemplateId.isAcceptableOrUnknown(
          data['away_kit_template_id']!,
          _awayKitTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('away_primary_color')) {
      context.handle(
        _awayPrimaryColorMeta,
        awayPrimaryColor.isAcceptableOrUnknown(
          data['away_primary_color']!,
          _awayPrimaryColorMeta,
        ),
      );
    }
    if (data.containsKey('away_secondary_color')) {
      context.handle(
        _awaySecondaryColorMeta,
        awaySecondaryColor.isAcceptableOrUnknown(
          data['away_secondary_color']!,
          _awaySecondaryColorMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      badgeIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge_icon'],
      ),
      homeKitTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_kit_template_id'],
      )!,
      homePrimaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}home_primary_color'],
      ),
      homeSecondaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}home_secondary_color'],
      ),
      awayKitTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}away_kit_template_id'],
      )!,
      awayPrimaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}away_primary_color'],
      ),
      awaySecondaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}away_secondary_color'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final int id;
  final String name;
  final String? badgeIcon;
  final String homeKitTemplateId;
  final int? homePrimaryColor;
  final int? homeSecondaryColor;
  final String awayKitTemplateId;
  final int? awayPrimaryColor;
  final int? awaySecondaryColor;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Team({
    required this.id,
    required this.name,
    this.badgeIcon,
    required this.homeKitTemplateId,
    this.homePrimaryColor,
    this.homeSecondaryColor,
    required this.awayKitTemplateId,
    this.awayPrimaryColor,
    this.awaySecondaryColor,
    required this.isDefault,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || badgeIcon != null) {
      map['badge_icon'] = Variable<String>(badgeIcon);
    }
    map['home_kit_template_id'] = Variable<String>(homeKitTemplateId);
    if (!nullToAbsent || homePrimaryColor != null) {
      map['home_primary_color'] = Variable<int>(homePrimaryColor);
    }
    if (!nullToAbsent || homeSecondaryColor != null) {
      map['home_secondary_color'] = Variable<int>(homeSecondaryColor);
    }
    map['away_kit_template_id'] = Variable<String>(awayKitTemplateId);
    if (!nullToAbsent || awayPrimaryColor != null) {
      map['away_primary_color'] = Variable<int>(awayPrimaryColor);
    }
    if (!nullToAbsent || awaySecondaryColor != null) {
      map['away_secondary_color'] = Variable<int>(awaySecondaryColor);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      name: Value(name),
      badgeIcon: badgeIcon == null && nullToAbsent
          ? const Value.absent()
          : Value(badgeIcon),
      homeKitTemplateId: Value(homeKitTemplateId),
      homePrimaryColor: homePrimaryColor == null && nullToAbsent
          ? const Value.absent()
          : Value(homePrimaryColor),
      homeSecondaryColor: homeSecondaryColor == null && nullToAbsent
          ? const Value.absent()
          : Value(homeSecondaryColor),
      awayKitTemplateId: Value(awayKitTemplateId),
      awayPrimaryColor: awayPrimaryColor == null && nullToAbsent
          ? const Value.absent()
          : Value(awayPrimaryColor),
      awaySecondaryColor: awaySecondaryColor == null && nullToAbsent
          ? const Value.absent()
          : Value(awaySecondaryColor),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Team.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      badgeIcon: serializer.fromJson<String?>(json['badgeIcon']),
      homeKitTemplateId: serializer.fromJson<String>(json['homeKitTemplateId']),
      homePrimaryColor: serializer.fromJson<int?>(json['homePrimaryColor']),
      homeSecondaryColor: serializer.fromJson<int?>(json['homeSecondaryColor']),
      awayKitTemplateId: serializer.fromJson<String>(json['awayKitTemplateId']),
      awayPrimaryColor: serializer.fromJson<int?>(json['awayPrimaryColor']),
      awaySecondaryColor: serializer.fromJson<int?>(json['awaySecondaryColor']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'badgeIcon': serializer.toJson<String?>(badgeIcon),
      'homeKitTemplateId': serializer.toJson<String>(homeKitTemplateId),
      'homePrimaryColor': serializer.toJson<int?>(homePrimaryColor),
      'homeSecondaryColor': serializer.toJson<int?>(homeSecondaryColor),
      'awayKitTemplateId': serializer.toJson<String>(awayKitTemplateId),
      'awayPrimaryColor': serializer.toJson<int?>(awayPrimaryColor),
      'awaySecondaryColor': serializer.toJson<int?>(awaySecondaryColor),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Team copyWith({
    int? id,
    String? name,
    Value<String?> badgeIcon = const Value.absent(),
    String? homeKitTemplateId,
    Value<int?> homePrimaryColor = const Value.absent(),
    Value<int?> homeSecondaryColor = const Value.absent(),
    String? awayKitTemplateId,
    Value<int?> awayPrimaryColor = const Value.absent(),
    Value<int?> awaySecondaryColor = const Value.absent(),
    bool? isDefault,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Team(
    id: id ?? this.id,
    name: name ?? this.name,
    badgeIcon: badgeIcon.present ? badgeIcon.value : this.badgeIcon,
    homeKitTemplateId: homeKitTemplateId ?? this.homeKitTemplateId,
    homePrimaryColor: homePrimaryColor.present
        ? homePrimaryColor.value
        : this.homePrimaryColor,
    homeSecondaryColor: homeSecondaryColor.present
        ? homeSecondaryColor.value
        : this.homeSecondaryColor,
    awayKitTemplateId: awayKitTemplateId ?? this.awayKitTemplateId,
    awayPrimaryColor: awayPrimaryColor.present
        ? awayPrimaryColor.value
        : this.awayPrimaryColor,
    awaySecondaryColor: awaySecondaryColor.present
        ? awaySecondaryColor.value
        : this.awaySecondaryColor,
    isDefault: isDefault ?? this.isDefault,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      badgeIcon: data.badgeIcon.present ? data.badgeIcon.value : this.badgeIcon,
      homeKitTemplateId: data.homeKitTemplateId.present
          ? data.homeKitTemplateId.value
          : this.homeKitTemplateId,
      homePrimaryColor: data.homePrimaryColor.present
          ? data.homePrimaryColor.value
          : this.homePrimaryColor,
      homeSecondaryColor: data.homeSecondaryColor.present
          ? data.homeSecondaryColor.value
          : this.homeSecondaryColor,
      awayKitTemplateId: data.awayKitTemplateId.present
          ? data.awayKitTemplateId.value
          : this.awayKitTemplateId,
      awayPrimaryColor: data.awayPrimaryColor.present
          ? data.awayPrimaryColor.value
          : this.awayPrimaryColor,
      awaySecondaryColor: data.awaySecondaryColor.present
          ? data.awaySecondaryColor.value
          : this.awaySecondaryColor,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('badgeIcon: $badgeIcon, ')
          ..write('homeKitTemplateId: $homeKitTemplateId, ')
          ..write('homePrimaryColor: $homePrimaryColor, ')
          ..write('homeSecondaryColor: $homeSecondaryColor, ')
          ..write('awayKitTemplateId: $awayKitTemplateId, ')
          ..write('awayPrimaryColor: $awayPrimaryColor, ')
          ..write('awaySecondaryColor: $awaySecondaryColor, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    badgeIcon,
    homeKitTemplateId,
    homePrimaryColor,
    homeSecondaryColor,
    awayKitTemplateId,
    awayPrimaryColor,
    awaySecondaryColor,
    isDefault,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.name == this.name &&
          other.badgeIcon == this.badgeIcon &&
          other.homeKitTemplateId == this.homeKitTemplateId &&
          other.homePrimaryColor == this.homePrimaryColor &&
          other.homeSecondaryColor == this.homeSecondaryColor &&
          other.awayKitTemplateId == this.awayKitTemplateId &&
          other.awayPrimaryColor == this.awayPrimaryColor &&
          other.awaySecondaryColor == this.awaySecondaryColor &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> badgeIcon;
  final Value<String> homeKitTemplateId;
  final Value<int?> homePrimaryColor;
  final Value<int?> homeSecondaryColor;
  final Value<String> awayKitTemplateId;
  final Value<int?> awayPrimaryColor;
  final Value<int?> awaySecondaryColor;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.badgeIcon = const Value.absent(),
    this.homeKitTemplateId = const Value.absent(),
    this.homePrimaryColor = const Value.absent(),
    this.homeSecondaryColor = const Value.absent(),
    this.awayKitTemplateId = const Value.absent(),
    this.awayPrimaryColor = const Value.absent(),
    this.awaySecondaryColor = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.badgeIcon = const Value.absent(),
    this.homeKitTemplateId = const Value.absent(),
    this.homePrimaryColor = const Value.absent(),
    this.homeSecondaryColor = const Value.absent(),
    this.awayKitTemplateId = const Value.absent(),
    this.awayPrimaryColor = const Value.absent(),
    this.awaySecondaryColor = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Team> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? badgeIcon,
    Expression<String>? homeKitTemplateId,
    Expression<int>? homePrimaryColor,
    Expression<int>? homeSecondaryColor,
    Expression<String>? awayKitTemplateId,
    Expression<int>? awayPrimaryColor,
    Expression<int>? awaySecondaryColor,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (badgeIcon != null) 'badge_icon': badgeIcon,
      if (homeKitTemplateId != null) 'home_kit_template_id': homeKitTemplateId,
      if (homePrimaryColor != null) 'home_primary_color': homePrimaryColor,
      if (homeSecondaryColor != null)
        'home_secondary_color': homeSecondaryColor,
      if (awayKitTemplateId != null) 'away_kit_template_id': awayKitTemplateId,
      if (awayPrimaryColor != null) 'away_primary_color': awayPrimaryColor,
      if (awaySecondaryColor != null)
        'away_secondary_color': awaySecondaryColor,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TeamsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? badgeIcon,
    Value<String>? homeKitTemplateId,
    Value<int?>? homePrimaryColor,
    Value<int?>? homeSecondaryColor,
    Value<String>? awayKitTemplateId,
    Value<int?>? awayPrimaryColor,
    Value<int?>? awaySecondaryColor,
    Value<bool>? isDefault,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return TeamsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      badgeIcon: badgeIcon ?? this.badgeIcon,
      homeKitTemplateId: homeKitTemplateId ?? this.homeKitTemplateId,
      homePrimaryColor: homePrimaryColor ?? this.homePrimaryColor,
      homeSecondaryColor: homeSecondaryColor ?? this.homeSecondaryColor,
      awayKitTemplateId: awayKitTemplateId ?? this.awayKitTemplateId,
      awayPrimaryColor: awayPrimaryColor ?? this.awayPrimaryColor,
      awaySecondaryColor: awaySecondaryColor ?? this.awaySecondaryColor,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (badgeIcon.present) {
      map['badge_icon'] = Variable<String>(badgeIcon.value);
    }
    if (homeKitTemplateId.present) {
      map['home_kit_template_id'] = Variable<String>(homeKitTemplateId.value);
    }
    if (homePrimaryColor.present) {
      map['home_primary_color'] = Variable<int>(homePrimaryColor.value);
    }
    if (homeSecondaryColor.present) {
      map['home_secondary_color'] = Variable<int>(homeSecondaryColor.value);
    }
    if (awayKitTemplateId.present) {
      map['away_kit_template_id'] = Variable<String>(awayKitTemplateId.value);
    }
    if (awayPrimaryColor.present) {
      map['away_primary_color'] = Variable<int>(awayPrimaryColor.value);
    }
    if (awaySecondaryColor.present) {
      map['away_secondary_color'] = Variable<int>(awaySecondaryColor.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('badgeIcon: $badgeIcon, ')
          ..write('homeKitTemplateId: $homeKitTemplateId, ')
          ..write('homePrimaryColor: $homePrimaryColor, ')
          ..write('homeSecondaryColor: $homeSecondaryColor, ')
          ..write('awayKitTemplateId: $awayKitTemplateId, ')
          ..write('awayPrimaryColor: $awayPrimaryColor, ')
          ..write('awaySecondaryColor: $awaySecondaryColor, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
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
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCaptainMeta = const VerificationMeta(
    'isCaptain',
  );
  @override
  late final GeneratedColumn<bool> isCaptain = GeneratedColumn<bool>(
    'is_captain',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_captain" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    name,
    position,
    number,
    isCaptain,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('is_captain')) {
      context.handle(
        _isCaptainMeta,
        isCaptain.isAcceptableOrUnknown(data['is_captain']!, _isCaptainMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      ),
      isCaptain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_captain'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final int teamId;
  final String name;
  final String? position;
  final int? number;
  final bool isCaptain;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Player({
    required this.id,
    required this.teamId,
    required this.name,
    this.position,
    this.number,
    required this.isCaptain,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['team_id'] = Variable<int>(teamId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<int>(number);
    }
    map['is_captain'] = Variable<bool>(isCaptain);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      teamId: Value(teamId),
      name: Value(name),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      isCaptain: Value(isCaptain),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      teamId: serializer.fromJson<int>(json['teamId']),
      name: serializer.fromJson<String>(json['name']),
      position: serializer.fromJson<String?>(json['position']),
      number: serializer.fromJson<int?>(json['number']),
      isCaptain: serializer.fromJson<bool>(json['isCaptain']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'teamId': serializer.toJson<int>(teamId),
      'name': serializer.toJson<String>(name),
      'position': serializer.toJson<String?>(position),
      'number': serializer.toJson<int?>(number),
      'isCaptain': serializer.toJson<bool>(isCaptain),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Player copyWith({
    int? id,
    int? teamId,
    String? name,
    Value<String?> position = const Value.absent(),
    Value<int?> number = const Value.absent(),
    bool? isCaptain,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Player(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    name: name ?? this.name,
    position: position.present ? position.value : this.position,
    number: number.present ? number.value : this.number,
    isCaptain: isCaptain ?? this.isCaptain,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      name: data.name.present ? data.name.value : this.name,
      position: data.position.present ? data.position.value : this.position,
      number: data.number.present ? data.number.value : this.number,
      isCaptain: data.isCaptain.present ? data.isCaptain.value : this.isCaptain,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('number: $number, ')
          ..write('isCaptain: $isCaptain, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    name,
    position,
    number,
    isCaptain,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.name == this.name &&
          other.position == this.position &&
          other.number == this.number &&
          other.isCaptain == this.isCaptain &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<int> teamId;
  final Value<String> name;
  final Value<String?> position;
  final Value<int?> number;
  final Value<bool> isCaptain;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.name = const Value.absent(),
    this.position = const Value.absent(),
    this.number = const Value.absent(),
    this.isCaptain = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required int teamId,
    required String name,
    this.position = const Value.absent(),
    this.number = const Value.absent(),
    this.isCaptain = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : teamId = Value(teamId),
       name = Value(name);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<int>? teamId,
    Expression<String>? name,
    Expression<String>? position,
    Expression<int>? number,
    Expression<bool>? isCaptain,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (name != null) 'name': name,
      if (position != null) 'position': position,
      if (number != null) 'number': number,
      if (isCaptain != null) 'is_captain': isCaptain,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? id,
    Value<int>? teamId,
    Value<String>? name,
    Value<String?>? position,
    Value<int?>? number,
    Value<bool>? isCaptain,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      name: name ?? this.name,
      position: position ?? this.position,
      number: number ?? this.number,
      isCaptain: isCaptain ?? this.isCaptain,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (isCaptain.present) {
      map['is_captain'] = Variable<bool>(isCaptain.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('number: $number, ')
          ..write('isCaptain: $isCaptain, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FieldsTable extends Fields with TableInfo<$FieldsTable, Field> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    type,
    notes,
    lat,
    lon,
    photoPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fields';
  @override
  VerificationContext validateIntegrity(
    Insertable<Field> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Field map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Field(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      ),
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $FieldsTable createAlias(String alias) {
    return $FieldsTable(attachedDatabase, alias);
  }
}

class Field extends DataClass implements Insertable<Field> {
  final int id;
  final String name;
  final String? address;
  final String? type;
  final String? notes;
  final double? lat;
  final double? lon;
  final String? photoPath;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Field({
    required this.id,
    required this.name,
    this.address,
    this.type,
    this.notes,
    this.lat,
    this.lon,
    this.photoPath,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lon != null) {
      map['lon'] = Variable<double>(lon);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  FieldsCompanion toCompanion(bool nullToAbsent) {
    return FieldsCompanion(
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lon: lon == null && nullToAbsent ? const Value.absent() : Value(lon),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Field.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Field(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      type: serializer.fromJson<String?>(json['type']),
      notes: serializer.fromJson<String?>(json['notes']),
      lat: serializer.fromJson<double?>(json['lat']),
      lon: serializer.fromJson<double?>(json['lon']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'type': serializer.toJson<String?>(type),
      'notes': serializer.toJson<String?>(notes),
      'lat': serializer.toJson<double?>(lat),
      'lon': serializer.toJson<double?>(lon),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Field copyWith({
    int? id,
    String? name,
    Value<String?> address = const Value.absent(),
    Value<String?> type = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<double?> lat = const Value.absent(),
    Value<double?> lon = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Field(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    type: type.present ? type.value : this.type,
    notes: notes.present ? notes.value : this.notes,
    lat: lat.present ? lat.value : this.lat,
    lon: lon.present ? lon.value : this.lon,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Field copyWithCompanion(FieldsCompanion data) {
    return Field(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      type: data.type.present ? data.type.value : this.type,
      notes: data.notes.present ? data.notes.value : this.notes,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Field(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('type: $type, ')
          ..write('notes: $notes, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    address,
    type,
    notes,
    lat,
    lon,
    photoPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Field &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.type == this.type &&
          other.notes == this.notes &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FieldsCompanion extends UpdateCompanion<Field> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> type;
  final Value<String?> notes;
  final Value<double?> lat;
  final Value<double?> lon;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const FieldsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.type = const Value.absent(),
    this.notes = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FieldsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.type = const Value.absent(),
    this.notes = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Field> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? type,
    Expression<String>? notes,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (type != null) 'type': type,
      if (notes != null) 'notes': notes,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FieldsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? address,
    Value<String?>? type,
    Value<String?>? notes,
    Value<double?>? lat,
    Value<double?>? lon,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return FieldsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      type: type ?? this.type,
      notes: notes ?? this.notes,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('type: $type, ')
          ..write('notes: $notes, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MatchesTable extends Matches with TableInfo<$MatchesTable, Fixture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fieldIdMeta = const VerificationMeta(
    'fieldId',
  );
  @override
  late final GeneratedColumn<int> fieldId = GeneratedColumn<int>(
    'field_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teamAIdMeta = const VerificationMeta(
    'teamAId',
  );
  @override
  late final GeneratedColumn<int> teamAId = GeneratedColumn<int>(
    'team_a_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teamBIdMeta = const VerificationMeta(
    'teamBId',
  );
  @override
  late final GeneratedColumn<int> teamBId = GeneratedColumn<int>(
    'team_b_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('planned'),
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreAMeta = const VerificationMeta('scoreA');
  @override
  late final GeneratedColumn<int> scoreA = GeneratedColumn<int>(
    'score_a',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreBMeta = const VerificationMeta('scoreB');
  @override
  late final GeneratedColumn<int> scoreB = GeneratedColumn<int>(
    'score_b',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    startAt,
    endAt,
    fieldId,
    teamAId,
    teamBId,
    status,
    result,
    scoreA,
    scoreB,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fixture> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    }
    if (data.containsKey('field_id')) {
      context.handle(
        _fieldIdMeta,
        fieldId.isAcceptableOrUnknown(data['field_id']!, _fieldIdMeta),
      );
    }
    if (data.containsKey('team_a_id')) {
      context.handle(
        _teamAIdMeta,
        teamAId.isAcceptableOrUnknown(data['team_a_id']!, _teamAIdMeta),
      );
    }
    if (data.containsKey('team_b_id')) {
      context.handle(
        _teamBIdMeta,
        teamBId.isAcceptableOrUnknown(data['team_b_id']!, _teamBIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    }
    if (data.containsKey('score_a')) {
      context.handle(
        _scoreAMeta,
        scoreA.isAcceptableOrUnknown(data['score_a']!, _scoreAMeta),
      );
    }
    if (data.containsKey('score_b')) {
      context.handle(
        _scoreBMeta,
        scoreB.isAcceptableOrUnknown(data['score_b']!, _scoreBMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fixture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fixture(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      ),
      fieldId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}field_id'],
      ),
      teamAId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_a_id'],
      ),
      teamBId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_b_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      ),
      scoreA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_a'],
      ),
      scoreB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_b'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }
}

class Fixture extends DataClass implements Insertable<Fixture> {
  final int id;
  final String title;
  final DateTime startAt;
  final DateTime? endAt;
  final int? fieldId;
  final int? teamAId;
  final int? teamBId;
  final String status;
  final String? result;
  final int? scoreA;
  final int? scoreB;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Fixture({
    required this.id,
    required this.title,
    required this.startAt,
    this.endAt,
    this.fieldId,
    this.teamAId,
    this.teamBId,
    required this.status,
    this.result,
    this.scoreA,
    this.scoreB,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['start_at'] = Variable<DateTime>(startAt);
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<DateTime>(endAt);
    }
    if (!nullToAbsent || fieldId != null) {
      map['field_id'] = Variable<int>(fieldId);
    }
    if (!nullToAbsent || teamAId != null) {
      map['team_a_id'] = Variable<int>(teamAId);
    }
    if (!nullToAbsent || teamBId != null) {
      map['team_b_id'] = Variable<int>(teamBId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    if (!nullToAbsent || scoreA != null) {
      map['score_a'] = Variable<int>(scoreA);
    }
    if (!nullToAbsent || scoreB != null) {
      map['score_b'] = Variable<int>(scoreB);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      title: Value(title),
      startAt: Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
      fieldId: fieldId == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldId),
      teamAId: teamAId == null && nullToAbsent
          ? const Value.absent()
          : Value(teamAId),
      teamBId: teamBId == null && nullToAbsent
          ? const Value.absent()
          : Value(teamBId),
      status: Value(status),
      result: result == null && nullToAbsent
          ? const Value.absent()
          : Value(result),
      scoreA: scoreA == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreA),
      scoreB: scoreB == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreB),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Fixture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fixture(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime?>(json['endAt']),
      fieldId: serializer.fromJson<int?>(json['fieldId']),
      teamAId: serializer.fromJson<int?>(json['teamAId']),
      teamBId: serializer.fromJson<int?>(json['teamBId']),
      status: serializer.fromJson<String>(json['status']),
      result: serializer.fromJson<String?>(json['result']),
      scoreA: serializer.fromJson<int?>(json['scoreA']),
      scoreB: serializer.fromJson<int?>(json['scoreB']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime?>(endAt),
      'fieldId': serializer.toJson<int?>(fieldId),
      'teamAId': serializer.toJson<int?>(teamAId),
      'teamBId': serializer.toJson<int?>(teamBId),
      'status': serializer.toJson<String>(status),
      'result': serializer.toJson<String?>(result),
      'scoreA': serializer.toJson<int?>(scoreA),
      'scoreB': serializer.toJson<int?>(scoreB),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Fixture copyWith({
    int? id,
    String? title,
    DateTime? startAt,
    Value<DateTime?> endAt = const Value.absent(),
    Value<int?> fieldId = const Value.absent(),
    Value<int?> teamAId = const Value.absent(),
    Value<int?> teamBId = const Value.absent(),
    String? status,
    Value<String?> result = const Value.absent(),
    Value<int?> scoreA = const Value.absent(),
    Value<int?> scoreB = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Fixture(
    id: id ?? this.id,
    title: title ?? this.title,
    startAt: startAt ?? this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
    fieldId: fieldId.present ? fieldId.value : this.fieldId,
    teamAId: teamAId.present ? teamAId.value : this.teamAId,
    teamBId: teamBId.present ? teamBId.value : this.teamBId,
    status: status ?? this.status,
    result: result.present ? result.value : this.result,
    scoreA: scoreA.present ? scoreA.value : this.scoreA,
    scoreB: scoreB.present ? scoreB.value : this.scoreB,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Fixture copyWithCompanion(MatchesCompanion data) {
    return Fixture(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      fieldId: data.fieldId.present ? data.fieldId.value : this.fieldId,
      teamAId: data.teamAId.present ? data.teamAId.value : this.teamAId,
      teamBId: data.teamBId.present ? data.teamBId.value : this.teamBId,
      status: data.status.present ? data.status.value : this.status,
      result: data.result.present ? data.result.value : this.result,
      scoreA: data.scoreA.present ? data.scoreA.value : this.scoreA,
      scoreB: data.scoreB.present ? data.scoreB.value : this.scoreB,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fixture(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('fieldId: $fieldId, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('status: $status, ')
          ..write('result: $result, ')
          ..write('scoreA: $scoreA, ')
          ..write('scoreB: $scoreB, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    startAt,
    endAt,
    fieldId,
    teamAId,
    teamBId,
    status,
    result,
    scoreA,
    scoreB,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fixture &&
          other.id == this.id &&
          other.title == this.title &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.fieldId == this.fieldId &&
          other.teamAId == this.teamAId &&
          other.teamBId == this.teamBId &&
          other.status == this.status &&
          other.result == this.result &&
          other.scoreA == this.scoreA &&
          other.scoreB == this.scoreB &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MatchesCompanion extends UpdateCompanion<Fixture> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> startAt;
  final Value<DateTime?> endAt;
  final Value<int?> fieldId;
  final Value<int?> teamAId;
  final Value<int?> teamBId;
  final Value<String> status;
  final Value<String?> result;
  final Value<int?> scoreA;
  final Value<int?> scoreB;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.fieldId = const Value.absent(),
    this.teamAId = const Value.absent(),
    this.teamBId = const Value.absent(),
    this.status = const Value.absent(),
    this.result = const Value.absent(),
    this.scoreA = const Value.absent(),
    this.scoreB = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MatchesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime startAt,
    this.endAt = const Value.absent(),
    this.fieldId = const Value.absent(),
    this.teamAId = const Value.absent(),
    this.teamBId = const Value.absent(),
    this.status = const Value.absent(),
    this.result = const Value.absent(),
    this.scoreA = const Value.absent(),
    this.scoreB = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       startAt = Value(startAt);
  static Insertable<Fixture> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<int>? fieldId,
    Expression<int>? teamAId,
    Expression<int>? teamBId,
    Expression<String>? status,
    Expression<String>? result,
    Expression<int>? scoreA,
    Expression<int>? scoreB,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (fieldId != null) 'field_id': fieldId,
      if (teamAId != null) 'team_a_id': teamAId,
      if (teamBId != null) 'team_b_id': teamBId,
      if (status != null) 'status': status,
      if (result != null) 'result': result,
      if (scoreA != null) 'score_a': scoreA,
      if (scoreB != null) 'score_b': scoreB,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MatchesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<DateTime>? startAt,
    Value<DateTime?>? endAt,
    Value<int?>? fieldId,
    Value<int?>? teamAId,
    Value<int?>? teamBId,
    Value<String>? status,
    Value<String?>? result,
    Value<int?>? scoreA,
    Value<int?>? scoreB,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return MatchesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      fieldId: fieldId ?? this.fieldId,
      teamAId: teamAId ?? this.teamAId,
      teamBId: teamBId ?? this.teamBId,
      status: status ?? this.status,
      result: result ?? this.result,
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (fieldId.present) {
      map['field_id'] = Variable<int>(fieldId.value);
    }
    if (teamAId.present) {
      map['team_a_id'] = Variable<int>(teamAId.value);
    }
    if (teamBId.present) {
      map['team_b_id'] = Variable<int>(teamBId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (scoreA.present) {
      map['score_a'] = Variable<int>(scoreA.value);
    }
    if (scoreB.present) {
      map['score_b'] = Variable<int>(scoreB.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('fieldId: $fieldId, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('status: $status, ')
          ..write('result: $result, ')
          ..write('scoreA: $scoreA, ')
          ..write('scoreB: $scoreB, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LineupsTable extends Lineups with TableInfo<$LineupsTable, Lineup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LineupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formationMeta = const VerificationMeta(
    'formation',
  );
  @override
  late final GeneratedColumn<String> formation = GeneratedColumn<String>(
    'formation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('4-4-2'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [matchId, teamId, formation, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lineups';
  @override
  VerificationContext validateIntegrity(
    Insertable<Lineup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('formation')) {
      context.handle(
        _formationMeta,
        formation.isAcceptableOrUnknown(data['formation']!, _formationMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {matchId, teamId};
  @override
  Lineup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lineup(
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      formation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formation'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LineupsTable createAlias(String alias) {
    return $LineupsTable(attachedDatabase, alias);
  }
}

class Lineup extends DataClass implements Insertable<Lineup> {
  final int matchId;
  final int teamId;
  final String formation;
  final DateTime? updatedAt;
  const Lineup({
    required this.matchId,
    required this.teamId,
    required this.formation,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['match_id'] = Variable<int>(matchId);
    map['team_id'] = Variable<int>(teamId);
    map['formation'] = Variable<String>(formation);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LineupsCompanion toCompanion(bool nullToAbsent) {
    return LineupsCompanion(
      matchId: Value(matchId),
      teamId: Value(teamId),
      formation: Value(formation),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Lineup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lineup(
      matchId: serializer.fromJson<int>(json['matchId']),
      teamId: serializer.fromJson<int>(json['teamId']),
      formation: serializer.fromJson<String>(json['formation']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matchId': serializer.toJson<int>(matchId),
      'teamId': serializer.toJson<int>(teamId),
      'formation': serializer.toJson<String>(formation),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Lineup copyWith({
    int? matchId,
    int? teamId,
    String? formation,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Lineup(
    matchId: matchId ?? this.matchId,
    teamId: teamId ?? this.teamId,
    formation: formation ?? this.formation,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Lineup copyWithCompanion(LineupsCompanion data) {
    return Lineup(
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      formation: data.formation.present ? data.formation.value : this.formation,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lineup(')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('formation: $formation, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(matchId, teamId, formation, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lineup &&
          other.matchId == this.matchId &&
          other.teamId == this.teamId &&
          other.formation == this.formation &&
          other.updatedAt == this.updatedAt);
}

class LineupsCompanion extends UpdateCompanion<Lineup> {
  final Value<int> matchId;
  final Value<int> teamId;
  final Value<String> formation;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const LineupsCompanion({
    this.matchId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.formation = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LineupsCompanion.insert({
    required int matchId,
    required int teamId,
    this.formation = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : matchId = Value(matchId),
       teamId = Value(teamId);
  static Insertable<Lineup> custom({
    Expression<int>? matchId,
    Expression<int>? teamId,
    Expression<String>? formation,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (matchId != null) 'match_id': matchId,
      if (teamId != null) 'team_id': teamId,
      if (formation != null) 'formation': formation,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LineupsCompanion copyWith({
    Value<int>? matchId,
    Value<int>? teamId,
    Value<String>? formation,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return LineupsCompanion(
      matchId: matchId ?? this.matchId,
      teamId: teamId ?? this.teamId,
      formation: formation ?? this.formation,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (formation.present) {
      map['formation'] = Variable<String>(formation.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LineupsCompanion(')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('formation: $formation, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LineupSlotsTable extends LineupSlots
    with TableInfo<$LineupSlotsTable, LineupSlot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LineupSlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotIndexMeta = const VerificationMeta(
    'slotIndex',
  );
  @override
  late final GeneratedColumn<int> slotIndex = GeneratedColumn<int>(
    'slot_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchId,
    teamId,
    slotIndex,
    position,
    playerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lineup_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<LineupSlot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('slot_index')) {
      context.handle(
        _slotIndexMeta,
        slotIndex.isAcceptableOrUnknown(data['slot_index']!, _slotIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_slotIndexMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LineupSlot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LineupSlot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      slotIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot_index'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      ),
    );
  }

  @override
  $LineupSlotsTable createAlias(String alias) {
    return $LineupSlotsTable(attachedDatabase, alias);
  }
}

class LineupSlot extends DataClass implements Insertable<LineupSlot> {
  final int id;
  final int matchId;
  final int teamId;
  final int slotIndex;
  final String? position;
  final int? playerId;
  const LineupSlot({
    required this.id,
    required this.matchId,
    required this.teamId,
    required this.slotIndex,
    this.position,
    this.playerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['team_id'] = Variable<int>(teamId);
    map['slot_index'] = Variable<int>(slotIndex);
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || playerId != null) {
      map['player_id'] = Variable<int>(playerId);
    }
    return map;
  }

  LineupSlotsCompanion toCompanion(bool nullToAbsent) {
    return LineupSlotsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      teamId: Value(teamId),
      slotIndex: Value(slotIndex),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      playerId: playerId == null && nullToAbsent
          ? const Value.absent()
          : Value(playerId),
    );
  }

  factory LineupSlot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LineupSlot(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      teamId: serializer.fromJson<int>(json['teamId']),
      slotIndex: serializer.fromJson<int>(json['slotIndex']),
      position: serializer.fromJson<String?>(json['position']),
      playerId: serializer.fromJson<int?>(json['playerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'teamId': serializer.toJson<int>(teamId),
      'slotIndex': serializer.toJson<int>(slotIndex),
      'position': serializer.toJson<String?>(position),
      'playerId': serializer.toJson<int?>(playerId),
    };
  }

  LineupSlot copyWith({
    int? id,
    int? matchId,
    int? teamId,
    int? slotIndex,
    Value<String?> position = const Value.absent(),
    Value<int?> playerId = const Value.absent(),
  }) => LineupSlot(
    id: id ?? this.id,
    matchId: matchId ?? this.matchId,
    teamId: teamId ?? this.teamId,
    slotIndex: slotIndex ?? this.slotIndex,
    position: position.present ? position.value : this.position,
    playerId: playerId.present ? playerId.value : this.playerId,
  );
  LineupSlot copyWithCompanion(LineupSlotsCompanion data) {
    return LineupSlot(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      slotIndex: data.slotIndex.present ? data.slotIndex.value : this.slotIndex,
      position: data.position.present ? data.position.value : this.position,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LineupSlot(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('position: $position, ')
          ..write('playerId: $playerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, matchId, teamId, slotIndex, position, playerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LineupSlot &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.teamId == this.teamId &&
          other.slotIndex == this.slotIndex &&
          other.position == this.position &&
          other.playerId == this.playerId);
}

class LineupSlotsCompanion extends UpdateCompanion<LineupSlot> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> teamId;
  final Value<int> slotIndex;
  final Value<String?> position;
  final Value<int?> playerId;
  const LineupSlotsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.slotIndex = const Value.absent(),
    this.position = const Value.absent(),
    this.playerId = const Value.absent(),
  });
  LineupSlotsCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int teamId,
    required int slotIndex,
    this.position = const Value.absent(),
    this.playerId = const Value.absent(),
  }) : matchId = Value(matchId),
       teamId = Value(teamId),
       slotIndex = Value(slotIndex);
  static Insertable<LineupSlot> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? teamId,
    Expression<int>? slotIndex,
    Expression<String>? position,
    Expression<int>? playerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (teamId != null) 'team_id': teamId,
      if (slotIndex != null) 'slot_index': slotIndex,
      if (position != null) 'position': position,
      if (playerId != null) 'player_id': playerId,
    });
  }

  LineupSlotsCompanion copyWith({
    Value<int>? id,
    Value<int>? matchId,
    Value<int>? teamId,
    Value<int>? slotIndex,
    Value<String?>? position,
    Value<int?>? playerId,
  }) {
    return LineupSlotsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      teamId: teamId ?? this.teamId,
      slotIndex: slotIndex ?? this.slotIndex,
      position: position ?? this.position,
      playerId: playerId ?? this.playerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (slotIndex.present) {
      map['slot_index'] = Variable<int>(slotIndex.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LineupSlotsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('position: $position, ')
          ..write('playerId: $playerId')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTable extends Attendance
    with TableInfo<$AttendanceTable, AttendanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isComingMeta = const VerificationMeta(
    'isComing',
  );
  @override
  late final GeneratedColumn<bool> isComing = GeneratedColumn<bool>(
    'is_coming',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_coming" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [matchId, teamId, playerId, isComing];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('is_coming')) {
      context.handle(
        _isComingMeta,
        isComing.isAcceptableOrUnknown(data['is_coming']!, _isComingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {matchId, teamId, playerId};
  @override
  AttendanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceData(
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      isComing: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_coming'],
      )!,
    );
  }

  @override
  $AttendanceTable createAlias(String alias) {
    return $AttendanceTable(attachedDatabase, alias);
  }
}

class AttendanceData extends DataClass implements Insertable<AttendanceData> {
  final int matchId;
  final int teamId;
  final int playerId;
  final bool isComing;
  const AttendanceData({
    required this.matchId,
    required this.teamId,
    required this.playerId,
    required this.isComing,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['match_id'] = Variable<int>(matchId);
    map['team_id'] = Variable<int>(teamId);
    map['player_id'] = Variable<int>(playerId);
    map['is_coming'] = Variable<bool>(isComing);
    return map;
  }

  AttendanceCompanion toCompanion(bool nullToAbsent) {
    return AttendanceCompanion(
      matchId: Value(matchId),
      teamId: Value(teamId),
      playerId: Value(playerId),
      isComing: Value(isComing),
    );
  }

  factory AttendanceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceData(
      matchId: serializer.fromJson<int>(json['matchId']),
      teamId: serializer.fromJson<int>(json['teamId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      isComing: serializer.fromJson<bool>(json['isComing']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matchId': serializer.toJson<int>(matchId),
      'teamId': serializer.toJson<int>(teamId),
      'playerId': serializer.toJson<int>(playerId),
      'isComing': serializer.toJson<bool>(isComing),
    };
  }

  AttendanceData copyWith({
    int? matchId,
    int? teamId,
    int? playerId,
    bool? isComing,
  }) => AttendanceData(
    matchId: matchId ?? this.matchId,
    teamId: teamId ?? this.teamId,
    playerId: playerId ?? this.playerId,
    isComing: isComing ?? this.isComing,
  );
  AttendanceData copyWithCompanion(AttendanceCompanion data) {
    return AttendanceData(
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      isComing: data.isComing.present ? data.isComing.value : this.isComing,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceData(')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('isComing: $isComing')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(matchId, teamId, playerId, isComing);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceData &&
          other.matchId == this.matchId &&
          other.teamId == this.teamId &&
          other.playerId == this.playerId &&
          other.isComing == this.isComing);
}

class AttendanceCompanion extends UpdateCompanion<AttendanceData> {
  final Value<int> matchId;
  final Value<int> teamId;
  final Value<int> playerId;
  final Value<bool> isComing;
  final Value<int> rowid;
  const AttendanceCompanion({
    this.matchId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.isComing = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceCompanion.insert({
    required int matchId,
    required int teamId,
    required int playerId,
    this.isComing = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : matchId = Value(matchId),
       teamId = Value(teamId),
       playerId = Value(playerId);
  static Insertable<AttendanceData> custom({
    Expression<int>? matchId,
    Expression<int>? teamId,
    Expression<int>? playerId,
    Expression<bool>? isComing,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (matchId != null) 'match_id': matchId,
      if (teamId != null) 'team_id': teamId,
      if (playerId != null) 'player_id': playerId,
      if (isComing != null) 'is_coming': isComing,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceCompanion copyWith({
    Value<int>? matchId,
    Value<int>? teamId,
    Value<int>? playerId,
    Value<bool>? isComing,
    Value<int>? rowid,
  }) {
    return AttendanceCompanion(
      matchId: matchId ?? this.matchId,
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      isComing: isComing ?? this.isComing,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (isComing.present) {
      map['is_coming'] = Variable<bool>(isComing.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceCompanion(')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('isComing: $isComing, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TacticsTable extends Tactics with TableInfo<$TacticsTable, Tactic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TacticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressingMeta = const VerificationMeta(
    'pressing',
  );
  @override
  late final GeneratedColumn<String> pressing = GeneratedColumn<String>(
    'pressing',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<String> width = GeneratedColumn<String>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buildUpMeta = const VerificationMeta(
    'buildUp',
  );
  @override
  late final GeneratedColumn<String> buildUp = GeneratedColumn<String>(
    'build_up',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cornersMeta = const VerificationMeta(
    'corners',
  );
  @override
  late final GeneratedColumn<String> corners = GeneratedColumn<String>(
    'corners',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _freeKicksMeta = const VerificationMeta(
    'freeKicks',
  );
  @override
  late final GeneratedColumn<String> freeKicks = GeneratedColumn<String>(
    'free_kicks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keyMatchupsMeta = const VerificationMeta(
    'keyMatchups',
  );
  @override
  late final GeneratedColumn<String> keyMatchups = GeneratedColumn<String>(
    'key_matchups',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    matchId,
    pressing,
    width,
    buildUp,
    corners,
    freeKicks,
    keyMatchups,
    notes,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tactics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tactic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    }
    if (data.containsKey('pressing')) {
      context.handle(
        _pressingMeta,
        pressing.isAcceptableOrUnknown(data['pressing']!, _pressingMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('build_up')) {
      context.handle(
        _buildUpMeta,
        buildUp.isAcceptableOrUnknown(data['build_up']!, _buildUpMeta),
      );
    }
    if (data.containsKey('corners')) {
      context.handle(
        _cornersMeta,
        corners.isAcceptableOrUnknown(data['corners']!, _cornersMeta),
      );
    }
    if (data.containsKey('free_kicks')) {
      context.handle(
        _freeKicksMeta,
        freeKicks.isAcceptableOrUnknown(data['free_kicks']!, _freeKicksMeta),
      );
    }
    if (data.containsKey('key_matchups')) {
      context.handle(
        _keyMatchupsMeta,
        keyMatchups.isAcceptableOrUnknown(
          data['key_matchups']!,
          _keyMatchupsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {matchId};
  @override
  Tactic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tactic(
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      pressing: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pressing'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}width'],
      ),
      buildUp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}build_up'],
      ),
      corners: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}corners'],
      ),
      freeKicks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}free_kicks'],
      ),
      keyMatchups: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_matchups'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $TacticsTable createAlias(String alias) {
    return $TacticsTable(attachedDatabase, alias);
  }
}

class Tactic extends DataClass implements Insertable<Tactic> {
  final int matchId;
  final String? pressing;
  final String? width;
  final String? buildUp;
  final String? corners;
  final String? freeKicks;
  final String? keyMatchups;
  final String? notes;
  final DateTime? updatedAt;
  const Tactic({
    required this.matchId,
    this.pressing,
    this.width,
    this.buildUp,
    this.corners,
    this.freeKicks,
    this.keyMatchups,
    this.notes,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['match_id'] = Variable<int>(matchId);
    if (!nullToAbsent || pressing != null) {
      map['pressing'] = Variable<String>(pressing);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<String>(width);
    }
    if (!nullToAbsent || buildUp != null) {
      map['build_up'] = Variable<String>(buildUp);
    }
    if (!nullToAbsent || corners != null) {
      map['corners'] = Variable<String>(corners);
    }
    if (!nullToAbsent || freeKicks != null) {
      map['free_kicks'] = Variable<String>(freeKicks);
    }
    if (!nullToAbsent || keyMatchups != null) {
      map['key_matchups'] = Variable<String>(keyMatchups);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  TacticsCompanion toCompanion(bool nullToAbsent) {
    return TacticsCompanion(
      matchId: Value(matchId),
      pressing: pressing == null && nullToAbsent
          ? const Value.absent()
          : Value(pressing),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      buildUp: buildUp == null && nullToAbsent
          ? const Value.absent()
          : Value(buildUp),
      corners: corners == null && nullToAbsent
          ? const Value.absent()
          : Value(corners),
      freeKicks: freeKicks == null && nullToAbsent
          ? const Value.absent()
          : Value(freeKicks),
      keyMatchups: keyMatchups == null && nullToAbsent
          ? const Value.absent()
          : Value(keyMatchups),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Tactic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tactic(
      matchId: serializer.fromJson<int>(json['matchId']),
      pressing: serializer.fromJson<String?>(json['pressing']),
      width: serializer.fromJson<String?>(json['width']),
      buildUp: serializer.fromJson<String?>(json['buildUp']),
      corners: serializer.fromJson<String?>(json['corners']),
      freeKicks: serializer.fromJson<String?>(json['freeKicks']),
      keyMatchups: serializer.fromJson<String?>(json['keyMatchups']),
      notes: serializer.fromJson<String?>(json['notes']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matchId': serializer.toJson<int>(matchId),
      'pressing': serializer.toJson<String?>(pressing),
      'width': serializer.toJson<String?>(width),
      'buildUp': serializer.toJson<String?>(buildUp),
      'corners': serializer.toJson<String?>(corners),
      'freeKicks': serializer.toJson<String?>(freeKicks),
      'keyMatchups': serializer.toJson<String?>(keyMatchups),
      'notes': serializer.toJson<String?>(notes),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Tactic copyWith({
    int? matchId,
    Value<String?> pressing = const Value.absent(),
    Value<String?> width = const Value.absent(),
    Value<String?> buildUp = const Value.absent(),
    Value<String?> corners = const Value.absent(),
    Value<String?> freeKicks = const Value.absent(),
    Value<String?> keyMatchups = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Tactic(
    matchId: matchId ?? this.matchId,
    pressing: pressing.present ? pressing.value : this.pressing,
    width: width.present ? width.value : this.width,
    buildUp: buildUp.present ? buildUp.value : this.buildUp,
    corners: corners.present ? corners.value : this.corners,
    freeKicks: freeKicks.present ? freeKicks.value : this.freeKicks,
    keyMatchups: keyMatchups.present ? keyMatchups.value : this.keyMatchups,
    notes: notes.present ? notes.value : this.notes,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Tactic copyWithCompanion(TacticsCompanion data) {
    return Tactic(
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      pressing: data.pressing.present ? data.pressing.value : this.pressing,
      width: data.width.present ? data.width.value : this.width,
      buildUp: data.buildUp.present ? data.buildUp.value : this.buildUp,
      corners: data.corners.present ? data.corners.value : this.corners,
      freeKicks: data.freeKicks.present ? data.freeKicks.value : this.freeKicks,
      keyMatchups: data.keyMatchups.present
          ? data.keyMatchups.value
          : this.keyMatchups,
      notes: data.notes.present ? data.notes.value : this.notes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tactic(')
          ..write('matchId: $matchId, ')
          ..write('pressing: $pressing, ')
          ..write('width: $width, ')
          ..write('buildUp: $buildUp, ')
          ..write('corners: $corners, ')
          ..write('freeKicks: $freeKicks, ')
          ..write('keyMatchups: $keyMatchups, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    matchId,
    pressing,
    width,
    buildUp,
    corners,
    freeKicks,
    keyMatchups,
    notes,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tactic &&
          other.matchId == this.matchId &&
          other.pressing == this.pressing &&
          other.width == this.width &&
          other.buildUp == this.buildUp &&
          other.corners == this.corners &&
          other.freeKicks == this.freeKicks &&
          other.keyMatchups == this.keyMatchups &&
          other.notes == this.notes &&
          other.updatedAt == this.updatedAt);
}

class TacticsCompanion extends UpdateCompanion<Tactic> {
  final Value<int> matchId;
  final Value<String?> pressing;
  final Value<String?> width;
  final Value<String?> buildUp;
  final Value<String?> corners;
  final Value<String?> freeKicks;
  final Value<String?> keyMatchups;
  final Value<String?> notes;
  final Value<DateTime?> updatedAt;
  const TacticsCompanion({
    this.matchId = const Value.absent(),
    this.pressing = const Value.absent(),
    this.width = const Value.absent(),
    this.buildUp = const Value.absent(),
    this.corners = const Value.absent(),
    this.freeKicks = const Value.absent(),
    this.keyMatchups = const Value.absent(),
    this.notes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TacticsCompanion.insert({
    this.matchId = const Value.absent(),
    this.pressing = const Value.absent(),
    this.width = const Value.absent(),
    this.buildUp = const Value.absent(),
    this.corners = const Value.absent(),
    this.freeKicks = const Value.absent(),
    this.keyMatchups = const Value.absent(),
    this.notes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<Tactic> custom({
    Expression<int>? matchId,
    Expression<String>? pressing,
    Expression<String>? width,
    Expression<String>? buildUp,
    Expression<String>? corners,
    Expression<String>? freeKicks,
    Expression<String>? keyMatchups,
    Expression<String>? notes,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (matchId != null) 'match_id': matchId,
      if (pressing != null) 'pressing': pressing,
      if (width != null) 'width': width,
      if (buildUp != null) 'build_up': buildUp,
      if (corners != null) 'corners': corners,
      if (freeKicks != null) 'free_kicks': freeKicks,
      if (keyMatchups != null) 'key_matchups': keyMatchups,
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TacticsCompanion copyWith({
    Value<int>? matchId,
    Value<String?>? pressing,
    Value<String?>? width,
    Value<String?>? buildUp,
    Value<String?>? corners,
    Value<String?>? freeKicks,
    Value<String?>? keyMatchups,
    Value<String?>? notes,
    Value<DateTime?>? updatedAt,
  }) {
    return TacticsCompanion(
      matchId: matchId ?? this.matchId,
      pressing: pressing ?? this.pressing,
      width: width ?? this.width,
      buildUp: buildUp ?? this.buildUp,
      corners: corners ?? this.corners,
      freeKicks: freeKicks ?? this.freeKicks,
      keyMatchups: keyMatchups ?? this.keyMatchups,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (pressing.present) {
      map['pressing'] = Variable<String>(pressing.value);
    }
    if (width.present) {
      map['width'] = Variable<String>(width.value);
    }
    if (buildUp.present) {
      map['build_up'] = Variable<String>(buildUp.value);
    }
    if (corners.present) {
      map['corners'] = Variable<String>(corners.value);
    }
    if (freeKicks.present) {
      map['free_kicks'] = Variable<String>(freeKicks.value);
    }
    if (keyMatchups.present) {
      map['key_matchups'] = Variable<String>(keyMatchups.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TacticsCompanion(')
          ..write('matchId: $matchId, ')
          ..write('pressing: $pressing, ')
          ..write('width: $width, ')
          ..write('buildUp: $buildUp, ')
          ..write('corners: $corners, ')
          ..write('freeKicks: $freeKicks, ')
          ..write('keyMatchups: $keyMatchups, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DoDontItemsTable extends DoDontItems
    with TableInfo<$DoDontItemsTable, DoDontItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoDontItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchId,
    content,
    isDone,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'do_dont_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoDontItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoDontItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoDontItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $DoDontItemsTable createAlias(String alias) {
    return $DoDontItemsTable(attachedDatabase, alias);
  }
}

class DoDontItem extends DataClass implements Insertable<DoDontItem> {
  final int id;
  final int matchId;
  final String content;
  final bool isDone;
  final int sortOrder;
  const DoDontItem({
    required this.id,
    required this.matchId,
    required this.content,
    required this.isDone,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['content'] = Variable<String>(content);
    map['is_done'] = Variable<bool>(isDone);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DoDontItemsCompanion toCompanion(bool nullToAbsent) {
    return DoDontItemsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      content: Value(content),
      isDone: Value(isDone),
      sortOrder: Value(sortOrder),
    );
  }

  factory DoDontItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoDontItem(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      content: serializer.fromJson<String>(json['content']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'content': serializer.toJson<String>(content),
      'isDone': serializer.toJson<bool>(isDone),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DoDontItem copyWith({
    int? id,
    int? matchId,
    String? content,
    bool? isDone,
    int? sortOrder,
  }) => DoDontItem(
    id: id ?? this.id,
    matchId: matchId ?? this.matchId,
    content: content ?? this.content,
    isDone: isDone ?? this.isDone,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  DoDontItem copyWithCompanion(DoDontItemsCompanion data) {
    return DoDontItem(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      content: data.content.present ? data.content.value : this.content,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoDontItem(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('content: $content, ')
          ..write('isDone: $isDone, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchId, content, isDone, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoDontItem &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.content == this.content &&
          other.isDone == this.isDone &&
          other.sortOrder == this.sortOrder);
}

class DoDontItemsCompanion extends UpdateCompanion<DoDontItem> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<String> content;
  final Value<bool> isDone;
  final Value<int> sortOrder;
  const DoDontItemsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.content = const Value.absent(),
    this.isDone = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  DoDontItemsCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required String content,
    this.isDone = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : matchId = Value(matchId),
       content = Value(content);
  static Insertable<DoDontItem> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<String>? content,
    Expression<bool>? isDone,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (content != null) 'content': content,
      if (isDone != null) 'is_done': isDone,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  DoDontItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? matchId,
    Value<String>? content,
    Value<bool>? isDone,
    Value<int>? sortOrder,
  }) {
    return DoDontItemsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoDontItemsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('content: $content, ')
          ..write('isDone: $isDone, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $SettingsEntriesTable extends SettingsEntries
    with TableInfo<$SettingsEntriesTable, SettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stringValueMeta = const VerificationMeta(
    'stringValue',
  );
  @override
  late final GeneratedColumn<String> stringValue = GeneratedColumn<String>(
    'string_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intValueMeta = const VerificationMeta(
    'intValue',
  );
  @override
  late final GeneratedColumn<int> intValue = GeneratedColumn<int>(
    'int_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _boolValueMeta = const VerificationMeta(
    'boolValue',
  );
  @override
  late final GeneratedColumn<bool> boolValue = GeneratedColumn<bool>(
    'bool_value',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bool_value" IN (0, 1))',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    key,
    stringValue,
    intValue,
    boolValue,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('string_value')) {
      context.handle(
        _stringValueMeta,
        stringValue.isAcceptableOrUnknown(
          data['string_value']!,
          _stringValueMeta,
        ),
      );
    }
    if (data.containsKey('int_value')) {
      context.handle(
        _intValueMeta,
        intValue.isAcceptableOrUnknown(data['int_value']!, _intValueMeta),
      );
    }
    if (data.containsKey('bool_value')) {
      context.handle(
        _boolValueMeta,
        boolValue.isAcceptableOrUnknown(data['bool_value']!, _boolValueMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      stringValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}string_value'],
      ),
      intValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}int_value'],
      ),
      boolValue: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bool_value'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $SettingsEntriesTable createAlias(String alias) {
    return $SettingsEntriesTable(attachedDatabase, alias);
  }
}

class SettingsEntry extends DataClass implements Insertable<SettingsEntry> {
  final String key;
  final String? stringValue;
  final int? intValue;
  final bool? boolValue;
  final DateTime? updatedAt;
  const SettingsEntry({
    required this.key,
    this.stringValue,
    this.intValue,
    this.boolValue,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || stringValue != null) {
      map['string_value'] = Variable<String>(stringValue);
    }
    if (!nullToAbsent || intValue != null) {
      map['int_value'] = Variable<int>(intValue);
    }
    if (!nullToAbsent || boolValue != null) {
      map['bool_value'] = Variable<bool>(boolValue);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return SettingsEntriesCompanion(
      key: Value(key),
      stringValue: stringValue == null && nullToAbsent
          ? const Value.absent()
          : Value(stringValue),
      intValue: intValue == null && nullToAbsent
          ? const Value.absent()
          : Value(intValue),
      boolValue: boolValue == null && nullToAbsent
          ? const Value.absent()
          : Value(boolValue),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SettingsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsEntry(
      key: serializer.fromJson<String>(json['key']),
      stringValue: serializer.fromJson<String?>(json['stringValue']),
      intValue: serializer.fromJson<int?>(json['intValue']),
      boolValue: serializer.fromJson<bool?>(json['boolValue']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'stringValue': serializer.toJson<String?>(stringValue),
      'intValue': serializer.toJson<int?>(intValue),
      'boolValue': serializer.toJson<bool?>(boolValue),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  SettingsEntry copyWith({
    String? key,
    Value<String?> stringValue = const Value.absent(),
    Value<int?> intValue = const Value.absent(),
    Value<bool?> boolValue = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => SettingsEntry(
    key: key ?? this.key,
    stringValue: stringValue.present ? stringValue.value : this.stringValue,
    intValue: intValue.present ? intValue.value : this.intValue,
    boolValue: boolValue.present ? boolValue.value : this.boolValue,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  SettingsEntry copyWithCompanion(SettingsEntriesCompanion data) {
    return SettingsEntry(
      key: data.key.present ? data.key.value : this.key,
      stringValue: data.stringValue.present
          ? data.stringValue.value
          : this.stringValue,
      intValue: data.intValue.present ? data.intValue.value : this.intValue,
      boolValue: data.boolValue.present ? data.boolValue.value : this.boolValue,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntry(')
          ..write('key: $key, ')
          ..write('stringValue: $stringValue, ')
          ..write('intValue: $intValue, ')
          ..write('boolValue: $boolValue, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(key, stringValue, intValue, boolValue, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsEntry &&
          other.key == this.key &&
          other.stringValue == this.stringValue &&
          other.intValue == this.intValue &&
          other.boolValue == this.boolValue &&
          other.updatedAt == this.updatedAt);
}

class SettingsEntriesCompanion extends UpdateCompanion<SettingsEntry> {
  final Value<String> key;
  final Value<String?> stringValue;
  final Value<int?> intValue;
  final Value<bool?> boolValue;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const SettingsEntriesCompanion({
    this.key = const Value.absent(),
    this.stringValue = const Value.absent(),
    this.intValue = const Value.absent(),
    this.boolValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsEntriesCompanion.insert({
    required String key,
    this.stringValue = const Value.absent(),
    this.intValue = const Value.absent(),
    this.boolValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<SettingsEntry> custom({
    Expression<String>? key,
    Expression<String>? stringValue,
    Expression<int>? intValue,
    Expression<bool>? boolValue,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (stringValue != null) 'string_value': stringValue,
      if (intValue != null) 'int_value': intValue,
      if (boolValue != null) 'bool_value': boolValue,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsEntriesCompanion copyWith({
    Value<String>? key,
    Value<String?>? stringValue,
    Value<int?>? intValue,
    Value<bool?>? boolValue,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsEntriesCompanion(
      key: key ?? this.key,
      stringValue: stringValue ?? this.stringValue,
      intValue: intValue ?? this.intValue,
      boolValue: boolValue ?? this.boolValue,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (stringValue.present) {
      map['string_value'] = Variable<String>(stringValue.value);
    }
    if (intValue.present) {
      map['int_value'] = Variable<int>(intValue.value);
    }
    if (boolValue.present) {
      map['bool_value'] = Variable<bool>(boolValue.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntriesCompanion(')
          ..write('key: $key, ')
          ..write('stringValue: $stringValue, ')
          ..write('intValue: $intValue, ')
          ..write('boolValue: $boolValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $FieldsTable fields = $FieldsTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $LineupsTable lineups = $LineupsTable(this);
  late final $LineupSlotsTable lineupSlots = $LineupSlotsTable(this);
  late final $AttendanceTable attendance = $AttendanceTable(this);
  late final $TacticsTable tactics = $TacticsTable(this);
  late final $DoDontItemsTable doDontItems = $DoDontItemsTable(this);
  late final $SettingsEntriesTable settingsEntries = $SettingsEntriesTable(
    this,
  );
  late final TeamsDao teamsDao = TeamsDao(this as AppDatabase);
  late final FieldsDao fieldsDao = FieldsDao(this as AppDatabase);
  late final MatchesDao matchesDao = MatchesDao(this as AppDatabase);
  late final LineupDao lineupDao = LineupDao(this as AppDatabase);
  late final TacticsDao tacticsDao = TacticsDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    teams,
    players,
    fields,
    matches,
    lineups,
    lineupSlots,
    attendance,
    tactics,
    doDontItems,
    settingsEntries,
  ];
}

typedef $$TeamsTableCreateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> badgeIcon,
      Value<String> homeKitTemplateId,
      Value<int?> homePrimaryColor,
      Value<int?> homeSecondaryColor,
      Value<String> awayKitTemplateId,
      Value<int?> awayPrimaryColor,
      Value<int?> awaySecondaryColor,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$TeamsTableUpdateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> badgeIcon,
      Value<String> homeKitTemplateId,
      Value<int?> homePrimaryColor,
      Value<int?> homeSecondaryColor,
      Value<String> awayKitTemplateId,
      Value<int?> awayPrimaryColor,
      Value<int?> awaySecondaryColor,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$TeamsTableFilterComposer extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get badgeIcon => $composableBuilder(
    column: $table.badgeIcon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeKitTemplateId => $composableBuilder(
    column: $table.homeKitTemplateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get homePrimaryColor => $composableBuilder(
    column: $table.homePrimaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get homeSecondaryColor => $composableBuilder(
    column: $table.homeSecondaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get awayKitTemplateId => $composableBuilder(
    column: $table.awayKitTemplateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awayPrimaryColor => $composableBuilder(
    column: $table.awayPrimaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awaySecondaryColor => $composableBuilder(
    column: $table.awaySecondaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get badgeIcon => $composableBuilder(
    column: $table.badgeIcon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeKitTemplateId => $composableBuilder(
    column: $table.homeKitTemplateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get homePrimaryColor => $composableBuilder(
    column: $table.homePrimaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get homeSecondaryColor => $composableBuilder(
    column: $table.homeSecondaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get awayKitTemplateId => $composableBuilder(
    column: $table.awayKitTemplateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awayPrimaryColor => $composableBuilder(
    column: $table.awayPrimaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awaySecondaryColor => $composableBuilder(
    column: $table.awaySecondaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get badgeIcon =>
      $composableBuilder(column: $table.badgeIcon, builder: (column) => column);

  GeneratedColumn<String> get homeKitTemplateId => $composableBuilder(
    column: $table.homeKitTemplateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get homePrimaryColor => $composableBuilder(
    column: $table.homePrimaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get homeSecondaryColor => $composableBuilder(
    column: $table.homeSecondaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get awayKitTemplateId => $composableBuilder(
    column: $table.awayKitTemplateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get awayPrimaryColor => $composableBuilder(
    column: $table.awayPrimaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get awaySecondaryColor => $composableBuilder(
    column: $table.awaySecondaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamsTable,
          Team,
          $$TeamsTableFilterComposer,
          $$TeamsTableOrderingComposer,
          $$TeamsTableAnnotationComposer,
          $$TeamsTableCreateCompanionBuilder,
          $$TeamsTableUpdateCompanionBuilder,
          (Team, BaseReferences<_$AppDatabase, $TeamsTable, Team>),
          Team,
          PrefetchHooks Function()
        > {
  $$TeamsTableTableManager(_$AppDatabase db, $TeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> badgeIcon = const Value.absent(),
                Value<String> homeKitTemplateId = const Value.absent(),
                Value<int?> homePrimaryColor = const Value.absent(),
                Value<int?> homeSecondaryColor = const Value.absent(),
                Value<String> awayKitTemplateId = const Value.absent(),
                Value<int?> awayPrimaryColor = const Value.absent(),
                Value<int?> awaySecondaryColor = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => TeamsCompanion(
                id: id,
                name: name,
                badgeIcon: badgeIcon,
                homeKitTemplateId: homeKitTemplateId,
                homePrimaryColor: homePrimaryColor,
                homeSecondaryColor: homeSecondaryColor,
                awayKitTemplateId: awayKitTemplateId,
                awayPrimaryColor: awayPrimaryColor,
                awaySecondaryColor: awaySecondaryColor,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> badgeIcon = const Value.absent(),
                Value<String> homeKitTemplateId = const Value.absent(),
                Value<int?> homePrimaryColor = const Value.absent(),
                Value<int?> homeSecondaryColor = const Value.absent(),
                Value<String> awayKitTemplateId = const Value.absent(),
                Value<int?> awayPrimaryColor = const Value.absent(),
                Value<int?> awaySecondaryColor = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => TeamsCompanion.insert(
                id: id,
                name: name,
                badgeIcon: badgeIcon,
                homeKitTemplateId: homeKitTemplateId,
                homePrimaryColor: homePrimaryColor,
                homeSecondaryColor: homeSecondaryColor,
                awayKitTemplateId: awayKitTemplateId,
                awayPrimaryColor: awayPrimaryColor,
                awaySecondaryColor: awaySecondaryColor,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamsTable,
      Team,
      $$TeamsTableFilterComposer,
      $$TeamsTableOrderingComposer,
      $$TeamsTableAnnotationComposer,
      $$TeamsTableCreateCompanionBuilder,
      $$TeamsTableUpdateCompanionBuilder,
      (Team, BaseReferences<_$AppDatabase, $TeamsTable, Team>),
      Team,
      PrefetchHooks Function()
    >;
typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      required int teamId,
      required String name,
      Value<String?> position,
      Value<int?> number,
      Value<bool> isCaptain,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<int> teamId,
      Value<String> name,
      Value<String?> position,
      Value<int?> number,
      Value<bool> isCaptain,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
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

  ColumnFilters<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCaptain => $composableBuilder(
    column: $table.isCaptain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
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

  ColumnOrderings<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCaptain => $composableBuilder(
    column: $table.isCaptain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<bool> get isCaptain =>
      $composableBuilder(column: $table.isCaptain, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
          Player,
          PrefetchHooks Function()
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> teamId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<int?> number = const Value.absent(),
                Value<bool> isCaptain = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => PlayersCompanion(
                id: id,
                teamId: teamId,
                name: name,
                position: position,
                number: number,
                isCaptain: isCaptain,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int teamId,
                required String name,
                Value<String?> position = const Value.absent(),
                Value<int?> number = const Value.absent(),
                Value<bool> isCaptain = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                teamId: teamId,
                name: name,
                position: position,
                number: number,
                isCaptain: isCaptain,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, BaseReferences<_$AppDatabase, $PlayersTable, Player>),
      Player,
      PrefetchHooks Function()
    >;
typedef $$FieldsTableCreateCompanionBuilder =
    FieldsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> address,
      Value<String?> type,
      Value<String?> notes,
      Value<double?> lat,
      Value<double?> lon,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$FieldsTableUpdateCompanionBuilder =
    FieldsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> address,
      Value<String?> type,
      Value<String?> notes,
      Value<double?> lat,
      Value<double?> lon,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$FieldsTableFilterComposer
    extends Composer<_$AppDatabase, $FieldsTable> {
  $$FieldsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FieldsTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldsTable> {
  $$FieldsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FieldsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldsTable> {
  $$FieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FieldsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldsTable,
          Field,
          $$FieldsTableFilterComposer,
          $$FieldsTableOrderingComposer,
          $$FieldsTableAnnotationComposer,
          $$FieldsTableCreateCompanionBuilder,
          $$FieldsTableUpdateCompanionBuilder,
          (Field, BaseReferences<_$AppDatabase, $FieldsTable, Field>),
          Field,
          PrefetchHooks Function()
        > {
  $$FieldsTableTableManager(_$AppDatabase db, $FieldsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lon = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => FieldsCompanion(
                id: id,
                name: name,
                address: address,
                type: type,
                notes: notes,
                lat: lat,
                lon: lon,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> address = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lon = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => FieldsCompanion.insert(
                id: id,
                name: name,
                address: address,
                type: type,
                notes: notes,
                lat: lat,
                lon: lon,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FieldsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldsTable,
      Field,
      $$FieldsTableFilterComposer,
      $$FieldsTableOrderingComposer,
      $$FieldsTableAnnotationComposer,
      $$FieldsTableCreateCompanionBuilder,
      $$FieldsTableUpdateCompanionBuilder,
      (Field, BaseReferences<_$AppDatabase, $FieldsTable, Field>),
      Field,
      PrefetchHooks Function()
    >;
typedef $$MatchesTableCreateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      required String title,
      required DateTime startAt,
      Value<DateTime?> endAt,
      Value<int?> fieldId,
      Value<int?> teamAId,
      Value<int?> teamBId,
      Value<String> status,
      Value<String?> result,
      Value<int?> scoreA,
      Value<int?> scoreB,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$MatchesTableUpdateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<DateTime> startAt,
      Value<DateTime?> endAt,
      Value<int?> fieldId,
      Value<int?> teamAId,
      Value<int?> teamBId,
      Value<String> status,
      Value<String?> result,
      Value<int?> scoreA,
      Value<int?> scoreB,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$MatchesTableFilterComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fieldId => $composableBuilder(
    column: $table.fieldId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamAId => $composableBuilder(
    column: $table.teamAId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamBId => $composableBuilder(
    column: $table.teamBId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreA => $composableBuilder(
    column: $table.scoreA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreB => $composableBuilder(
    column: $table.scoreB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fieldId => $composableBuilder(
    column: $table.fieldId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamAId => $composableBuilder(
    column: $table.teamAId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamBId => $composableBuilder(
    column: $table.teamBId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreA => $composableBuilder(
    column: $table.scoreA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreB => $composableBuilder(
    column: $table.scoreB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<int> get fieldId =>
      $composableBuilder(column: $table.fieldId, builder: (column) => column);

  GeneratedColumn<int> get teamAId =>
      $composableBuilder(column: $table.teamAId, builder: (column) => column);

  GeneratedColumn<int> get teamBId =>
      $composableBuilder(column: $table.teamBId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<int> get scoreA =>
      $composableBuilder(column: $table.scoreA, builder: (column) => column);

  GeneratedColumn<int> get scoreB =>
      $composableBuilder(column: $table.scoreB, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchesTable,
          Fixture,
          $$MatchesTableFilterComposer,
          $$MatchesTableOrderingComposer,
          $$MatchesTableAnnotationComposer,
          $$MatchesTableCreateCompanionBuilder,
          $$MatchesTableUpdateCompanionBuilder,
          (Fixture, BaseReferences<_$AppDatabase, $MatchesTable, Fixture>),
          Fixture,
          PrefetchHooks Function()
        > {
  $$MatchesTableTableManager(_$AppDatabase db, $MatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime?> endAt = const Value.absent(),
                Value<int?> fieldId = const Value.absent(),
                Value<int?> teamAId = const Value.absent(),
                Value<int?> teamBId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<int?> scoreA = const Value.absent(),
                Value<int?> scoreB = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => MatchesCompanion(
                id: id,
                title: title,
                startAt: startAt,
                endAt: endAt,
                fieldId: fieldId,
                teamAId: teamAId,
                teamBId: teamBId,
                status: status,
                result: result,
                scoreA: scoreA,
                scoreB: scoreB,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required DateTime startAt,
                Value<DateTime?> endAt = const Value.absent(),
                Value<int?> fieldId = const Value.absent(),
                Value<int?> teamAId = const Value.absent(),
                Value<int?> teamBId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<int?> scoreA = const Value.absent(),
                Value<int?> scoreB = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => MatchesCompanion.insert(
                id: id,
                title: title,
                startAt: startAt,
                endAt: endAt,
                fieldId: fieldId,
                teamAId: teamAId,
                teamBId: teamBId,
                status: status,
                result: result,
                scoreA: scoreA,
                scoreB: scoreB,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchesTable,
      Fixture,
      $$MatchesTableFilterComposer,
      $$MatchesTableOrderingComposer,
      $$MatchesTableAnnotationComposer,
      $$MatchesTableCreateCompanionBuilder,
      $$MatchesTableUpdateCompanionBuilder,
      (Fixture, BaseReferences<_$AppDatabase, $MatchesTable, Fixture>),
      Fixture,
      PrefetchHooks Function()
    >;
typedef $$LineupsTableCreateCompanionBuilder =
    LineupsCompanion Function({
      required int matchId,
      required int teamId,
      Value<String> formation,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$LineupsTableUpdateCompanionBuilder =
    LineupsCompanion Function({
      Value<int> matchId,
      Value<int> teamId,
      Value<String> formation,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$LineupsTableFilterComposer
    extends Composer<_$AppDatabase, $LineupsTable> {
  $$LineupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formation => $composableBuilder(
    column: $table.formation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LineupsTableOrderingComposer
    extends Composer<_$AppDatabase, $LineupsTable> {
  $$LineupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formation => $composableBuilder(
    column: $table.formation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LineupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LineupsTable> {
  $$LineupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<int> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get formation =>
      $composableBuilder(column: $table.formation, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LineupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LineupsTable,
          Lineup,
          $$LineupsTableFilterComposer,
          $$LineupsTableOrderingComposer,
          $$LineupsTableAnnotationComposer,
          $$LineupsTableCreateCompanionBuilder,
          $$LineupsTableUpdateCompanionBuilder,
          (Lineup, BaseReferences<_$AppDatabase, $LineupsTable, Lineup>),
          Lineup,
          PrefetchHooks Function()
        > {
  $$LineupsTableTableManager(_$AppDatabase db, $LineupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LineupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LineupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LineupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> matchId = const Value.absent(),
                Value<int> teamId = const Value.absent(),
                Value<String> formation = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LineupsCompanion(
                matchId: matchId,
                teamId: teamId,
                formation: formation,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int matchId,
                required int teamId,
                Value<String> formation = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LineupsCompanion.insert(
                matchId: matchId,
                teamId: teamId,
                formation: formation,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LineupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LineupsTable,
      Lineup,
      $$LineupsTableFilterComposer,
      $$LineupsTableOrderingComposer,
      $$LineupsTableAnnotationComposer,
      $$LineupsTableCreateCompanionBuilder,
      $$LineupsTableUpdateCompanionBuilder,
      (Lineup, BaseReferences<_$AppDatabase, $LineupsTable, Lineup>),
      Lineup,
      PrefetchHooks Function()
    >;
typedef $$LineupSlotsTableCreateCompanionBuilder =
    LineupSlotsCompanion Function({
      Value<int> id,
      required int matchId,
      required int teamId,
      required int slotIndex,
      Value<String?> position,
      Value<int?> playerId,
    });
typedef $$LineupSlotsTableUpdateCompanionBuilder =
    LineupSlotsCompanion Function({
      Value<int> id,
      Value<int> matchId,
      Value<int> teamId,
      Value<int> slotIndex,
      Value<String?> position,
      Value<int?> playerId,
    });

class $$LineupSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $LineupSlotsTable> {
  $$LineupSlotsTableFilterComposer({
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

  ColumnFilters<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LineupSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $LineupSlotsTable> {
  $$LineupSlotsTableOrderingComposer({
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

  ColumnOrderings<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LineupSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LineupSlotsTable> {
  $$LineupSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<int> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<int> get slotIndex =>
      $composableBuilder(column: $table.slotIndex, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);
}

class $$LineupSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LineupSlotsTable,
          LineupSlot,
          $$LineupSlotsTableFilterComposer,
          $$LineupSlotsTableOrderingComposer,
          $$LineupSlotsTableAnnotationComposer,
          $$LineupSlotsTableCreateCompanionBuilder,
          $$LineupSlotsTableUpdateCompanionBuilder,
          (
            LineupSlot,
            BaseReferences<_$AppDatabase, $LineupSlotsTable, LineupSlot>,
          ),
          LineupSlot,
          PrefetchHooks Function()
        > {
  $$LineupSlotsTableTableManager(_$AppDatabase db, $LineupSlotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LineupSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LineupSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LineupSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> matchId = const Value.absent(),
                Value<int> teamId = const Value.absent(),
                Value<int> slotIndex = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<int?> playerId = const Value.absent(),
              }) => LineupSlotsCompanion(
                id: id,
                matchId: matchId,
                teamId: teamId,
                slotIndex: slotIndex,
                position: position,
                playerId: playerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int matchId,
                required int teamId,
                required int slotIndex,
                Value<String?> position = const Value.absent(),
                Value<int?> playerId = const Value.absent(),
              }) => LineupSlotsCompanion.insert(
                id: id,
                matchId: matchId,
                teamId: teamId,
                slotIndex: slotIndex,
                position: position,
                playerId: playerId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LineupSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LineupSlotsTable,
      LineupSlot,
      $$LineupSlotsTableFilterComposer,
      $$LineupSlotsTableOrderingComposer,
      $$LineupSlotsTableAnnotationComposer,
      $$LineupSlotsTableCreateCompanionBuilder,
      $$LineupSlotsTableUpdateCompanionBuilder,
      (
        LineupSlot,
        BaseReferences<_$AppDatabase, $LineupSlotsTable, LineupSlot>,
      ),
      LineupSlot,
      PrefetchHooks Function()
    >;
typedef $$AttendanceTableCreateCompanionBuilder =
    AttendanceCompanion Function({
      required int matchId,
      required int teamId,
      required int playerId,
      Value<bool> isComing,
      Value<int> rowid,
    });
typedef $$AttendanceTableUpdateCompanionBuilder =
    AttendanceCompanion Function({
      Value<int> matchId,
      Value<int> teamId,
      Value<int> playerId,
      Value<bool> isComing,
      Value<int> rowid,
    });

class $$AttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isComing => $composableBuilder(
    column: $table.isComing,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isComing => $composableBuilder(
    column: $table.isComing,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<int> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<int> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<bool> get isComing =>
      $composableBuilder(column: $table.isComing, builder: (column) => column);
}

class $$AttendanceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceTable,
          AttendanceData,
          $$AttendanceTableFilterComposer,
          $$AttendanceTableOrderingComposer,
          $$AttendanceTableAnnotationComposer,
          $$AttendanceTableCreateCompanionBuilder,
          $$AttendanceTableUpdateCompanionBuilder,
          (
            AttendanceData,
            BaseReferences<_$AppDatabase, $AttendanceTable, AttendanceData>,
          ),
          AttendanceData,
          PrefetchHooks Function()
        > {
  $$AttendanceTableTableManager(_$AppDatabase db, $AttendanceTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> matchId = const Value.absent(),
                Value<int> teamId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<bool> isComing = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceCompanion(
                matchId: matchId,
                teamId: teamId,
                playerId: playerId,
                isComing: isComing,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int matchId,
                required int teamId,
                required int playerId,
                Value<bool> isComing = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceCompanion.insert(
                matchId: matchId,
                teamId: teamId,
                playerId: playerId,
                isComing: isComing,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceTable,
      AttendanceData,
      $$AttendanceTableFilterComposer,
      $$AttendanceTableOrderingComposer,
      $$AttendanceTableAnnotationComposer,
      $$AttendanceTableCreateCompanionBuilder,
      $$AttendanceTableUpdateCompanionBuilder,
      (
        AttendanceData,
        BaseReferences<_$AppDatabase, $AttendanceTable, AttendanceData>,
      ),
      AttendanceData,
      PrefetchHooks Function()
    >;
typedef $$TacticsTableCreateCompanionBuilder =
    TacticsCompanion Function({
      Value<int> matchId,
      Value<String?> pressing,
      Value<String?> width,
      Value<String?> buildUp,
      Value<String?> corners,
      Value<String?> freeKicks,
      Value<String?> keyMatchups,
      Value<String?> notes,
      Value<DateTime?> updatedAt,
    });
typedef $$TacticsTableUpdateCompanionBuilder =
    TacticsCompanion Function({
      Value<int> matchId,
      Value<String?> pressing,
      Value<String?> width,
      Value<String?> buildUp,
      Value<String?> corners,
      Value<String?> freeKicks,
      Value<String?> keyMatchups,
      Value<String?> notes,
      Value<DateTime?> updatedAt,
    });

class $$TacticsTableFilterComposer
    extends Composer<_$AppDatabase, $TacticsTable> {
  $$TacticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pressing => $composableBuilder(
    column: $table.pressing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buildUp => $composableBuilder(
    column: $table.buildUp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get corners => $composableBuilder(
    column: $table.corners,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get freeKicks => $composableBuilder(
    column: $table.freeKicks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyMatchups => $composableBuilder(
    column: $table.keyMatchups,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TacticsTableOrderingComposer
    extends Composer<_$AppDatabase, $TacticsTable> {
  $$TacticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pressing => $composableBuilder(
    column: $table.pressing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buildUp => $composableBuilder(
    column: $table.buildUp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get corners => $composableBuilder(
    column: $table.corners,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get freeKicks => $composableBuilder(
    column: $table.freeKicks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyMatchups => $composableBuilder(
    column: $table.keyMatchups,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TacticsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TacticsTable> {
  $$TacticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<String> get pressing =>
      $composableBuilder(column: $table.pressing, builder: (column) => column);

  GeneratedColumn<String> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<String> get buildUp =>
      $composableBuilder(column: $table.buildUp, builder: (column) => column);

  GeneratedColumn<String> get corners =>
      $composableBuilder(column: $table.corners, builder: (column) => column);

  GeneratedColumn<String> get freeKicks =>
      $composableBuilder(column: $table.freeKicks, builder: (column) => column);

  GeneratedColumn<String> get keyMatchups => $composableBuilder(
    column: $table.keyMatchups,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TacticsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TacticsTable,
          Tactic,
          $$TacticsTableFilterComposer,
          $$TacticsTableOrderingComposer,
          $$TacticsTableAnnotationComposer,
          $$TacticsTableCreateCompanionBuilder,
          $$TacticsTableUpdateCompanionBuilder,
          (Tactic, BaseReferences<_$AppDatabase, $TacticsTable, Tactic>),
          Tactic,
          PrefetchHooks Function()
        > {
  $$TacticsTableTableManager(_$AppDatabase db, $TacticsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TacticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TacticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TacticsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> matchId = const Value.absent(),
                Value<String?> pressing = const Value.absent(),
                Value<String?> width = const Value.absent(),
                Value<String?> buildUp = const Value.absent(),
                Value<String?> corners = const Value.absent(),
                Value<String?> freeKicks = const Value.absent(),
                Value<String?> keyMatchups = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => TacticsCompanion(
                matchId: matchId,
                pressing: pressing,
                width: width,
                buildUp: buildUp,
                corners: corners,
                freeKicks: freeKicks,
                keyMatchups: keyMatchups,
                notes: notes,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> matchId = const Value.absent(),
                Value<String?> pressing = const Value.absent(),
                Value<String?> width = const Value.absent(),
                Value<String?> buildUp = const Value.absent(),
                Value<String?> corners = const Value.absent(),
                Value<String?> freeKicks = const Value.absent(),
                Value<String?> keyMatchups = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => TacticsCompanion.insert(
                matchId: matchId,
                pressing: pressing,
                width: width,
                buildUp: buildUp,
                corners: corners,
                freeKicks: freeKicks,
                keyMatchups: keyMatchups,
                notes: notes,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TacticsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TacticsTable,
      Tactic,
      $$TacticsTableFilterComposer,
      $$TacticsTableOrderingComposer,
      $$TacticsTableAnnotationComposer,
      $$TacticsTableCreateCompanionBuilder,
      $$TacticsTableUpdateCompanionBuilder,
      (Tactic, BaseReferences<_$AppDatabase, $TacticsTable, Tactic>),
      Tactic,
      PrefetchHooks Function()
    >;
typedef $$DoDontItemsTableCreateCompanionBuilder =
    DoDontItemsCompanion Function({
      Value<int> id,
      required int matchId,
      required String content,
      Value<bool> isDone,
      Value<int> sortOrder,
    });
typedef $$DoDontItemsTableUpdateCompanionBuilder =
    DoDontItemsCompanion Function({
      Value<int> id,
      Value<int> matchId,
      Value<String> content,
      Value<bool> isDone,
      Value<int> sortOrder,
    });

class $$DoDontItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DoDontItemsTable> {
  $$DoDontItemsTableFilterComposer({
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

  ColumnFilters<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DoDontItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DoDontItemsTable> {
  $$DoDontItemsTableOrderingComposer({
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

  ColumnOrderings<int> get matchId => $composableBuilder(
    column: $table.matchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DoDontItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoDontItemsTable> {
  $$DoDontItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get matchId =>
      $composableBuilder(column: $table.matchId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$DoDontItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoDontItemsTable,
          DoDontItem,
          $$DoDontItemsTableFilterComposer,
          $$DoDontItemsTableOrderingComposer,
          $$DoDontItemsTableAnnotationComposer,
          $$DoDontItemsTableCreateCompanionBuilder,
          $$DoDontItemsTableUpdateCompanionBuilder,
          (
            DoDontItem,
            BaseReferences<_$AppDatabase, $DoDontItemsTable, DoDontItem>,
          ),
          DoDontItem,
          PrefetchHooks Function()
        > {
  $$DoDontItemsTableTableManager(_$AppDatabase db, $DoDontItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoDontItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoDontItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoDontItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> matchId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => DoDontItemsCompanion(
                id: id,
                matchId: matchId,
                content: content,
                isDone: isDone,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int matchId,
                required String content,
                Value<bool> isDone = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => DoDontItemsCompanion.insert(
                id: id,
                matchId: matchId,
                content: content,
                isDone: isDone,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DoDontItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoDontItemsTable,
      DoDontItem,
      $$DoDontItemsTableFilterComposer,
      $$DoDontItemsTableOrderingComposer,
      $$DoDontItemsTableAnnotationComposer,
      $$DoDontItemsTableCreateCompanionBuilder,
      $$DoDontItemsTableUpdateCompanionBuilder,
      (
        DoDontItem,
        BaseReferences<_$AppDatabase, $DoDontItemsTable, DoDontItem>,
      ),
      DoDontItem,
      PrefetchHooks Function()
    >;
typedef $$SettingsEntriesTableCreateCompanionBuilder =
    SettingsEntriesCompanion Function({
      required String key,
      Value<String?> stringValue,
      Value<int?> intValue,
      Value<bool?> boolValue,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsEntriesTableUpdateCompanionBuilder =
    SettingsEntriesCompanion Function({
      Value<String> key,
      Value<String?> stringValue,
      Value<int?> intValue,
      Value<bool?> boolValue,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$SettingsEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stringValue => $composableBuilder(
    column: $table.stringValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intValue => $composableBuilder(
    column: $table.intValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get boolValue => $composableBuilder(
    column: $table.boolValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stringValue => $composableBuilder(
    column: $table.stringValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intValue => $composableBuilder(
    column: $table.intValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get boolValue => $composableBuilder(
    column: $table.boolValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get stringValue => $composableBuilder(
    column: $table.stringValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intValue =>
      $composableBuilder(column: $table.intValue, builder: (column) => column);

  GeneratedColumn<bool> get boolValue =>
      $composableBuilder(column: $table.boolValue, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsEntriesTable,
          SettingsEntry,
          $$SettingsEntriesTableFilterComposer,
          $$SettingsEntriesTableOrderingComposer,
          $$SettingsEntriesTableAnnotationComposer,
          $$SettingsEntriesTableCreateCompanionBuilder,
          $$SettingsEntriesTableUpdateCompanionBuilder,
          (
            SettingsEntry,
            BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>,
          ),
          SettingsEntry,
          PrefetchHooks Function()
        > {
  $$SettingsEntriesTableTableManager(
    _$AppDatabase db,
    $SettingsEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> stringValue = const Value.absent(),
                Value<int?> intValue = const Value.absent(),
                Value<bool?> boolValue = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsEntriesCompanion(
                key: key,
                stringValue: stringValue,
                intValue: intValue,
                boolValue: boolValue,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> stringValue = const Value.absent(),
                Value<int?> intValue = const Value.absent(),
                Value<bool?> boolValue = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsEntriesCompanion.insert(
                key: key,
                stringValue: stringValue,
                intValue: intValue,
                boolValue: boolValue,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsEntriesTable,
      SettingsEntry,
      $$SettingsEntriesTableFilterComposer,
      $$SettingsEntriesTableOrderingComposer,
      $$SettingsEntriesTableAnnotationComposer,
      $$SettingsEntriesTableCreateCompanionBuilder,
      $$SettingsEntriesTableUpdateCompanionBuilder,
      (
        SettingsEntry,
        BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>,
      ),
      SettingsEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db, _db.fields);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
  $$LineupsTableTableManager get lineups =>
      $$LineupsTableTableManager(_db, _db.lineups);
  $$LineupSlotsTableTableManager get lineupSlots =>
      $$LineupSlotsTableTableManager(_db, _db.lineupSlots);
  $$AttendanceTableTableManager get attendance =>
      $$AttendanceTableTableManager(_db, _db.attendance);
  $$TacticsTableTableManager get tactics =>
      $$TacticsTableTableManager(_db, _db.tactics);
  $$DoDontItemsTableTableManager get doDontItems =>
      $$DoDontItemsTableTableManager(_db, _db.doDontItems);
  $$SettingsEntriesTableTableManager get settingsEntries =>
      $$SettingsEntriesTableTableManager(_db, _db.settingsEntries);
}
