// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BanksTable extends Banks with TableInfo<$BanksTable, Bank> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BanksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _primaryColorMeta = const VerificationMeta(
    'primaryColor',
  );
  @override
  late final GeneratedColumn<String> primaryColor = GeneratedColumn<String>(
    'primary_color',
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
  @override
  List<GeneratedColumn> get $columns => [id, name, primaryColor, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bank> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('primary_color')) {
      context.handle(
        _primaryColorMeta,
        primaryColor.isAcceptableOrUnknown(
          data['primary_color']!,
          _primaryColorMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bank map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bank(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      primaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BanksTable createAlias(String alias) {
    return $BanksTable(attachedDatabase, alias);
  }
}

class Bank extends DataClass implements Insertable<Bank> {
  final String id;
  final String name;
  final String? primaryColor;
  final DateTime createdAt;
  const Bank({
    required this.id,
    required this.name,
    this.primaryColor,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || primaryColor != null) {
      map['primary_color'] = Variable<String>(primaryColor);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BanksCompanion toCompanion(bool nullToAbsent) {
    return BanksCompanion(
      id: Value(id),
      name: Value(name),
      primaryColor: primaryColor == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryColor),
      createdAt: Value(createdAt),
    );
  }

  factory Bank.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bank(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      primaryColor: serializer.fromJson<String?>(json['primaryColor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'primaryColor': serializer.toJson<String?>(primaryColor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bank copyWith({
    String? id,
    String? name,
    Value<String?> primaryColor = const Value.absent(),
    DateTime? createdAt,
  }) => Bank(
    id: id ?? this.id,
    name: name ?? this.name,
    primaryColor: primaryColor.present ? primaryColor.value : this.primaryColor,
    createdAt: createdAt ?? this.createdAt,
  );
  Bank copyWithCompanion(BanksCompanion data) {
    return Bank(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bank(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, primaryColor, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bank &&
          other.id == this.id &&
          other.name == this.name &&
          other.primaryColor == this.primaryColor &&
          other.createdAt == this.createdAt);
}

class BanksCompanion extends UpdateCompanion<Bank> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> primaryColor;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BanksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BanksCompanion.insert({
    required String id,
    required String name,
    this.primaryColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Bank> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? primaryColor,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BanksCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? primaryColor,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BanksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      primaryColor: primaryColor ?? this.primaryColor,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<String>(primaryColor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BanksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankTemplatesTableTable extends BankTemplatesTable
    with TableInfo<$BankTemplatesTableTable, BankTemplatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankTemplatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedColumn<String> bankId = GeneratedColumn<String>(
    'bank_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES banks (id)',
    ),
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdsMeta = const VerificationMeta(
    'senderIds',
  );
  @override
  late final GeneratedColumn<String> senderIds = GeneratedColumn<String>(
    'sender_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _txnTypeMeta = const VerificationMeta(
    'txnType',
  );
  @override
  late final GeneratedColumn<String> txnType = GeneratedColumn<String>(
    'txn_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateFormatMeta = const VerificationMeta(
    'dateFormat',
  );
  @override
  late final GeneratedColumn<String> dateFormat = GeneratedColumn<String>(
    'date_format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyKeywordsMeta = const VerificationMeta(
    'currencyKeywords',
  );
  @override
  late final GeneratedColumn<String> currencyKeywords = GeneratedColumn<String>(
    'currency_keywords',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenMapMeta = const VerificationMeta(
    'tokenMap',
  );
  @override
  late final GeneratedColumn<String> tokenMap = GeneratedColumn<String>(
    'token_map',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bankId,
    bankName,
    senderIds,
    txnType,
    pattern,
    dateFormat,
    currencyKeywords,
    tokenMap,
    version,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_templates_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankTemplatesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('bank_id')) {
      context.handle(
        _bankIdMeta,
        bankId.isAcceptableOrUnknown(data['bank_id']!, _bankIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bankIdMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('sender_ids')) {
      context.handle(
        _senderIdsMeta,
        senderIds.isAcceptableOrUnknown(data['sender_ids']!, _senderIdsMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdsMeta);
    }
    if (data.containsKey('txn_type')) {
      context.handle(
        _txnTypeMeta,
        txnType.isAcceptableOrUnknown(data['txn_type']!, _txnTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_txnTypeMeta);
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    if (data.containsKey('date_format')) {
      context.handle(
        _dateFormatMeta,
        dateFormat.isAcceptableOrUnknown(data['date_format']!, _dateFormatMeta),
      );
    } else if (isInserting) {
      context.missing(_dateFormatMeta);
    }
    if (data.containsKey('currency_keywords')) {
      context.handle(
        _currencyKeywordsMeta,
        currencyKeywords.isAcceptableOrUnknown(
          data['currency_keywords']!,
          _currencyKeywordsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyKeywordsMeta);
    }
    if (data.containsKey('token_map')) {
      context.handle(
        _tokenMapMeta,
        tokenMap.isAcceptableOrUnknown(data['token_map']!, _tokenMapMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMapMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankTemplatesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankTemplatesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bankId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_id'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      senderIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_ids'],
      )!,
      txnType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}txn_type'],
      )!,
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      )!,
      dateFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_format'],
      )!,
      currencyKeywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_keywords'],
      )!,
      tokenMap: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token_map'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BankTemplatesTableTable createAlias(String alias) {
    return $BankTemplatesTableTable(attachedDatabase, alias);
  }
}

class BankTemplatesTableData extends DataClass
    implements Insertable<BankTemplatesTableData> {
  final String id;
  final String bankId;
  final String bankName;
  final String senderIds;
  final String txnType;
  final String pattern;
  final String dateFormat;
  final String currencyKeywords;
  final String tokenMap;
  final int version;
  final bool isActive;
  final DateTime createdAt;
  const BankTemplatesTableData({
    required this.id,
    required this.bankId,
    required this.bankName,
    required this.senderIds,
    required this.txnType,
    required this.pattern,
    required this.dateFormat,
    required this.currencyKeywords,
    required this.tokenMap,
    required this.version,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bank_id'] = Variable<String>(bankId);
    map['bank_name'] = Variable<String>(bankName);
    map['sender_ids'] = Variable<String>(senderIds);
    map['txn_type'] = Variable<String>(txnType);
    map['pattern'] = Variable<String>(pattern);
    map['date_format'] = Variable<String>(dateFormat);
    map['currency_keywords'] = Variable<String>(currencyKeywords);
    map['token_map'] = Variable<String>(tokenMap);
    map['version'] = Variable<int>(version);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BankTemplatesTableCompanion toCompanion(bool nullToAbsent) {
    return BankTemplatesTableCompanion(
      id: Value(id),
      bankId: Value(bankId),
      bankName: Value(bankName),
      senderIds: Value(senderIds),
      txnType: Value(txnType),
      pattern: Value(pattern),
      dateFormat: Value(dateFormat),
      currencyKeywords: Value(currencyKeywords),
      tokenMap: Value(tokenMap),
      version: Value(version),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory BankTemplatesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankTemplatesTableData(
      id: serializer.fromJson<String>(json['id']),
      bankId: serializer.fromJson<String>(json['bankId']),
      bankName: serializer.fromJson<String>(json['bankName']),
      senderIds: serializer.fromJson<String>(json['senderIds']),
      txnType: serializer.fromJson<String>(json['txnType']),
      pattern: serializer.fromJson<String>(json['pattern']),
      dateFormat: serializer.fromJson<String>(json['dateFormat']),
      currencyKeywords: serializer.fromJson<String>(json['currencyKeywords']),
      tokenMap: serializer.fromJson<String>(json['tokenMap']),
      version: serializer.fromJson<int>(json['version']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bankId': serializer.toJson<String>(bankId),
      'bankName': serializer.toJson<String>(bankName),
      'senderIds': serializer.toJson<String>(senderIds),
      'txnType': serializer.toJson<String>(txnType),
      'pattern': serializer.toJson<String>(pattern),
      'dateFormat': serializer.toJson<String>(dateFormat),
      'currencyKeywords': serializer.toJson<String>(currencyKeywords),
      'tokenMap': serializer.toJson<String>(tokenMap),
      'version': serializer.toJson<int>(version),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BankTemplatesTableData copyWith({
    String? id,
    String? bankId,
    String? bankName,
    String? senderIds,
    String? txnType,
    String? pattern,
    String? dateFormat,
    String? currencyKeywords,
    String? tokenMap,
    int? version,
    bool? isActive,
    DateTime? createdAt,
  }) => BankTemplatesTableData(
    id: id ?? this.id,
    bankId: bankId ?? this.bankId,
    bankName: bankName ?? this.bankName,
    senderIds: senderIds ?? this.senderIds,
    txnType: txnType ?? this.txnType,
    pattern: pattern ?? this.pattern,
    dateFormat: dateFormat ?? this.dateFormat,
    currencyKeywords: currencyKeywords ?? this.currencyKeywords,
    tokenMap: tokenMap ?? this.tokenMap,
    version: version ?? this.version,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  BankTemplatesTableData copyWithCompanion(BankTemplatesTableCompanion data) {
    return BankTemplatesTableData(
      id: data.id.present ? data.id.value : this.id,
      bankId: data.bankId.present ? data.bankId.value : this.bankId,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      senderIds: data.senderIds.present ? data.senderIds.value : this.senderIds,
      txnType: data.txnType.present ? data.txnType.value : this.txnType,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      dateFormat: data.dateFormat.present
          ? data.dateFormat.value
          : this.dateFormat,
      currencyKeywords: data.currencyKeywords.present
          ? data.currencyKeywords.value
          : this.currencyKeywords,
      tokenMap: data.tokenMap.present ? data.tokenMap.value : this.tokenMap,
      version: data.version.present ? data.version.value : this.version,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankTemplatesTableData(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('bankName: $bankName, ')
          ..write('senderIds: $senderIds, ')
          ..write('txnType: $txnType, ')
          ..write('pattern: $pattern, ')
          ..write('dateFormat: $dateFormat, ')
          ..write('currencyKeywords: $currencyKeywords, ')
          ..write('tokenMap: $tokenMap, ')
          ..write('version: $version, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bankId,
    bankName,
    senderIds,
    txnType,
    pattern,
    dateFormat,
    currencyKeywords,
    tokenMap,
    version,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankTemplatesTableData &&
          other.id == this.id &&
          other.bankId == this.bankId &&
          other.bankName == this.bankName &&
          other.senderIds == this.senderIds &&
          other.txnType == this.txnType &&
          other.pattern == this.pattern &&
          other.dateFormat == this.dateFormat &&
          other.currencyKeywords == this.currencyKeywords &&
          other.tokenMap == this.tokenMap &&
          other.version == this.version &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class BankTemplatesTableCompanion
    extends UpdateCompanion<BankTemplatesTableData> {
  final Value<String> id;
  final Value<String> bankId;
  final Value<String> bankName;
  final Value<String> senderIds;
  final Value<String> txnType;
  final Value<String> pattern;
  final Value<String> dateFormat;
  final Value<String> currencyKeywords;
  final Value<String> tokenMap;
  final Value<int> version;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BankTemplatesTableCompanion({
    this.id = const Value.absent(),
    this.bankId = const Value.absent(),
    this.bankName = const Value.absent(),
    this.senderIds = const Value.absent(),
    this.txnType = const Value.absent(),
    this.pattern = const Value.absent(),
    this.dateFormat = const Value.absent(),
    this.currencyKeywords = const Value.absent(),
    this.tokenMap = const Value.absent(),
    this.version = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankTemplatesTableCompanion.insert({
    required String id,
    required String bankId,
    required String bankName,
    required String senderIds,
    required String txnType,
    required String pattern,
    required String dateFormat,
    required String currencyKeywords,
    required String tokenMap,
    this.version = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bankId = Value(bankId),
       bankName = Value(bankName),
       senderIds = Value(senderIds),
       txnType = Value(txnType),
       pattern = Value(pattern),
       dateFormat = Value(dateFormat),
       currencyKeywords = Value(currencyKeywords),
       tokenMap = Value(tokenMap);
  static Insertable<BankTemplatesTableData> custom({
    Expression<String>? id,
    Expression<String>? bankId,
    Expression<String>? bankName,
    Expression<String>? senderIds,
    Expression<String>? txnType,
    Expression<String>? pattern,
    Expression<String>? dateFormat,
    Expression<String>? currencyKeywords,
    Expression<String>? tokenMap,
    Expression<int>? version,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankId != null) 'bank_id': bankId,
      if (bankName != null) 'bank_name': bankName,
      if (senderIds != null) 'sender_ids': senderIds,
      if (txnType != null) 'txn_type': txnType,
      if (pattern != null) 'pattern': pattern,
      if (dateFormat != null) 'date_format': dateFormat,
      if (currencyKeywords != null) 'currency_keywords': currencyKeywords,
      if (tokenMap != null) 'token_map': tokenMap,
      if (version != null) 'version': version,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankTemplatesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? bankId,
    Value<String>? bankName,
    Value<String>? senderIds,
    Value<String>? txnType,
    Value<String>? pattern,
    Value<String>? dateFormat,
    Value<String>? currencyKeywords,
    Value<String>? tokenMap,
    Value<int>? version,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BankTemplatesTableCompanion(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      bankName: bankName ?? this.bankName,
      senderIds: senderIds ?? this.senderIds,
      txnType: txnType ?? this.txnType,
      pattern: pattern ?? this.pattern,
      dateFormat: dateFormat ?? this.dateFormat,
      currencyKeywords: currencyKeywords ?? this.currencyKeywords,
      tokenMap: tokenMap ?? this.tokenMap,
      version: version ?? this.version,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (senderIds.present) {
      map['sender_ids'] = Variable<String>(senderIds.value);
    }
    if (txnType.present) {
      map['txn_type'] = Variable<String>(txnType.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (dateFormat.present) {
      map['date_format'] = Variable<String>(dateFormat.value);
    }
    if (currencyKeywords.present) {
      map['currency_keywords'] = Variable<String>(currencyKeywords.value);
    }
    if (tokenMap.present) {
      map['token_map'] = Variable<String>(tokenMap.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankTemplatesTableCompanion(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('bankName: $bankName, ')
          ..write('senderIds: $senderIds, ')
          ..write('txnType: $txnType, ')
          ..write('pattern: $pattern, ')
          ..write('dateFormat: $dateFormat, ')
          ..write('currencyKeywords: $currencyKeywords, ')
          ..write('tokenMap: $tokenMap, ')
          ..write('version: $version, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedColumn<String> bankId = GeneratedColumn<String>(
    'bank_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES banks (id)',
    ),
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _last4DigitsMeta = const VerificationMeta(
    'last4Digits',
  );
  @override
  late final GeneratedColumn<String> last4Digits = GeneratedColumn<String>(
    'last4_digits',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOwnAccountMeta = const VerificationMeta(
    'isOwnAccount',
  );
  @override
  late final GeneratedColumn<bool> isOwnAccount = GeneratedColumn<bool>(
    'is_own_account',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_own_account" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _runningBalancePaiseMeta =
      const VerificationMeta('runningBalancePaise');
  @override
  late final GeneratedColumn<int> runningBalancePaise = GeneratedColumn<int>(
    'running_balance_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bankId,
    bankName,
    last4Digits,
    nickname,
    isOwnAccount,
    isArchived,
    runningBalancePaise,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('bank_id')) {
      context.handle(
        _bankIdMeta,
        bankId.isAcceptableOrUnknown(data['bank_id']!, _bankIdMeta),
      );
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('last4_digits')) {
      context.handle(
        _last4DigitsMeta,
        last4Digits.isAcceptableOrUnknown(
          data['last4_digits']!,
          _last4DigitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_last4DigitsMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('is_own_account')) {
      context.handle(
        _isOwnAccountMeta,
        isOwnAccount.isAcceptableOrUnknown(
          data['is_own_account']!,
          _isOwnAccountMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('running_balance_paise')) {
      context.handle(
        _runningBalancePaiseMeta,
        runningBalancePaise.isAcceptableOrUnknown(
          data['running_balance_paise']!,
          _runningBalancePaiseMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bankId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_id'],
      ),
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      last4Digits: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last4_digits'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      isOwnAccount: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_own_account'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      runningBalancePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}running_balance_paise'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final String id;
  final String? bankId;
  final String bankName;
  final String last4Digits;
  final String? nickname;
  final bool isOwnAccount;
  final bool isArchived;
  final int runningBalancePaise;
  final DateTime createdAt;
  const Account({
    required this.id,
    this.bankId,
    required this.bankName,
    required this.last4Digits,
    this.nickname,
    required this.isOwnAccount,
    required this.isArchived,
    required this.runningBalancePaise,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || bankId != null) {
      map['bank_id'] = Variable<String>(bankId);
    }
    map['bank_name'] = Variable<String>(bankName);
    map['last4_digits'] = Variable<String>(last4Digits);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['is_own_account'] = Variable<bool>(isOwnAccount);
    map['is_archived'] = Variable<bool>(isArchived);
    map['running_balance_paise'] = Variable<int>(runningBalancePaise);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      bankId: bankId == null && nullToAbsent
          ? const Value.absent()
          : Value(bankId),
      bankName: Value(bankName),
      last4Digits: Value(last4Digits),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      isOwnAccount: Value(isOwnAccount),
      isArchived: Value(isArchived),
      runningBalancePaise: Value(runningBalancePaise),
      createdAt: Value(createdAt),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      bankId: serializer.fromJson<String?>(json['bankId']),
      bankName: serializer.fromJson<String>(json['bankName']),
      last4Digits: serializer.fromJson<String>(json['last4Digits']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      isOwnAccount: serializer.fromJson<bool>(json['isOwnAccount']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      runningBalancePaise: serializer.fromJson<int>(
        json['runningBalancePaise'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bankId': serializer.toJson<String?>(bankId),
      'bankName': serializer.toJson<String>(bankName),
      'last4Digits': serializer.toJson<String>(last4Digits),
      'nickname': serializer.toJson<String?>(nickname),
      'isOwnAccount': serializer.toJson<bool>(isOwnAccount),
      'isArchived': serializer.toJson<bool>(isArchived),
      'runningBalancePaise': serializer.toJson<int>(runningBalancePaise),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Account copyWith({
    String? id,
    Value<String?> bankId = const Value.absent(),
    String? bankName,
    String? last4Digits,
    Value<String?> nickname = const Value.absent(),
    bool? isOwnAccount,
    bool? isArchived,
    int? runningBalancePaise,
    DateTime? createdAt,
  }) => Account(
    id: id ?? this.id,
    bankId: bankId.present ? bankId.value : this.bankId,
    bankName: bankName ?? this.bankName,
    last4Digits: last4Digits ?? this.last4Digits,
    nickname: nickname.present ? nickname.value : this.nickname,
    isOwnAccount: isOwnAccount ?? this.isOwnAccount,
    isArchived: isArchived ?? this.isArchived,
    runningBalancePaise: runningBalancePaise ?? this.runningBalancePaise,
    createdAt: createdAt ?? this.createdAt,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      bankId: data.bankId.present ? data.bankId.value : this.bankId,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      last4Digits: data.last4Digits.present
          ? data.last4Digits.value
          : this.last4Digits,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      isOwnAccount: data.isOwnAccount.present
          ? data.isOwnAccount.value
          : this.isOwnAccount,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      runningBalancePaise: data.runningBalancePaise.present
          ? data.runningBalancePaise.value
          : this.runningBalancePaise,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('bankName: $bankName, ')
          ..write('last4Digits: $last4Digits, ')
          ..write('nickname: $nickname, ')
          ..write('isOwnAccount: $isOwnAccount, ')
          ..write('isArchived: $isArchived, ')
          ..write('runningBalancePaise: $runningBalancePaise, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bankId,
    bankName,
    last4Digits,
    nickname,
    isOwnAccount,
    isArchived,
    runningBalancePaise,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.bankId == this.bankId &&
          other.bankName == this.bankName &&
          other.last4Digits == this.last4Digits &&
          other.nickname == this.nickname &&
          other.isOwnAccount == this.isOwnAccount &&
          other.isArchived == this.isArchived &&
          other.runningBalancePaise == this.runningBalancePaise &&
          other.createdAt == this.createdAt);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<String?> bankId;
  final Value<String> bankName;
  final Value<String> last4Digits;
  final Value<String?> nickname;
  final Value<bool> isOwnAccount;
  final Value<bool> isArchived;
  final Value<int> runningBalancePaise;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.bankId = const Value.absent(),
    this.bankName = const Value.absent(),
    this.last4Digits = const Value.absent(),
    this.nickname = const Value.absent(),
    this.isOwnAccount = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.runningBalancePaise = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    this.bankId = const Value.absent(),
    required String bankName,
    required String last4Digits,
    this.nickname = const Value.absent(),
    this.isOwnAccount = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.runningBalancePaise = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bankName = Value(bankName),
       last4Digits = Value(last4Digits);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<String>? bankId,
    Expression<String>? bankName,
    Expression<String>? last4Digits,
    Expression<String>? nickname,
    Expression<bool>? isOwnAccount,
    Expression<bool>? isArchived,
    Expression<int>? runningBalancePaise,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankId != null) 'bank_id': bankId,
      if (bankName != null) 'bank_name': bankName,
      if (last4Digits != null) 'last4_digits': last4Digits,
      if (nickname != null) 'nickname': nickname,
      if (isOwnAccount != null) 'is_own_account': isOwnAccount,
      if (isArchived != null) 'is_archived': isArchived,
      if (runningBalancePaise != null)
        'running_balance_paise': runningBalancePaise,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String?>? bankId,
    Value<String>? bankName,
    Value<String>? last4Digits,
    Value<String?>? nickname,
    Value<bool>? isOwnAccount,
    Value<bool>? isArchived,
    Value<int>? runningBalancePaise,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      bankName: bankName ?? this.bankName,
      last4Digits: last4Digits ?? this.last4Digits,
      nickname: nickname ?? this.nickname,
      isOwnAccount: isOwnAccount ?? this.isOwnAccount,
      isArchived: isArchived ?? this.isArchived,
      runningBalancePaise: runningBalancePaise ?? this.runningBalancePaise,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (last4Digits.present) {
      map['last4_digits'] = Variable<String>(last4Digits.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (isOwnAccount.present) {
      map['is_own_account'] = Variable<bool>(isOwnAccount.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (runningBalancePaise.present) {
      map['running_balance_paise'] = Variable<int>(runningBalancePaise.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('bankName: $bankName, ')
          ..write('last4Digits: $last4Digits, ')
          ..write('nickname: $nickname, ')
          ..write('isOwnAccount: $isOwnAccount, ')
          ..write('isArchived: $isArchived, ')
          ..write('runningBalancePaise: $runningBalancePaise, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalarySourcesTable extends SalarySources
    with TableInfo<$SalarySourcesTable, SalarySource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalarySourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sendingAccountDigitsMeta =
      const VerificationMeta('sendingAccountDigits');
  @override
  late final GeneratedColumn<String> sendingAccountDigits =
      GeneratedColumn<String>(
        'sending_account_digits',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _linkedAccountIdMeta = const VerificationMeta(
    'linkedAccountId',
  );
  @override
  late final GeneratedColumn<String> linkedAccountId = GeneratedColumn<String>(
    'linked_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _lastCreditedAmountPaiseMeta =
      const VerificationMeta('lastCreditedAmountPaise');
  @override
  late final GeneratedColumn<int> lastCreditedAmountPaise =
      GeneratedColumn<int>(
        'last_credited_amount_paise',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastCreditedDateMeta = const VerificationMeta(
    'lastCreditedDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastCreditedDate =
      GeneratedColumn<DateTime>(
        'last_credited_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isPausedMeta = const VerificationMeta(
    'isPaused',
  );
  @override
  late final GeneratedColumn<bool> isPaused = GeneratedColumn<bool>(
    'is_paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paused" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    sendingAccountDigits,
    linkedAccountId,
    lastCreditedAmountPaise,
    lastCreditedDate,
    isPaused,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'salary_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalarySource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('sending_account_digits')) {
      context.handle(
        _sendingAccountDigitsMeta,
        sendingAccountDigits.isAcceptableOrUnknown(
          data['sending_account_digits']!,
          _sendingAccountDigitsMeta,
        ),
      );
    }
    if (data.containsKey('linked_account_id')) {
      context.handle(
        _linkedAccountIdMeta,
        linkedAccountId.isAcceptableOrUnknown(
          data['linked_account_id']!,
          _linkedAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('last_credited_amount_paise')) {
      context.handle(
        _lastCreditedAmountPaiseMeta,
        lastCreditedAmountPaise.isAcceptableOrUnknown(
          data['last_credited_amount_paise']!,
          _lastCreditedAmountPaiseMeta,
        ),
      );
    }
    if (data.containsKey('last_credited_date')) {
      context.handle(
        _lastCreditedDateMeta,
        lastCreditedDate.isAcceptableOrUnknown(
          data['last_credited_date']!,
          _lastCreditedDateMeta,
        ),
      );
    }
    if (data.containsKey('is_paused')) {
      context.handle(
        _isPausedMeta,
        isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalarySource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalarySource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      sendingAccountDigits: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sending_account_digits'],
      ),
      linkedAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_account_id'],
      ),
      lastCreditedAmountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_credited_amount_paise'],
      ),
      lastCreditedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_credited_date'],
      ),
      isPaused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paused'],
      )!,
    );
  }

  @override
  $SalarySourcesTable createAlias(String alias) {
    return $SalarySourcesTable(attachedDatabase, alias);
  }
}

class SalarySource extends DataClass implements Insertable<SalarySource> {
  final String id;
  final String label;
  final String? sendingAccountDigits;
  final String? linkedAccountId;
  final int? lastCreditedAmountPaise;
  final DateTime? lastCreditedDate;
  final bool isPaused;
  const SalarySource({
    required this.id,
    required this.label,
    this.sendingAccountDigits,
    this.linkedAccountId,
    this.lastCreditedAmountPaise,
    this.lastCreditedDate,
    required this.isPaused,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || sendingAccountDigits != null) {
      map['sending_account_digits'] = Variable<String>(sendingAccountDigits);
    }
    if (!nullToAbsent || linkedAccountId != null) {
      map['linked_account_id'] = Variable<String>(linkedAccountId);
    }
    if (!nullToAbsent || lastCreditedAmountPaise != null) {
      map['last_credited_amount_paise'] = Variable<int>(
        lastCreditedAmountPaise,
      );
    }
    if (!nullToAbsent || lastCreditedDate != null) {
      map['last_credited_date'] = Variable<DateTime>(lastCreditedDate);
    }
    map['is_paused'] = Variable<bool>(isPaused);
    return map;
  }

  SalarySourcesCompanion toCompanion(bool nullToAbsent) {
    return SalarySourcesCompanion(
      id: Value(id),
      label: Value(label),
      sendingAccountDigits: sendingAccountDigits == null && nullToAbsent
          ? const Value.absent()
          : Value(sendingAccountDigits),
      linkedAccountId: linkedAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedAccountId),
      lastCreditedAmountPaise: lastCreditedAmountPaise == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCreditedAmountPaise),
      lastCreditedDate: lastCreditedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCreditedDate),
      isPaused: Value(isPaused),
    );
  }

  factory SalarySource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalarySource(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      sendingAccountDigits: serializer.fromJson<String?>(
        json['sendingAccountDigits'],
      ),
      linkedAccountId: serializer.fromJson<String?>(json['linkedAccountId']),
      lastCreditedAmountPaise: serializer.fromJson<int?>(
        json['lastCreditedAmountPaise'],
      ),
      lastCreditedDate: serializer.fromJson<DateTime?>(
        json['lastCreditedDate'],
      ),
      isPaused: serializer.fromJson<bool>(json['isPaused']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'sendingAccountDigits': serializer.toJson<String?>(sendingAccountDigits),
      'linkedAccountId': serializer.toJson<String?>(linkedAccountId),
      'lastCreditedAmountPaise': serializer.toJson<int?>(
        lastCreditedAmountPaise,
      ),
      'lastCreditedDate': serializer.toJson<DateTime?>(lastCreditedDate),
      'isPaused': serializer.toJson<bool>(isPaused),
    };
  }

  SalarySource copyWith({
    String? id,
    String? label,
    Value<String?> sendingAccountDigits = const Value.absent(),
    Value<String?> linkedAccountId = const Value.absent(),
    Value<int?> lastCreditedAmountPaise = const Value.absent(),
    Value<DateTime?> lastCreditedDate = const Value.absent(),
    bool? isPaused,
  }) => SalarySource(
    id: id ?? this.id,
    label: label ?? this.label,
    sendingAccountDigits: sendingAccountDigits.present
        ? sendingAccountDigits.value
        : this.sendingAccountDigits,
    linkedAccountId: linkedAccountId.present
        ? linkedAccountId.value
        : this.linkedAccountId,
    lastCreditedAmountPaise: lastCreditedAmountPaise.present
        ? lastCreditedAmountPaise.value
        : this.lastCreditedAmountPaise,
    lastCreditedDate: lastCreditedDate.present
        ? lastCreditedDate.value
        : this.lastCreditedDate,
    isPaused: isPaused ?? this.isPaused,
  );
  SalarySource copyWithCompanion(SalarySourcesCompanion data) {
    return SalarySource(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      sendingAccountDigits: data.sendingAccountDigits.present
          ? data.sendingAccountDigits.value
          : this.sendingAccountDigits,
      linkedAccountId: data.linkedAccountId.present
          ? data.linkedAccountId.value
          : this.linkedAccountId,
      lastCreditedAmountPaise: data.lastCreditedAmountPaise.present
          ? data.lastCreditedAmountPaise.value
          : this.lastCreditedAmountPaise,
      lastCreditedDate: data.lastCreditedDate.present
          ? data.lastCreditedDate.value
          : this.lastCreditedDate,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalarySource(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('sendingAccountDigits: $sendingAccountDigits, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('lastCreditedAmountPaise: $lastCreditedAmountPaise, ')
          ..write('lastCreditedDate: $lastCreditedDate, ')
          ..write('isPaused: $isPaused')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    label,
    sendingAccountDigits,
    linkedAccountId,
    lastCreditedAmountPaise,
    lastCreditedDate,
    isPaused,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalarySource &&
          other.id == this.id &&
          other.label == this.label &&
          other.sendingAccountDigits == this.sendingAccountDigits &&
          other.linkedAccountId == this.linkedAccountId &&
          other.lastCreditedAmountPaise == this.lastCreditedAmountPaise &&
          other.lastCreditedDate == this.lastCreditedDate &&
          other.isPaused == this.isPaused);
}

class SalarySourcesCompanion extends UpdateCompanion<SalarySource> {
  final Value<String> id;
  final Value<String> label;
  final Value<String?> sendingAccountDigits;
  final Value<String?> linkedAccountId;
  final Value<int?> lastCreditedAmountPaise;
  final Value<DateTime?> lastCreditedDate;
  final Value<bool> isPaused;
  final Value<int> rowid;
  const SalarySourcesCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.sendingAccountDigits = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.lastCreditedAmountPaise = const Value.absent(),
    this.lastCreditedDate = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalarySourcesCompanion.insert({
    required String id,
    required String label,
    this.sendingAccountDigits = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.lastCreditedAmountPaise = const Value.absent(),
    this.lastCreditedDate = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       label = Value(label);
  static Insertable<SalarySource> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? sendingAccountDigits,
    Expression<String>? linkedAccountId,
    Expression<int>? lastCreditedAmountPaise,
    Expression<DateTime>? lastCreditedDate,
    Expression<bool>? isPaused,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (sendingAccountDigits != null)
        'sending_account_digits': sendingAccountDigits,
      if (linkedAccountId != null) 'linked_account_id': linkedAccountId,
      if (lastCreditedAmountPaise != null)
        'last_credited_amount_paise': lastCreditedAmountPaise,
      if (lastCreditedDate != null) 'last_credited_date': lastCreditedDate,
      if (isPaused != null) 'is_paused': isPaused,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalarySourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<String?>? sendingAccountDigits,
    Value<String?>? linkedAccountId,
    Value<int?>? lastCreditedAmountPaise,
    Value<DateTime?>? lastCreditedDate,
    Value<bool>? isPaused,
    Value<int>? rowid,
  }) {
    return SalarySourcesCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      sendingAccountDigits: sendingAccountDigits ?? this.sendingAccountDigits,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      lastCreditedAmountPaise:
          lastCreditedAmountPaise ?? this.lastCreditedAmountPaise,
      lastCreditedDate: lastCreditedDate ?? this.lastCreditedDate,
      isPaused: isPaused ?? this.isPaused,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (sendingAccountDigits.present) {
      map['sending_account_digits'] = Variable<String>(
        sendingAccountDigits.value,
      );
    }
    if (linkedAccountId.present) {
      map['linked_account_id'] = Variable<String>(linkedAccountId.value);
    }
    if (lastCreditedAmountPaise.present) {
      map['last_credited_amount_paise'] = Variable<int>(
        lastCreditedAmountPaise.value,
      );
    }
    if (lastCreditedDate.present) {
      map['last_credited_date'] = Variable<DateTime>(lastCreditedDate.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<bool>(isPaused.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalarySourcesCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('sendingAccountDigits: $sendingAccountDigits, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('lastCreditedAmountPaise: $lastCreditedAmountPaise, ')
          ..write('lastCreditedDate: $lastCreditedDate, ')
          ..write('isPaused: $isPaused, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CyclesTable extends Cycles with TableInfo<$CyclesTable, Cycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedNextDateMeta = const VerificationMeta(
    'expectedNextDate',
  );
  @override
  late final GeneratedColumn<DateTime> expectedNextDate =
      GeneratedColumn<DateTime>(
        'expected_next_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _confirmedSalaryPaiseMeta =
      const VerificationMeta('confirmedSalaryPaise');
  @override
  late final GeneratedColumn<int> confirmedSalaryPaise = GeneratedColumn<int>(
    'confirmed_salary_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startDate,
    endDate,
    expectedNextDate,
    confirmedSalaryPaise,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cycles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cycle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('expected_next_date')) {
      context.handle(
        _expectedNextDateMeta,
        expectedNextDate.isAcceptableOrUnknown(
          data['expected_next_date']!,
          _expectedNextDateMeta,
        ),
      );
    }
    if (data.containsKey('confirmed_salary_paise')) {
      context.handle(
        _confirmedSalaryPaiseMeta,
        confirmedSalaryPaise.isAcceptableOrUnknown(
          data['confirmed_salary_paise']!,
          _confirmedSalaryPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confirmedSalaryPaiseMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cycle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      expectedNextDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_next_date'],
      ),
      confirmedSalaryPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confirmed_salary_paise'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $CyclesTable createAlias(String alias) {
    return $CyclesTable(attachedDatabase, alias);
  }
}

class Cycle extends DataClass implements Insertable<Cycle> {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? expectedNextDate;
  final int confirmedSalaryPaise;
  final bool isActive;
  const Cycle({
    required this.id,
    required this.startDate,
    this.endDate,
    this.expectedNextDate,
    required this.confirmedSalaryPaise,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || expectedNextDate != null) {
      map['expected_next_date'] = Variable<DateTime>(expectedNextDate);
    }
    map['confirmed_salary_paise'] = Variable<int>(confirmedSalaryPaise);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  CyclesCompanion toCompanion(bool nullToAbsent) {
    return CyclesCompanion(
      id: Value(id),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      expectedNextDate: expectedNextDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedNextDate),
      confirmedSalaryPaise: Value(confirmedSalaryPaise),
      isActive: Value(isActive),
    );
  }

  factory Cycle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cycle(
      id: serializer.fromJson<String>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      expectedNextDate: serializer.fromJson<DateTime?>(
        json['expectedNextDate'],
      ),
      confirmedSalaryPaise: serializer.fromJson<int>(
        json['confirmedSalaryPaise'],
      ),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'expectedNextDate': serializer.toJson<DateTime?>(expectedNextDate),
      'confirmedSalaryPaise': serializer.toJson<int>(confirmedSalaryPaise),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Cycle copyWith({
    String? id,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<DateTime?> expectedNextDate = const Value.absent(),
    int? confirmedSalaryPaise,
    bool? isActive,
  }) => Cycle(
    id: id ?? this.id,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    expectedNextDate: expectedNextDate.present
        ? expectedNextDate.value
        : this.expectedNextDate,
    confirmedSalaryPaise: confirmedSalaryPaise ?? this.confirmedSalaryPaise,
    isActive: isActive ?? this.isActive,
  );
  Cycle copyWithCompanion(CyclesCompanion data) {
    return Cycle(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      expectedNextDate: data.expectedNextDate.present
          ? data.expectedNextDate.value
          : this.expectedNextDate,
      confirmedSalaryPaise: data.confirmedSalaryPaise.present
          ? data.confirmedSalaryPaise.value
          : this.confirmedSalaryPaise,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cycle(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('expectedNextDate: $expectedNextDate, ')
          ..write('confirmedSalaryPaise: $confirmedSalaryPaise, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startDate,
    endDate,
    expectedNextDate,
    confirmedSalaryPaise,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cycle &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.expectedNextDate == this.expectedNextDate &&
          other.confirmedSalaryPaise == this.confirmedSalaryPaise &&
          other.isActive == this.isActive);
}

class CyclesCompanion extends UpdateCompanion<Cycle> {
  final Value<String> id;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<DateTime?> expectedNextDate;
  final Value<int> confirmedSalaryPaise;
  final Value<bool> isActive;
  final Value<int> rowid;
  const CyclesCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.expectedNextDate = const Value.absent(),
    this.confirmedSalaryPaise = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CyclesCompanion.insert({
    required String id,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.expectedNextDate = const Value.absent(),
    required int confirmedSalaryPaise,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startDate = Value(startDate),
       confirmedSalaryPaise = Value(confirmedSalaryPaise);
  static Insertable<Cycle> custom({
    Expression<String>? id,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? expectedNextDate,
    Expression<int>? confirmedSalaryPaise,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (expectedNextDate != null) 'expected_next_date': expectedNextDate,
      if (confirmedSalaryPaise != null)
        'confirmed_salary_paise': confirmedSalaryPaise,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CyclesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<DateTime?>? expectedNextDate,
    Value<int>? confirmedSalaryPaise,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return CyclesCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      expectedNextDate: expectedNextDate ?? this.expectedNextDate,
      confirmedSalaryPaise: confirmedSalaryPaise ?? this.confirmedSalaryPaise,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (expectedNextDate.present) {
      map['expected_next_date'] = Variable<DateTime>(expectedNextDate.value);
    }
    if (confirmedSalaryPaise.present) {
      map['confirmed_salary_paise'] = Variable<int>(confirmedSalaryPaise.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CyclesCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('expectedNextDate: $expectedNextDate, ')
          ..write('confirmedSalaryPaise: $confirmedSalaryPaise, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _budgetTypeMeta = const VerificationMeta(
    'budgetType',
  );
  @override
  late final GeneratedColumn<String> budgetType = GeneratedColumn<String>(
    'budget_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthlyLimitPaiseMeta = const VerificationMeta(
    'monthlyLimitPaise',
  );
  @override
  late final GeneratedColumn<int> monthlyLimitPaise = GeneratedColumn<int>(
    'monthly_limit_paise',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    icon,
    budgetType,
    monthlyLimitPaise,
    isCustom,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('budget_type')) {
      context.handle(
        _budgetTypeMeta,
        budgetType.isAcceptableOrUnknown(data['budget_type']!, _budgetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_budgetTypeMeta);
    }
    if (data.containsKey('monthly_limit_paise')) {
      context.handle(
        _monthlyLimitPaiseMeta,
        monthlyLimitPaise.isAcceptableOrUnknown(
          data['monthly_limit_paise']!,
          _monthlyLimitPaiseMeta,
        ),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      budgetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}budget_type'],
      )!,
      monthlyLimitPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_limit_paise'],
      ),
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final String icon;
  final String budgetType;
  final int? monthlyLimitPaise;
  final bool isCustom;
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.budgetType,
    this.monthlyLimitPaise,
    required this.isCustom,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['budget_type'] = Variable<String>(budgetType);
    if (!nullToAbsent || monthlyLimitPaise != null) {
      map['monthly_limit_paise'] = Variable<int>(monthlyLimitPaise);
    }
    map['is_custom'] = Variable<bool>(isCustom);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      budgetType: Value(budgetType),
      monthlyLimitPaise: monthlyLimitPaise == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyLimitPaise),
      isCustom: Value(isCustom),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      budgetType: serializer.fromJson<String>(json['budgetType']),
      monthlyLimitPaise: serializer.fromJson<int?>(json['monthlyLimitPaise']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'budgetType': serializer.toJson<String>(budgetType),
      'monthlyLimitPaise': serializer.toJson<int?>(monthlyLimitPaise),
      'isCustom': serializer.toJson<bool>(isCustom),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    String? budgetType,
    Value<int?> monthlyLimitPaise = const Value.absent(),
    bool? isCustom,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    budgetType: budgetType ?? this.budgetType,
    monthlyLimitPaise: monthlyLimitPaise.present
        ? monthlyLimitPaise.value
        : this.monthlyLimitPaise,
    isCustom: isCustom ?? this.isCustom,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      budgetType: data.budgetType.present
          ? data.budgetType.value
          : this.budgetType,
      monthlyLimitPaise: data.monthlyLimitPaise.present
          ? data.monthlyLimitPaise.value
          : this.monthlyLimitPaise,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('budgetType: $budgetType, ')
          ..write('monthlyLimitPaise: $monthlyLimitPaise, ')
          ..write('isCustom: $isCustom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, icon, budgetType, monthlyLimitPaise, isCustom);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.budgetType == this.budgetType &&
          other.monthlyLimitPaise == this.monthlyLimitPaise &&
          other.isCustom == this.isCustom);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> budgetType;
  final Value<int?> monthlyLimitPaise;
  final Value<bool> isCustom;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.budgetType = const Value.absent(),
    this.monthlyLimitPaise = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String icon,
    required String budgetType,
    this.monthlyLimitPaise = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       icon = Value(icon),
       budgetType = Value(budgetType);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? budgetType,
    Expression<int>? monthlyLimitPaise,
    Expression<bool>? isCustom,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (budgetType != null) 'budget_type': budgetType,
      if (monthlyLimitPaise != null) 'monthly_limit_paise': monthlyLimitPaise,
      if (isCustom != null) 'is_custom': isCustom,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<String>? budgetType,
    Value<int?>? monthlyLimitPaise,
    Value<bool>? isCustom,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      budgetType: budgetType ?? this.budgetType,
      monthlyLimitPaise: monthlyLimitPaise ?? this.monthlyLimitPaise,
      isCustom: isCustom ?? this.isCustom,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (budgetType.present) {
      map['budget_type'] = Variable<String>(budgetType.value);
    }
    if (monthlyLimitPaise.present) {
      map['monthly_limit_paise'] = Variable<int>(monthlyLimitPaise.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('budgetType: $budgetType, ')
          ..write('monthlyLimitPaise: $monthlyLimitPaise, ')
          ..write('isCustom: $isCustom, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayeesTable extends Payees with TableInfo<$PayeesTable, Payee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _cleanedNameMeta = const VerificationMeta(
    'cleanedName',
  );
  @override
  late final GeneratedColumn<String> cleanedName = GeneratedColumn<String>(
    'cleaned_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keywordPatternsMeta = const VerificationMeta(
    'keywordPatterns',
  );
  @override
  late final GeneratedColumn<String> keywordPatterns = GeneratedColumn<String>(
    'keyword_patterns',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultCategoryIdMeta = const VerificationMeta(
    'defaultCategoryId',
  );
  @override
  late final GeneratedColumn<String> defaultCategoryId =
      GeneratedColumn<String>(
        'default_category_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories (id)',
        ),
      );
  static const VerificationMeta _defaultClassificationMeta =
      const VerificationMeta('defaultClassification');
  @override
  late final GeneratedColumn<String> defaultClassification =
      GeneratedColumn<String>(
        'default_classification',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _p2pPurposeMeta = const VerificationMeta(
    'p2pPurpose',
  );
  @override
  late final GeneratedColumn<String> p2pPurpose = GeneratedColumn<String>(
    'p2p_purpose',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    cleanedName,
    keywordPatterns,
    defaultCategoryId,
    defaultClassification,
    p2pPurpose,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cleaned_name')) {
      context.handle(
        _cleanedNameMeta,
        cleanedName.isAcceptableOrUnknown(
          data['cleaned_name']!,
          _cleanedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cleanedNameMeta);
    }
    if (data.containsKey('keyword_patterns')) {
      context.handle(
        _keywordPatternsMeta,
        keywordPatterns.isAcceptableOrUnknown(
          data['keyword_patterns']!,
          _keywordPatternsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_keywordPatternsMeta);
    }
    if (data.containsKey('default_category_id')) {
      context.handle(
        _defaultCategoryIdMeta,
        defaultCategoryId.isAcceptableOrUnknown(
          data['default_category_id']!,
          _defaultCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('default_classification')) {
      context.handle(
        _defaultClassificationMeta,
        defaultClassification.isAcceptableOrUnknown(
          data['default_classification']!,
          _defaultClassificationMeta,
        ),
      );
    }
    if (data.containsKey('p2p_purpose')) {
      context.handle(
        _p2pPurposeMeta,
        p2pPurpose.isAcceptableOrUnknown(data['p2p_purpose']!, _p2pPurposeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      cleanedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cleaned_name'],
      )!,
      keywordPatterns: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keyword_patterns'],
      )!,
      defaultCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_category_id'],
      ),
      defaultClassification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_classification'],
      ),
      p2pPurpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}p2p_purpose'],
      ),
    );
  }

  @override
  $PayeesTable createAlias(String alias) {
    return $PayeesTable(attachedDatabase, alias);
  }
}

class Payee extends DataClass implements Insertable<Payee> {
  final String id;
  final String name;
  final String cleanedName;
  final String keywordPatterns;
  final String? defaultCategoryId;
  final String? defaultClassification;
  final String? p2pPurpose;
  const Payee({
    required this.id,
    required this.name,
    required this.cleanedName,
    required this.keywordPatterns,
    this.defaultCategoryId,
    this.defaultClassification,
    this.p2pPurpose,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['cleaned_name'] = Variable<String>(cleanedName);
    map['keyword_patterns'] = Variable<String>(keywordPatterns);
    if (!nullToAbsent || defaultCategoryId != null) {
      map['default_category_id'] = Variable<String>(defaultCategoryId);
    }
    if (!nullToAbsent || defaultClassification != null) {
      map['default_classification'] = Variable<String>(defaultClassification);
    }
    if (!nullToAbsent || p2pPurpose != null) {
      map['p2p_purpose'] = Variable<String>(p2pPurpose);
    }
    return map;
  }

  PayeesCompanion toCompanion(bool nullToAbsent) {
    return PayeesCompanion(
      id: Value(id),
      name: Value(name),
      cleanedName: Value(cleanedName),
      keywordPatterns: Value(keywordPatterns),
      defaultCategoryId: defaultCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultCategoryId),
      defaultClassification: defaultClassification == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultClassification),
      p2pPurpose: p2pPurpose == null && nullToAbsent
          ? const Value.absent()
          : Value(p2pPurpose),
    );
  }

  factory Payee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payee(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      cleanedName: serializer.fromJson<String>(json['cleanedName']),
      keywordPatterns: serializer.fromJson<String>(json['keywordPatterns']),
      defaultCategoryId: serializer.fromJson<String?>(
        json['defaultCategoryId'],
      ),
      defaultClassification: serializer.fromJson<String?>(
        json['defaultClassification'],
      ),
      p2pPurpose: serializer.fromJson<String?>(json['p2pPurpose']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'cleanedName': serializer.toJson<String>(cleanedName),
      'keywordPatterns': serializer.toJson<String>(keywordPatterns),
      'defaultCategoryId': serializer.toJson<String?>(defaultCategoryId),
      'defaultClassification': serializer.toJson<String?>(
        defaultClassification,
      ),
      'p2pPurpose': serializer.toJson<String?>(p2pPurpose),
    };
  }

  Payee copyWith({
    String? id,
    String? name,
    String? cleanedName,
    String? keywordPatterns,
    Value<String?> defaultCategoryId = const Value.absent(),
    Value<String?> defaultClassification = const Value.absent(),
    Value<String?> p2pPurpose = const Value.absent(),
  }) => Payee(
    id: id ?? this.id,
    name: name ?? this.name,
    cleanedName: cleanedName ?? this.cleanedName,
    keywordPatterns: keywordPatterns ?? this.keywordPatterns,
    defaultCategoryId: defaultCategoryId.present
        ? defaultCategoryId.value
        : this.defaultCategoryId,
    defaultClassification: defaultClassification.present
        ? defaultClassification.value
        : this.defaultClassification,
    p2pPurpose: p2pPurpose.present ? p2pPurpose.value : this.p2pPurpose,
  );
  Payee copyWithCompanion(PayeesCompanion data) {
    return Payee(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      cleanedName: data.cleanedName.present
          ? data.cleanedName.value
          : this.cleanedName,
      keywordPatterns: data.keywordPatterns.present
          ? data.keywordPatterns.value
          : this.keywordPatterns,
      defaultCategoryId: data.defaultCategoryId.present
          ? data.defaultCategoryId.value
          : this.defaultCategoryId,
      defaultClassification: data.defaultClassification.present
          ? data.defaultClassification.value
          : this.defaultClassification,
      p2pPurpose: data.p2pPurpose.present
          ? data.p2pPurpose.value
          : this.p2pPurpose,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payee(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cleanedName: $cleanedName, ')
          ..write('keywordPatterns: $keywordPatterns, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultClassification: $defaultClassification, ')
          ..write('p2pPurpose: $p2pPurpose')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    cleanedName,
    keywordPatterns,
    defaultCategoryId,
    defaultClassification,
    p2pPurpose,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payee &&
          other.id == this.id &&
          other.name == this.name &&
          other.cleanedName == this.cleanedName &&
          other.keywordPatterns == this.keywordPatterns &&
          other.defaultCategoryId == this.defaultCategoryId &&
          other.defaultClassification == this.defaultClassification &&
          other.p2pPurpose == this.p2pPurpose);
}

class PayeesCompanion extends UpdateCompanion<Payee> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> cleanedName;
  final Value<String> keywordPatterns;
  final Value<String?> defaultCategoryId;
  final Value<String?> defaultClassification;
  final Value<String?> p2pPurpose;
  final Value<int> rowid;
  const PayeesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cleanedName = const Value.absent(),
    this.keywordPatterns = const Value.absent(),
    this.defaultCategoryId = const Value.absent(),
    this.defaultClassification = const Value.absent(),
    this.p2pPurpose = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayeesCompanion.insert({
    required String id,
    required String name,
    required String cleanedName,
    required String keywordPatterns,
    this.defaultCategoryId = const Value.absent(),
    this.defaultClassification = const Value.absent(),
    this.p2pPurpose = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       cleanedName = Value(cleanedName),
       keywordPatterns = Value(keywordPatterns);
  static Insertable<Payee> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? cleanedName,
    Expression<String>? keywordPatterns,
    Expression<String>? defaultCategoryId,
    Expression<String>? defaultClassification,
    Expression<String>? p2pPurpose,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (cleanedName != null) 'cleaned_name': cleanedName,
      if (keywordPatterns != null) 'keyword_patterns': keywordPatterns,
      if (defaultCategoryId != null) 'default_category_id': defaultCategoryId,
      if (defaultClassification != null)
        'default_classification': defaultClassification,
      if (p2pPurpose != null) 'p2p_purpose': p2pPurpose,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayeesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? cleanedName,
    Value<String>? keywordPatterns,
    Value<String?>? defaultCategoryId,
    Value<String?>? defaultClassification,
    Value<String?>? p2pPurpose,
    Value<int>? rowid,
  }) {
    return PayeesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cleanedName: cleanedName ?? this.cleanedName,
      keywordPatterns: keywordPatterns ?? this.keywordPatterns,
      defaultCategoryId: defaultCategoryId ?? this.defaultCategoryId,
      defaultClassification:
          defaultClassification ?? this.defaultClassification,
      p2pPurpose: p2pPurpose ?? this.p2pPurpose,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cleanedName.present) {
      map['cleaned_name'] = Variable<String>(cleanedName.value);
    }
    if (keywordPatterns.present) {
      map['keyword_patterns'] = Variable<String>(keywordPatterns.value);
    }
    if (defaultCategoryId.present) {
      map['default_category_id'] = Variable<String>(defaultCategoryId.value);
    }
    if (defaultClassification.present) {
      map['default_classification'] = Variable<String>(
        defaultClassification.value,
      );
    }
    if (p2pPurpose.present) {
      map['p2p_purpose'] = Variable<String>(p2pPurpose.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayeesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cleanedName: $cleanedName, ')
          ..write('keywordPatterns: $keywordPatterns, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultClassification: $defaultClassification, ')
          ..write('p2pPurpose: $p2pPurpose, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _cycleIdMeta = const VerificationMeta(
    'cycleId',
  );
  @override
  late final GeneratedColumn<String> cycleId = GeneratedColumn<String>(
    'cycle_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cycles (id)',
    ),
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _txnTypeMeta = const VerificationMeta(
    'txnType',
  );
  @override
  late final GeneratedColumn<String> txnType = GeneratedColumn<String>(
    'txn_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classificationMeta = const VerificationMeta(
    'classification',
  );
  @override
  late final GeneratedColumn<String> classification = GeneratedColumn<String>(
    'classification',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('need'),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _payeeIdMeta = const VerificationMeta(
    'payeeId',
  );
  @override
  late final GeneratedColumn<String> payeeId = GeneratedColumn<String>(
    'payee_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payees (id)',
    ),
  );
  static const VerificationMeta _payeeNameMeta = const VerificationMeta(
    'payeeName',
  );
  @override
  late final GeneratedColumn<String> payeeName = GeneratedColumn<String>(
    'payee_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceAfterPaiseMeta = const VerificationMeta(
    'balanceAfterPaise',
  );
  @override
  late final GeneratedColumn<int> balanceAfterPaise = GeneratedColumn<int>(
    'balance_after_paise',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawSmsBodyMeta = const VerificationMeta(
    'rawSmsBody',
  );
  @override
  late final GeneratedColumn<String> rawSmsBody = GeneratedColumn<String>(
    'raw_sms_body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dedupeHashMeta = const VerificationMeta(
    'dedupeHash',
  );
  @override
  late final GeneratedColumn<String> dedupeHash = GeneratedColumn<String>(
    'dedupe_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _upiRefMeta = const VerificationMeta('upiRef');
  @override
  late final GeneratedColumn<String> upiRef = GeneratedColumn<String>(
    'upi_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFlaggedMeta = const VerificationMeta(
    'isFlagged',
  );
  @override
  late final GeneratedColumn<bool> isFlagged = GeneratedColumn<bool>(
    'is_flagged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_flagged" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _flagReasonMeta = const VerificationMeta(
    'flagReason',
  );
  @override
  late final GeneratedColumn<String> flagReason = GeneratedColumn<String>(
    'flag_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagStatusMeta = const VerificationMeta(
    'tagStatus',
  );
  @override
  late final GeneratedColumn<String> tagStatus = GeneratedColumn<String>(
    'tag_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('untagged'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    cycleId,
    amountPaise,
    txnType,
    classification,
    categoryId,
    payeeId,
    payeeName,
    balanceAfterPaise,
    timestamp,
    receivedAt,
    rawSmsBody,
    dedupeHash,
    upiRef,
    isFlagged,
    flagReason,
    tagStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('cycle_id')) {
      context.handle(
        _cycleIdMeta,
        cycleId.isAcceptableOrUnknown(data['cycle_id']!, _cycleIdMeta),
      );
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('txn_type')) {
      context.handle(
        _txnTypeMeta,
        txnType.isAcceptableOrUnknown(data['txn_type']!, _txnTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_txnTypeMeta);
    }
    if (data.containsKey('classification')) {
      context.handle(
        _classificationMeta,
        classification.isAcceptableOrUnknown(
          data['classification']!,
          _classificationMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('payee_id')) {
      context.handle(
        _payeeIdMeta,
        payeeId.isAcceptableOrUnknown(data['payee_id']!, _payeeIdMeta),
      );
    }
    if (data.containsKey('payee_name')) {
      context.handle(
        _payeeNameMeta,
        payeeName.isAcceptableOrUnknown(data['payee_name']!, _payeeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_payeeNameMeta);
    }
    if (data.containsKey('balance_after_paise')) {
      context.handle(
        _balanceAfterPaiseMeta,
        balanceAfterPaise.isAcceptableOrUnknown(
          data['balance_after_paise']!,
          _balanceAfterPaiseMeta,
        ),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('raw_sms_body')) {
      context.handle(
        _rawSmsBodyMeta,
        rawSmsBody.isAcceptableOrUnknown(
          data['raw_sms_body']!,
          _rawSmsBodyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rawSmsBodyMeta);
    }
    if (data.containsKey('dedupe_hash')) {
      context.handle(
        _dedupeHashMeta,
        dedupeHash.isAcceptableOrUnknown(data['dedupe_hash']!, _dedupeHashMeta),
      );
    } else if (isInserting) {
      context.missing(_dedupeHashMeta);
    }
    if (data.containsKey('upi_ref')) {
      context.handle(
        _upiRefMeta,
        upiRef.isAcceptableOrUnknown(data['upi_ref']!, _upiRefMeta),
      );
    }
    if (data.containsKey('is_flagged')) {
      context.handle(
        _isFlaggedMeta,
        isFlagged.isAcceptableOrUnknown(data['is_flagged']!, _isFlaggedMeta),
      );
    }
    if (data.containsKey('flag_reason')) {
      context.handle(
        _flagReasonMeta,
        flagReason.isAcceptableOrUnknown(data['flag_reason']!, _flagReasonMeta),
      );
    }
    if (data.containsKey('tag_status')) {
      context.handle(
        _tagStatusMeta,
        tagStatus.isAcceptableOrUnknown(data['tag_status']!, _tagStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      cycleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cycle_id'],
      ),
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
      txnType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}txn_type'],
      )!,
      classification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}classification'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      payeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payee_id'],
      ),
      payeeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payee_name'],
      )!,
      balanceAfterPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_after_paise'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      rawSmsBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_sms_body'],
      )!,
      dedupeHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dedupe_hash'],
      )!,
      upiRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upi_ref'],
      ),
      isFlagged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_flagged'],
      )!,
      flagReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_reason'],
      ),
      tagStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_status'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;
  final String accountId;
  final String? cycleId;
  final int amountPaise;
  final String txnType;
  final String classification;
  final String? categoryId;
  final String? payeeId;
  final String payeeName;
  final int? balanceAfterPaise;
  final DateTime timestamp;
  final DateTime receivedAt;
  final String rawSmsBody;
  final String dedupeHash;
  final String? upiRef;
  final bool isFlagged;
  final String? flagReason;
  final String tagStatus;
  const Transaction({
    required this.id,
    required this.accountId,
    this.cycleId,
    required this.amountPaise,
    required this.txnType,
    required this.classification,
    this.categoryId,
    this.payeeId,
    required this.payeeName,
    this.balanceAfterPaise,
    required this.timestamp,
    required this.receivedAt,
    required this.rawSmsBody,
    required this.dedupeHash,
    this.upiRef,
    required this.isFlagged,
    this.flagReason,
    required this.tagStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || cycleId != null) {
      map['cycle_id'] = Variable<String>(cycleId);
    }
    map['amount_paise'] = Variable<int>(amountPaise);
    map['txn_type'] = Variable<String>(txnType);
    map['classification'] = Variable<String>(classification);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || payeeId != null) {
      map['payee_id'] = Variable<String>(payeeId);
    }
    map['payee_name'] = Variable<String>(payeeName);
    if (!nullToAbsent || balanceAfterPaise != null) {
      map['balance_after_paise'] = Variable<int>(balanceAfterPaise);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['raw_sms_body'] = Variable<String>(rawSmsBody);
    map['dedupe_hash'] = Variable<String>(dedupeHash);
    if (!nullToAbsent || upiRef != null) {
      map['upi_ref'] = Variable<String>(upiRef);
    }
    map['is_flagged'] = Variable<bool>(isFlagged);
    if (!nullToAbsent || flagReason != null) {
      map['flag_reason'] = Variable<String>(flagReason);
    }
    map['tag_status'] = Variable<String>(tagStatus);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      cycleId: cycleId == null && nullToAbsent
          ? const Value.absent()
          : Value(cycleId),
      amountPaise: Value(amountPaise),
      txnType: Value(txnType),
      classification: Value(classification),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      payeeId: payeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(payeeId),
      payeeName: Value(payeeName),
      balanceAfterPaise: balanceAfterPaise == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceAfterPaise),
      timestamp: Value(timestamp),
      receivedAt: Value(receivedAt),
      rawSmsBody: Value(rawSmsBody),
      dedupeHash: Value(dedupeHash),
      upiRef: upiRef == null && nullToAbsent
          ? const Value.absent()
          : Value(upiRef),
      isFlagged: Value(isFlagged),
      flagReason: flagReason == null && nullToAbsent
          ? const Value.absent()
          : Value(flagReason),
      tagStatus: Value(tagStatus),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      cycleId: serializer.fromJson<String?>(json['cycleId']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      txnType: serializer.fromJson<String>(json['txnType']),
      classification: serializer.fromJson<String>(json['classification']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      payeeId: serializer.fromJson<String?>(json['payeeId']),
      payeeName: serializer.fromJson<String>(json['payeeName']),
      balanceAfterPaise: serializer.fromJson<int?>(json['balanceAfterPaise']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      rawSmsBody: serializer.fromJson<String>(json['rawSmsBody']),
      dedupeHash: serializer.fromJson<String>(json['dedupeHash']),
      upiRef: serializer.fromJson<String?>(json['upiRef']),
      isFlagged: serializer.fromJson<bool>(json['isFlagged']),
      flagReason: serializer.fromJson<String?>(json['flagReason']),
      tagStatus: serializer.fromJson<String>(json['tagStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'cycleId': serializer.toJson<String?>(cycleId),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'txnType': serializer.toJson<String>(txnType),
      'classification': serializer.toJson<String>(classification),
      'categoryId': serializer.toJson<String?>(categoryId),
      'payeeId': serializer.toJson<String?>(payeeId),
      'payeeName': serializer.toJson<String>(payeeName),
      'balanceAfterPaise': serializer.toJson<int?>(balanceAfterPaise),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'rawSmsBody': serializer.toJson<String>(rawSmsBody),
      'dedupeHash': serializer.toJson<String>(dedupeHash),
      'upiRef': serializer.toJson<String?>(upiRef),
      'isFlagged': serializer.toJson<bool>(isFlagged),
      'flagReason': serializer.toJson<String?>(flagReason),
      'tagStatus': serializer.toJson<String>(tagStatus),
    };
  }

  Transaction copyWith({
    String? id,
    String? accountId,
    Value<String?> cycleId = const Value.absent(),
    int? amountPaise,
    String? txnType,
    String? classification,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> payeeId = const Value.absent(),
    String? payeeName,
    Value<int?> balanceAfterPaise = const Value.absent(),
    DateTime? timestamp,
    DateTime? receivedAt,
    String? rawSmsBody,
    String? dedupeHash,
    Value<String?> upiRef = const Value.absent(),
    bool? isFlagged,
    Value<String?> flagReason = const Value.absent(),
    String? tagStatus,
  }) => Transaction(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    cycleId: cycleId.present ? cycleId.value : this.cycleId,
    amountPaise: amountPaise ?? this.amountPaise,
    txnType: txnType ?? this.txnType,
    classification: classification ?? this.classification,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    payeeId: payeeId.present ? payeeId.value : this.payeeId,
    payeeName: payeeName ?? this.payeeName,
    balanceAfterPaise: balanceAfterPaise.present
        ? balanceAfterPaise.value
        : this.balanceAfterPaise,
    timestamp: timestamp ?? this.timestamp,
    receivedAt: receivedAt ?? this.receivedAt,
    rawSmsBody: rawSmsBody ?? this.rawSmsBody,
    dedupeHash: dedupeHash ?? this.dedupeHash,
    upiRef: upiRef.present ? upiRef.value : this.upiRef,
    isFlagged: isFlagged ?? this.isFlagged,
    flagReason: flagReason.present ? flagReason.value : this.flagReason,
    tagStatus: tagStatus ?? this.tagStatus,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      cycleId: data.cycleId.present ? data.cycleId.value : this.cycleId,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
      txnType: data.txnType.present ? data.txnType.value : this.txnType,
      classification: data.classification.present
          ? data.classification.value
          : this.classification,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      payeeId: data.payeeId.present ? data.payeeId.value : this.payeeId,
      payeeName: data.payeeName.present ? data.payeeName.value : this.payeeName,
      balanceAfterPaise: data.balanceAfterPaise.present
          ? data.balanceAfterPaise.value
          : this.balanceAfterPaise,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      rawSmsBody: data.rawSmsBody.present
          ? data.rawSmsBody.value
          : this.rawSmsBody,
      dedupeHash: data.dedupeHash.present
          ? data.dedupeHash.value
          : this.dedupeHash,
      upiRef: data.upiRef.present ? data.upiRef.value : this.upiRef,
      isFlagged: data.isFlagged.present ? data.isFlagged.value : this.isFlagged,
      flagReason: data.flagReason.present
          ? data.flagReason.value
          : this.flagReason,
      tagStatus: data.tagStatus.present ? data.tagStatus.value : this.tagStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('cycleId: $cycleId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('txnType: $txnType, ')
          ..write('classification: $classification, ')
          ..write('categoryId: $categoryId, ')
          ..write('payeeId: $payeeId, ')
          ..write('payeeName: $payeeName, ')
          ..write('balanceAfterPaise: $balanceAfterPaise, ')
          ..write('timestamp: $timestamp, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('rawSmsBody: $rawSmsBody, ')
          ..write('dedupeHash: $dedupeHash, ')
          ..write('upiRef: $upiRef, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('flagReason: $flagReason, ')
          ..write('tagStatus: $tagStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    cycleId,
    amountPaise,
    txnType,
    classification,
    categoryId,
    payeeId,
    payeeName,
    balanceAfterPaise,
    timestamp,
    receivedAt,
    rawSmsBody,
    dedupeHash,
    upiRef,
    isFlagged,
    flagReason,
    tagStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.cycleId == this.cycleId &&
          other.amountPaise == this.amountPaise &&
          other.txnType == this.txnType &&
          other.classification == this.classification &&
          other.categoryId == this.categoryId &&
          other.payeeId == this.payeeId &&
          other.payeeName == this.payeeName &&
          other.balanceAfterPaise == this.balanceAfterPaise &&
          other.timestamp == this.timestamp &&
          other.receivedAt == this.receivedAt &&
          other.rawSmsBody == this.rawSmsBody &&
          other.dedupeHash == this.dedupeHash &&
          other.upiRef == this.upiRef &&
          other.isFlagged == this.isFlagged &&
          other.flagReason == this.flagReason &&
          other.tagStatus == this.tagStatus);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String?> cycleId;
  final Value<int> amountPaise;
  final Value<String> txnType;
  final Value<String> classification;
  final Value<String?> categoryId;
  final Value<String?> payeeId;
  final Value<String> payeeName;
  final Value<int?> balanceAfterPaise;
  final Value<DateTime> timestamp;
  final Value<DateTime> receivedAt;
  final Value<String> rawSmsBody;
  final Value<String> dedupeHash;
  final Value<String?> upiRef;
  final Value<bool> isFlagged;
  final Value<String?> flagReason;
  final Value<String> tagStatus;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.cycleId = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.txnType = const Value.absent(),
    this.classification = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.payeeId = const Value.absent(),
    this.payeeName = const Value.absent(),
    this.balanceAfterPaise = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.rawSmsBody = const Value.absent(),
    this.dedupeHash = const Value.absent(),
    this.upiRef = const Value.absent(),
    this.isFlagged = const Value.absent(),
    this.flagReason = const Value.absent(),
    this.tagStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String accountId,
    this.cycleId = const Value.absent(),
    required int amountPaise,
    required String txnType,
    this.classification = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.payeeId = const Value.absent(),
    required String payeeName,
    this.balanceAfterPaise = const Value.absent(),
    required DateTime timestamp,
    required DateTime receivedAt,
    required String rawSmsBody,
    required String dedupeHash,
    this.upiRef = const Value.absent(),
    this.isFlagged = const Value.absent(),
    this.flagReason = const Value.absent(),
    this.tagStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       amountPaise = Value(amountPaise),
       txnType = Value(txnType),
       payeeName = Value(payeeName),
       timestamp = Value(timestamp),
       receivedAt = Value(receivedAt),
       rawSmsBody = Value(rawSmsBody),
       dedupeHash = Value(dedupeHash);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? cycleId,
    Expression<int>? amountPaise,
    Expression<String>? txnType,
    Expression<String>? classification,
    Expression<String>? categoryId,
    Expression<String>? payeeId,
    Expression<String>? payeeName,
    Expression<int>? balanceAfterPaise,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? receivedAt,
    Expression<String>? rawSmsBody,
    Expression<String>? dedupeHash,
    Expression<String>? upiRef,
    Expression<bool>? isFlagged,
    Expression<String>? flagReason,
    Expression<String>? tagStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (cycleId != null) 'cycle_id': cycleId,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (txnType != null) 'txn_type': txnType,
      if (classification != null) 'classification': classification,
      if (categoryId != null) 'category_id': categoryId,
      if (payeeId != null) 'payee_id': payeeId,
      if (payeeName != null) 'payee_name': payeeName,
      if (balanceAfterPaise != null) 'balance_after_paise': balanceAfterPaise,
      if (timestamp != null) 'timestamp': timestamp,
      if (receivedAt != null) 'received_at': receivedAt,
      if (rawSmsBody != null) 'raw_sms_body': rawSmsBody,
      if (dedupeHash != null) 'dedupe_hash': dedupeHash,
      if (upiRef != null) 'upi_ref': upiRef,
      if (isFlagged != null) 'is_flagged': isFlagged,
      if (flagReason != null) 'flag_reason': flagReason,
      if (tagStatus != null) 'tag_status': tagStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String?>? cycleId,
    Value<int>? amountPaise,
    Value<String>? txnType,
    Value<String>? classification,
    Value<String?>? categoryId,
    Value<String?>? payeeId,
    Value<String>? payeeName,
    Value<int?>? balanceAfterPaise,
    Value<DateTime>? timestamp,
    Value<DateTime>? receivedAt,
    Value<String>? rawSmsBody,
    Value<String>? dedupeHash,
    Value<String?>? upiRef,
    Value<bool>? isFlagged,
    Value<String?>? flagReason,
    Value<String>? tagStatus,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      cycleId: cycleId ?? this.cycleId,
      amountPaise: amountPaise ?? this.amountPaise,
      txnType: txnType ?? this.txnType,
      classification: classification ?? this.classification,
      categoryId: categoryId ?? this.categoryId,
      payeeId: payeeId ?? this.payeeId,
      payeeName: payeeName ?? this.payeeName,
      balanceAfterPaise: balanceAfterPaise ?? this.balanceAfterPaise,
      timestamp: timestamp ?? this.timestamp,
      receivedAt: receivedAt ?? this.receivedAt,
      rawSmsBody: rawSmsBody ?? this.rawSmsBody,
      dedupeHash: dedupeHash ?? this.dedupeHash,
      upiRef: upiRef ?? this.upiRef,
      isFlagged: isFlagged ?? this.isFlagged,
      flagReason: flagReason ?? this.flagReason,
      tagStatus: tagStatus ?? this.tagStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (cycleId.present) {
      map['cycle_id'] = Variable<String>(cycleId.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (txnType.present) {
      map['txn_type'] = Variable<String>(txnType.value);
    }
    if (classification.present) {
      map['classification'] = Variable<String>(classification.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (payeeId.present) {
      map['payee_id'] = Variable<String>(payeeId.value);
    }
    if (payeeName.present) {
      map['payee_name'] = Variable<String>(payeeName.value);
    }
    if (balanceAfterPaise.present) {
      map['balance_after_paise'] = Variable<int>(balanceAfterPaise.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (rawSmsBody.present) {
      map['raw_sms_body'] = Variable<String>(rawSmsBody.value);
    }
    if (dedupeHash.present) {
      map['dedupe_hash'] = Variable<String>(dedupeHash.value);
    }
    if (upiRef.present) {
      map['upi_ref'] = Variable<String>(upiRef.value);
    }
    if (isFlagged.present) {
      map['is_flagged'] = Variable<bool>(isFlagged.value);
    }
    if (flagReason.present) {
      map['flag_reason'] = Variable<String>(flagReason.value);
    }
    if (tagStatus.present) {
      map['tag_status'] = Variable<String>(tagStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('cycleId: $cycleId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('txnType: $txnType, ')
          ..write('classification: $classification, ')
          ..write('categoryId: $categoryId, ')
          ..write('payeeId: $payeeId, ')
          ..write('payeeName: $payeeName, ')
          ..write('balanceAfterPaise: $balanceAfterPaise, ')
          ..write('timestamp: $timestamp, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('rawSmsBody: $rawSmsBody, ')
          ..write('dedupeHash: $dedupeHash, ')
          ..write('upiRef: $upiRef, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('flagReason: $flagReason, ')
          ..write('tagStatus: $tagStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringRulesTable extends RecurringRules
    with TableInfo<$RecurringRulesTable, RecurringRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payeeIdMeta = const VerificationMeta(
    'payeeId',
  );
  @override
  late final GeneratedColumn<String> payeeId = GeneratedColumn<String>(
    'payee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payees (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _medianAmountPaiseMeta = const VerificationMeta(
    'medianAmountPaise',
  );
  @override
  late final GeneratedColumn<int> medianAmountPaise = GeneratedColumn<int>(
    'median_amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toleranceTypeMeta = const VerificationMeta(
    'toleranceType',
  );
  @override
  late final GeneratedColumn<String> toleranceType = GeneratedColumn<String>(
    'tolerance_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cadenceDaysMeta = const VerificationMeta(
    'cadenceDays',
  );
  @override
  late final GeneratedColumn<int> cadenceDays = GeneratedColumn<int>(
    'cadence_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDayOfMonthMeta = const VerificationMeta(
    'dueDayOfMonth',
  );
  @override
  late final GeneratedColumn<int> dueDayOfMonth = GeneratedColumn<int>(
    'due_day_of_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastDebitedDateMeta = const VerificationMeta(
    'lastDebitedDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastDebitedDate =
      GeneratedColumn<DateTime>(
        'last_debited_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    payeeId,
    accountId,
    medianAmountPaise,
    toleranceType,
    cadenceDays,
    status,
    dueDayOfMonth,
    lastDebitedDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payee_id')) {
      context.handle(
        _payeeIdMeta,
        payeeId.isAcceptableOrUnknown(data['payee_id']!, _payeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_payeeIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('median_amount_paise')) {
      context.handle(
        _medianAmountPaiseMeta,
        medianAmountPaise.isAcceptableOrUnknown(
          data['median_amount_paise']!,
          _medianAmountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medianAmountPaiseMeta);
    }
    if (data.containsKey('tolerance_type')) {
      context.handle(
        _toleranceTypeMeta,
        toleranceType.isAcceptableOrUnknown(
          data['tolerance_type']!,
          _toleranceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toleranceTypeMeta);
    }
    if (data.containsKey('cadence_days')) {
      context.handle(
        _cadenceDaysMeta,
        cadenceDays.isAcceptableOrUnknown(
          data['cadence_days']!,
          _cadenceDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cadenceDaysMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('due_day_of_month')) {
      context.handle(
        _dueDayOfMonthMeta,
        dueDayOfMonth.isAcceptableOrUnknown(
          data['due_day_of_month']!,
          _dueDayOfMonthMeta,
        ),
      );
    }
    if (data.containsKey('last_debited_date')) {
      context.handle(
        _lastDebitedDateMeta,
        lastDebitedDate.isAcceptableOrUnknown(
          data['last_debited_date']!,
          _lastDebitedDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      payeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payee_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      medianAmountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}median_amount_paise'],
      )!,
      toleranceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tolerance_type'],
      )!,
      cadenceDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cadence_days'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dueDayOfMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day_of_month'],
      ),
      lastDebitedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_debited_date'],
      ),
    );
  }

  @override
  $RecurringRulesTable createAlias(String alias) {
    return $RecurringRulesTable(attachedDatabase, alias);
  }
}

class RecurringRule extends DataClass implements Insertable<RecurringRule> {
  final String id;
  final String payeeId;
  final String accountId;
  final int medianAmountPaise;
  final String toleranceType;
  final int cadenceDays;
  final String status;
  final int? dueDayOfMonth;
  final DateTime? lastDebitedDate;
  const RecurringRule({
    required this.id,
    required this.payeeId,
    required this.accountId,
    required this.medianAmountPaise,
    required this.toleranceType,
    required this.cadenceDays,
    required this.status,
    this.dueDayOfMonth,
    this.lastDebitedDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payee_id'] = Variable<String>(payeeId);
    map['account_id'] = Variable<String>(accountId);
    map['median_amount_paise'] = Variable<int>(medianAmountPaise);
    map['tolerance_type'] = Variable<String>(toleranceType);
    map['cadence_days'] = Variable<int>(cadenceDays);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dueDayOfMonth != null) {
      map['due_day_of_month'] = Variable<int>(dueDayOfMonth);
    }
    if (!nullToAbsent || lastDebitedDate != null) {
      map['last_debited_date'] = Variable<DateTime>(lastDebitedDate);
    }
    return map;
  }

  RecurringRulesCompanion toCompanion(bool nullToAbsent) {
    return RecurringRulesCompanion(
      id: Value(id),
      payeeId: Value(payeeId),
      accountId: Value(accountId),
      medianAmountPaise: Value(medianAmountPaise),
      toleranceType: Value(toleranceType),
      cadenceDays: Value(cadenceDays),
      status: Value(status),
      dueDayOfMonth: dueDayOfMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDayOfMonth),
      lastDebitedDate: lastDebitedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDebitedDate),
    );
  }

  factory RecurringRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringRule(
      id: serializer.fromJson<String>(json['id']),
      payeeId: serializer.fromJson<String>(json['payeeId']),
      accountId: serializer.fromJson<String>(json['accountId']),
      medianAmountPaise: serializer.fromJson<int>(json['medianAmountPaise']),
      toleranceType: serializer.fromJson<String>(json['toleranceType']),
      cadenceDays: serializer.fromJson<int>(json['cadenceDays']),
      status: serializer.fromJson<String>(json['status']),
      dueDayOfMonth: serializer.fromJson<int?>(json['dueDayOfMonth']),
      lastDebitedDate: serializer.fromJson<DateTime?>(json['lastDebitedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'payeeId': serializer.toJson<String>(payeeId),
      'accountId': serializer.toJson<String>(accountId),
      'medianAmountPaise': serializer.toJson<int>(medianAmountPaise),
      'toleranceType': serializer.toJson<String>(toleranceType),
      'cadenceDays': serializer.toJson<int>(cadenceDays),
      'status': serializer.toJson<String>(status),
      'dueDayOfMonth': serializer.toJson<int?>(dueDayOfMonth),
      'lastDebitedDate': serializer.toJson<DateTime?>(lastDebitedDate),
    };
  }

  RecurringRule copyWith({
    String? id,
    String? payeeId,
    String? accountId,
    int? medianAmountPaise,
    String? toleranceType,
    int? cadenceDays,
    String? status,
    Value<int?> dueDayOfMonth = const Value.absent(),
    Value<DateTime?> lastDebitedDate = const Value.absent(),
  }) => RecurringRule(
    id: id ?? this.id,
    payeeId: payeeId ?? this.payeeId,
    accountId: accountId ?? this.accountId,
    medianAmountPaise: medianAmountPaise ?? this.medianAmountPaise,
    toleranceType: toleranceType ?? this.toleranceType,
    cadenceDays: cadenceDays ?? this.cadenceDays,
    status: status ?? this.status,
    dueDayOfMonth: dueDayOfMonth.present
        ? dueDayOfMonth.value
        : this.dueDayOfMonth,
    lastDebitedDate: lastDebitedDate.present
        ? lastDebitedDate.value
        : this.lastDebitedDate,
  );
  RecurringRule copyWithCompanion(RecurringRulesCompanion data) {
    return RecurringRule(
      id: data.id.present ? data.id.value : this.id,
      payeeId: data.payeeId.present ? data.payeeId.value : this.payeeId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      medianAmountPaise: data.medianAmountPaise.present
          ? data.medianAmountPaise.value
          : this.medianAmountPaise,
      toleranceType: data.toleranceType.present
          ? data.toleranceType.value
          : this.toleranceType,
      cadenceDays: data.cadenceDays.present
          ? data.cadenceDays.value
          : this.cadenceDays,
      status: data.status.present ? data.status.value : this.status,
      dueDayOfMonth: data.dueDayOfMonth.present
          ? data.dueDayOfMonth.value
          : this.dueDayOfMonth,
      lastDebitedDate: data.lastDebitedDate.present
          ? data.lastDebitedDate.value
          : this.lastDebitedDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringRule(')
          ..write('id: $id, ')
          ..write('payeeId: $payeeId, ')
          ..write('accountId: $accountId, ')
          ..write('medianAmountPaise: $medianAmountPaise, ')
          ..write('toleranceType: $toleranceType, ')
          ..write('cadenceDays: $cadenceDays, ')
          ..write('status: $status, ')
          ..write('dueDayOfMonth: $dueDayOfMonth, ')
          ..write('lastDebitedDate: $lastDebitedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    payeeId,
    accountId,
    medianAmountPaise,
    toleranceType,
    cadenceDays,
    status,
    dueDayOfMonth,
    lastDebitedDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringRule &&
          other.id == this.id &&
          other.payeeId == this.payeeId &&
          other.accountId == this.accountId &&
          other.medianAmountPaise == this.medianAmountPaise &&
          other.toleranceType == this.toleranceType &&
          other.cadenceDays == this.cadenceDays &&
          other.status == this.status &&
          other.dueDayOfMonth == this.dueDayOfMonth &&
          other.lastDebitedDate == this.lastDebitedDate);
}

class RecurringRulesCompanion extends UpdateCompanion<RecurringRule> {
  final Value<String> id;
  final Value<String> payeeId;
  final Value<String> accountId;
  final Value<int> medianAmountPaise;
  final Value<String> toleranceType;
  final Value<int> cadenceDays;
  final Value<String> status;
  final Value<int?> dueDayOfMonth;
  final Value<DateTime?> lastDebitedDate;
  final Value<int> rowid;
  const RecurringRulesCompanion({
    this.id = const Value.absent(),
    this.payeeId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.medianAmountPaise = const Value.absent(),
    this.toleranceType = const Value.absent(),
    this.cadenceDays = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDayOfMonth = const Value.absent(),
    this.lastDebitedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringRulesCompanion.insert({
    required String id,
    required String payeeId,
    required String accountId,
    required int medianAmountPaise,
    required String toleranceType,
    required int cadenceDays,
    required String status,
    this.dueDayOfMonth = const Value.absent(),
    this.lastDebitedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       payeeId = Value(payeeId),
       accountId = Value(accountId),
       medianAmountPaise = Value(medianAmountPaise),
       toleranceType = Value(toleranceType),
       cadenceDays = Value(cadenceDays),
       status = Value(status);
  static Insertable<RecurringRule> custom({
    Expression<String>? id,
    Expression<String>? payeeId,
    Expression<String>? accountId,
    Expression<int>? medianAmountPaise,
    Expression<String>? toleranceType,
    Expression<int>? cadenceDays,
    Expression<String>? status,
    Expression<int>? dueDayOfMonth,
    Expression<DateTime>? lastDebitedDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payeeId != null) 'payee_id': payeeId,
      if (accountId != null) 'account_id': accountId,
      if (medianAmountPaise != null) 'median_amount_paise': medianAmountPaise,
      if (toleranceType != null) 'tolerance_type': toleranceType,
      if (cadenceDays != null) 'cadence_days': cadenceDays,
      if (status != null) 'status': status,
      if (dueDayOfMonth != null) 'due_day_of_month': dueDayOfMonth,
      if (lastDebitedDate != null) 'last_debited_date': lastDebitedDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? payeeId,
    Value<String>? accountId,
    Value<int>? medianAmountPaise,
    Value<String>? toleranceType,
    Value<int>? cadenceDays,
    Value<String>? status,
    Value<int?>? dueDayOfMonth,
    Value<DateTime?>? lastDebitedDate,
    Value<int>? rowid,
  }) {
    return RecurringRulesCompanion(
      id: id ?? this.id,
      payeeId: payeeId ?? this.payeeId,
      accountId: accountId ?? this.accountId,
      medianAmountPaise: medianAmountPaise ?? this.medianAmountPaise,
      toleranceType: toleranceType ?? this.toleranceType,
      cadenceDays: cadenceDays ?? this.cadenceDays,
      status: status ?? this.status,
      dueDayOfMonth: dueDayOfMonth ?? this.dueDayOfMonth,
      lastDebitedDate: lastDebitedDate ?? this.lastDebitedDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (payeeId.present) {
      map['payee_id'] = Variable<String>(payeeId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (medianAmountPaise.present) {
      map['median_amount_paise'] = Variable<int>(medianAmountPaise.value);
    }
    if (toleranceType.present) {
      map['tolerance_type'] = Variable<String>(toleranceType.value);
    }
    if (cadenceDays.present) {
      map['cadence_days'] = Variable<int>(cadenceDays.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dueDayOfMonth.present) {
      map['due_day_of_month'] = Variable<int>(dueDayOfMonth.value);
    }
    if (lastDebitedDate.present) {
      map['last_debited_date'] = Variable<DateTime>(lastDebitedDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringRulesCompanion(')
          ..write('id: $id, ')
          ..write('payeeId: $payeeId, ')
          ..write('accountId: $accountId, ')
          ..write('medianAmountPaise: $medianAmountPaise, ')
          ..write('toleranceType: $toleranceType, ')
          ..write('cadenceDays: $cadenceDays, ')
          ..write('status: $status, ')
          ..write('dueDayOfMonth: $dueDayOfMonth, ')
          ..write('lastDebitedDate: $lastDebitedDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _targetPaiseMeta = const VerificationMeta(
    'targetPaise',
  );
  @override
  late final GeneratedColumn<int> targetPaise = GeneratedColumn<int>(
    'target_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedPaiseMeta = const VerificationMeta(
    'savedPaise',
  );
  @override
  late final GeneratedColumn<int> savedPaise = GeneratedColumn<int>(
    'saved_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _priorityOrderMeta = const VerificationMeta(
    'priorityOrder',
  );
  @override
  late final GeneratedColumn<int> priorityOrder = GeneratedColumn<int>(
    'priority_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isPausedMeta = const VerificationMeta(
    'isPaused',
  );
  @override
  late final GeneratedColumn<bool> isPaused = GeneratedColumn<bool>(
    'is_paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paused" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    targetPaise,
    savedPaise,
    priorityOrder,
    isActive,
    isPaused,
    targetDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_paise')) {
      context.handle(
        _targetPaiseMeta,
        targetPaise.isAcceptableOrUnknown(
          data['target_paise']!,
          _targetPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetPaiseMeta);
    }
    if (data.containsKey('saved_paise')) {
      context.handle(
        _savedPaiseMeta,
        savedPaise.isAcceptableOrUnknown(data['saved_paise']!, _savedPaiseMeta),
      );
    }
    if (data.containsKey('priority_order')) {
      context.handle(
        _priorityOrderMeta,
        priorityOrder.isAcceptableOrUnknown(
          data['priority_order']!,
          _priorityOrderMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_paused')) {
      context.handle(
        _isPausedMeta,
        isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      targetPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_paise'],
      )!,
      savedPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saved_paise'],
      )!,
      priorityOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_order'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isPaused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paused'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final String title;
  final int targetPaise;
  final int savedPaise;
  final int priorityOrder;
  final bool isActive;
  final bool isPaused;
  final DateTime? targetDate;
  final DateTime createdAt;
  const Goal({
    required this.id,
    required this.title,
    required this.targetPaise,
    required this.savedPaise,
    required this.priorityOrder,
    required this.isActive,
    required this.isPaused,
    this.targetDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['target_paise'] = Variable<int>(targetPaise);
    map['saved_paise'] = Variable<int>(savedPaise);
    map['priority_order'] = Variable<int>(priorityOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['is_paused'] = Variable<bool>(isPaused);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      targetPaise: Value(targetPaise),
      savedPaise: Value(savedPaise),
      priorityOrder: Value(priorityOrder),
      isActive: Value(isActive),
      isPaused: Value(isPaused),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      createdAt: Value(createdAt),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      targetPaise: serializer.fromJson<int>(json['targetPaise']),
      savedPaise: serializer.fromJson<int>(json['savedPaise']),
      priorityOrder: serializer.fromJson<int>(json['priorityOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isPaused: serializer.fromJson<bool>(json['isPaused']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'targetPaise': serializer.toJson<int>(targetPaise),
      'savedPaise': serializer.toJson<int>(savedPaise),
      'priorityOrder': serializer.toJson<int>(priorityOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'isPaused': serializer.toJson<bool>(isPaused),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Goal copyWith({
    String? id,
    String? title,
    int? targetPaise,
    int? savedPaise,
    int? priorityOrder,
    bool? isActive,
    bool? isPaused,
    Value<DateTime?> targetDate = const Value.absent(),
    DateTime? createdAt,
  }) => Goal(
    id: id ?? this.id,
    title: title ?? this.title,
    targetPaise: targetPaise ?? this.targetPaise,
    savedPaise: savedPaise ?? this.savedPaise,
    priorityOrder: priorityOrder ?? this.priorityOrder,
    isActive: isActive ?? this.isActive,
    isPaused: isPaused ?? this.isPaused,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    createdAt: createdAt ?? this.createdAt,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      targetPaise: data.targetPaise.present
          ? data.targetPaise.value
          : this.targetPaise,
      savedPaise: data.savedPaise.present
          ? data.savedPaise.value
          : this.savedPaise,
      priorityOrder: data.priorityOrder.present
          ? data.priorityOrder.value
          : this.priorityOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetPaise: $targetPaise, ')
          ..write('savedPaise: $savedPaise, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('isActive: $isActive, ')
          ..write('isPaused: $isPaused, ')
          ..write('targetDate: $targetDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    targetPaise,
    savedPaise,
    priorityOrder,
    isActive,
    isPaused,
    targetDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.title == this.title &&
          other.targetPaise == this.targetPaise &&
          other.savedPaise == this.savedPaise &&
          other.priorityOrder == this.priorityOrder &&
          other.isActive == this.isActive &&
          other.isPaused == this.isPaused &&
          other.targetDate == this.targetDate &&
          other.createdAt == this.createdAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> targetPaise;
  final Value<int> savedPaise;
  final Value<int> priorityOrder;
  final Value<bool> isActive;
  final Value<bool> isPaused;
  final Value<DateTime?> targetDate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.targetPaise = const Value.absent(),
    this.savedPaise = const Value.absent(),
    this.priorityOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String title,
    required int targetPaise,
    this.savedPaise = const Value.absent(),
    this.priorityOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       targetPaise = Value(targetPaise);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? targetPaise,
    Expression<int>? savedPaise,
    Expression<int>? priorityOrder,
    Expression<bool>? isActive,
    Expression<bool>? isPaused,
    Expression<DateTime>? targetDate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (targetPaise != null) 'target_paise': targetPaise,
      if (savedPaise != null) 'saved_paise': savedPaise,
      if (priorityOrder != null) 'priority_order': priorityOrder,
      if (isActive != null) 'is_active': isActive,
      if (isPaused != null) 'is_paused': isPaused,
      if (targetDate != null) 'target_date': targetDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? targetPaise,
    Value<int>? savedPaise,
    Value<int>? priorityOrder,
    Value<bool>? isActive,
    Value<bool>? isPaused,
    Value<DateTime?>? targetDate,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      targetPaise: targetPaise ?? this.targetPaise,
      savedPaise: savedPaise ?? this.savedPaise,
      priorityOrder: priorityOrder ?? this.priorityOrder,
      isActive: isActive ?? this.isActive,
      isPaused: isPaused ?? this.isPaused,
      targetDate: targetDate ?? this.targetDate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetPaise.present) {
      map['target_paise'] = Variable<int>(targetPaise.value);
    }
    if (savedPaise.present) {
      map['saved_paise'] = Variable<int>(savedPaise.value);
    }
    if (priorityOrder.present) {
      map['priority_order'] = Variable<int>(priorityOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<bool>(isPaused.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetPaise: $targetPaise, ')
          ..write('savedPaise: $savedPaise, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('isActive: $isActive, ')
          ..write('isPaused: $isPaused, ')
          ..write('targetDate: $targetDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteTextMeta = const VerificationMeta(
    'noteText',
  );
  @override
  late final GeneratedColumn<String> noteText = GeneratedColumn<String>(
    'note_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    noteText,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('note_text')) {
      context.handle(
        _noteTextMeta,
        noteText.isAcceptableOrUnknown(data['note_text']!, _noteTextMeta),
      );
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      noteText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String entityType;
  final String entityId;
  final String noteText;
  final DateTime createdAt;
  const Note({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.noteText,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['note_text'] = Variable<String>(noteText);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      noteText: Value(noteText),
      createdAt: Value(createdAt),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      noteText: serializer.fromJson<String>(json['noteText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'noteText': serializer.toJson<String>(noteText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Note copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? noteText,
    DateTime? createdAt,
  }) => Note(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    noteText: noteText ?? this.noteText,
    createdAt: createdAt ?? this.createdAt,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      noteText: data.noteText.present ? data.noteText.value : this.noteText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('noteText: $noteText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entityType, entityId, noteText, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.noteText == this.noteText &&
          other.createdAt == this.createdAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> noteText;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.noteText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String noteText,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       noteText = Value(noteText);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? noteText,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (noteText != null) 'note_text': noteText,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? noteText,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      noteText: noteText ?? this.noteText,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (noteText.present) {
      map['note_text'] = Variable<String>(noteText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('noteText: $noteText, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NudgeLogsTable extends NudgeLogs
    with TableInfo<$NudgeLogsTable, NudgeLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NudgeLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nudgeTypeMeta = const VerificationMeta(
    'nudgeType',
  );
  @override
  late final GeneratedColumn<String> nudgeType = GeneratedColumn<String>(
    'nudge_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numbersPayloadJsonMeta =
      const VerificationMeta('numbersPayloadJson');
  @override
  late final GeneratedColumn<String> numbersPayloadJson =
      GeneratedColumn<String>(
        'numbers_payload_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _userActionMeta = const VerificationMeta(
    'userAction',
  );
  @override
  late final GeneratedColumn<String> userAction = GeneratedColumn<String>(
    'user_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nudgeType,
    numbersPayloadJson,
    userAction,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nudge_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<NudgeLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nudge_type')) {
      context.handle(
        _nudgeTypeMeta,
        nudgeType.isAcceptableOrUnknown(data['nudge_type']!, _nudgeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_nudgeTypeMeta);
    }
    if (data.containsKey('numbers_payload_json')) {
      context.handle(
        _numbersPayloadJsonMeta,
        numbersPayloadJson.isAcceptableOrUnknown(
          data['numbers_payload_json']!,
          _numbersPayloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numbersPayloadJsonMeta);
    }
    if (data.containsKey('user_action')) {
      context.handle(
        _userActionMeta,
        userAction.isAcceptableOrUnknown(data['user_action']!, _userActionMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NudgeLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NudgeLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nudgeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nudge_type'],
      )!,
      numbersPayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numbers_payload_json'],
      )!,
      userAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_action'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $NudgeLogsTable createAlias(String alias) {
    return $NudgeLogsTable(attachedDatabase, alias);
  }
}

class NudgeLog extends DataClass implements Insertable<NudgeLog> {
  final String id;
  final String nudgeType;
  final String numbersPayloadJson;
  final String? userAction;
  final DateTime timestamp;
  const NudgeLog({
    required this.id,
    required this.nudgeType,
    required this.numbersPayloadJson,
    this.userAction,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nudge_type'] = Variable<String>(nudgeType);
    map['numbers_payload_json'] = Variable<String>(numbersPayloadJson);
    if (!nullToAbsent || userAction != null) {
      map['user_action'] = Variable<String>(userAction);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  NudgeLogsCompanion toCompanion(bool nullToAbsent) {
    return NudgeLogsCompanion(
      id: Value(id),
      nudgeType: Value(nudgeType),
      numbersPayloadJson: Value(numbersPayloadJson),
      userAction: userAction == null && nullToAbsent
          ? const Value.absent()
          : Value(userAction),
      timestamp: Value(timestamp),
    );
  }

  factory NudgeLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NudgeLog(
      id: serializer.fromJson<String>(json['id']),
      nudgeType: serializer.fromJson<String>(json['nudgeType']),
      numbersPayloadJson: serializer.fromJson<String>(
        json['numbersPayloadJson'],
      ),
      userAction: serializer.fromJson<String?>(json['userAction']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nudgeType': serializer.toJson<String>(nudgeType),
      'numbersPayloadJson': serializer.toJson<String>(numbersPayloadJson),
      'userAction': serializer.toJson<String?>(userAction),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  NudgeLog copyWith({
    String? id,
    String? nudgeType,
    String? numbersPayloadJson,
    Value<String?> userAction = const Value.absent(),
    DateTime? timestamp,
  }) => NudgeLog(
    id: id ?? this.id,
    nudgeType: nudgeType ?? this.nudgeType,
    numbersPayloadJson: numbersPayloadJson ?? this.numbersPayloadJson,
    userAction: userAction.present ? userAction.value : this.userAction,
    timestamp: timestamp ?? this.timestamp,
  );
  NudgeLog copyWithCompanion(NudgeLogsCompanion data) {
    return NudgeLog(
      id: data.id.present ? data.id.value : this.id,
      nudgeType: data.nudgeType.present ? data.nudgeType.value : this.nudgeType,
      numbersPayloadJson: data.numbersPayloadJson.present
          ? data.numbersPayloadJson.value
          : this.numbersPayloadJson,
      userAction: data.userAction.present
          ? data.userAction.value
          : this.userAction,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NudgeLog(')
          ..write('id: $id, ')
          ..write('nudgeType: $nudgeType, ')
          ..write('numbersPayloadJson: $numbersPayloadJson, ')
          ..write('userAction: $userAction, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nudgeType, numbersPayloadJson, userAction, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NudgeLog &&
          other.id == this.id &&
          other.nudgeType == this.nudgeType &&
          other.numbersPayloadJson == this.numbersPayloadJson &&
          other.userAction == this.userAction &&
          other.timestamp == this.timestamp);
}

class NudgeLogsCompanion extends UpdateCompanion<NudgeLog> {
  final Value<String> id;
  final Value<String> nudgeType;
  final Value<String> numbersPayloadJson;
  final Value<String?> userAction;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const NudgeLogsCompanion({
    this.id = const Value.absent(),
    this.nudgeType = const Value.absent(),
    this.numbersPayloadJson = const Value.absent(),
    this.userAction = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NudgeLogsCompanion.insert({
    required String id,
    required String nudgeType,
    required String numbersPayloadJson,
    this.userAction = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nudgeType = Value(nudgeType),
       numbersPayloadJson = Value(numbersPayloadJson);
  static Insertable<NudgeLog> custom({
    Expression<String>? id,
    Expression<String>? nudgeType,
    Expression<String>? numbersPayloadJson,
    Expression<String>? userAction,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nudgeType != null) 'nudge_type': nudgeType,
      if (numbersPayloadJson != null)
        'numbers_payload_json': numbersPayloadJson,
      if (userAction != null) 'user_action': userAction,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NudgeLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? nudgeType,
    Value<String>? numbersPayloadJson,
    Value<String?>? userAction,
    Value<DateTime>? timestamp,
    Value<int>? rowid,
  }) {
    return NudgeLogsCompanion(
      id: id ?? this.id,
      nudgeType: nudgeType ?? this.nudgeType,
      numbersPayloadJson: numbersPayloadJson ?? this.numbersPayloadJson,
      userAction: userAction ?? this.userAction,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nudgeType.present) {
      map['nudge_type'] = Variable<String>(nudgeType.value);
    }
    if (numbersPayloadJson.present) {
      map['numbers_payload_json'] = Variable<String>(numbersPayloadJson.value);
    }
    if (userAction.present) {
      map['user_action'] = Variable<String>(userAction.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NudgeLogsCompanion(')
          ..write('id: $id, ')
          ..write('nudgeType: $nudgeType, ')
          ..write('numbersPayloadJson: $numbersPayloadJson, ')
          ..write('userAction: $userAction, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _settingKeyMeta = const VerificationMeta(
    'settingKey',
  );
  @override
  late final GeneratedColumn<String> settingKey = GeneratedColumn<String>(
    'setting_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settingValueJsonMeta = const VerificationMeta(
    'settingValueJson',
  );
  @override
  late final GeneratedColumn<String> settingValueJson = GeneratedColumn<String>(
    'setting_value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    settingKey,
    settingValueJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('setting_key')) {
      context.handle(
        _settingKeyMeta,
        settingKey.isAcceptableOrUnknown(data['setting_key']!, _settingKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_settingKeyMeta);
    }
    if (data.containsKey('setting_value_json')) {
      context.handle(
        _settingValueJsonMeta,
        settingValueJson.isAcceptableOrUnknown(
          data['setting_value_json']!,
          _settingValueJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_settingValueJsonMeta);
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
  Set<GeneratedColumn> get $primaryKey => {settingKey};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      settingKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_key'],
      )!,
      settingValueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_value_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final String settingKey;
  final String settingValueJson;
  final DateTime updatedAt;
  const UserSetting({
    required this.settingKey,
    required this.settingValueJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['setting_key'] = Variable<String>(settingKey);
    map['setting_value_json'] = Variable<String>(settingValueJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      settingKey: Value(settingKey),
      settingValueJson: Value(settingValueJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      settingKey: serializer.fromJson<String>(json['settingKey']),
      settingValueJson: serializer.fromJson<String>(json['settingValueJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'settingKey': serializer.toJson<String>(settingKey),
      'settingValueJson': serializer.toJson<String>(settingValueJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserSetting copyWith({
    String? settingKey,
    String? settingValueJson,
    DateTime? updatedAt,
  }) => UserSetting(
    settingKey: settingKey ?? this.settingKey,
    settingValueJson: settingValueJson ?? this.settingValueJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      settingKey: data.settingKey.present
          ? data.settingKey.value
          : this.settingKey,
      settingValueJson: data.settingValueJson.present
          ? data.settingValueJson.value
          : this.settingValueJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('settingKey: $settingKey, ')
          ..write('settingValueJson: $settingValueJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(settingKey, settingValueJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.settingKey == this.settingKey &&
          other.settingValueJson == this.settingValueJson &&
          other.updatedAt == this.updatedAt);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<String> settingKey;
  final Value<String> settingValueJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserSettingsCompanion({
    this.settingKey = const Value.absent(),
    this.settingValueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    required String settingKey,
    required String settingValueJson,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : settingKey = Value(settingKey),
       settingValueJson = Value(settingValueJson);
  static Insertable<UserSetting> custom({
    Expression<String>? settingKey,
    Expression<String>? settingValueJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (settingKey != null) 'setting_key': settingKey,
      if (settingValueJson != null) 'setting_value_json': settingValueJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsCompanion copyWith({
    Value<String>? settingKey,
    Value<String>? settingValueJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserSettingsCompanion(
      settingKey: settingKey ?? this.settingKey,
      settingValueJson: settingValueJson ?? this.settingValueJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (settingValueJson.present) {
      map['setting_value_json'] = Variable<String>(settingValueJson.value);
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
    return (StringBuffer('UserSettingsCompanion(')
          ..write('settingKey: $settingKey, ')
          ..write('settingValueJson: $settingValueJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BanksTable banks = $BanksTable(this);
  late final $BankTemplatesTableTable bankTemplatesTable =
      $BankTemplatesTableTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $SalarySourcesTable salarySources = $SalarySourcesTable(this);
  late final $CyclesTable cycles = $CyclesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $PayeesTable payees = $PayeesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $RecurringRulesTable recurringRules = $RecurringRulesTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $NudgeLogsTable nudgeLogs = $NudgeLogsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    banks,
    bankTemplatesTable,
    accounts,
    salarySources,
    cycles,
    categories,
    payees,
    transactions,
    recurringRules,
    goals,
    notes,
    nudgeLogs,
    userSettings,
  ];
}

typedef $$BanksTableCreateCompanionBuilder = BanksCompanion Function({
  required String id,
  required String name,
  Value<String?> primaryColor,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$BanksTableUpdateCompanionBuilder = BanksCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> primaryColor,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$BanksTableReferences
    extends BaseReferences<_$AppDatabase, $BanksTable, Bank> {
  $$BanksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $BankTemplatesTableTable,
    List<BankTemplatesTableData>
  >
  _bankTemplatesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.bankTemplatesTable,
        aliasName: 'banks__id__bank_templates_table__bank_id',
      );

  $$BankTemplatesTableTableProcessedTableManager get bankTemplatesTableRefs {
    final manager = $$BankTemplatesTableTableTableManager(
      $_db,
      $_db.bankTemplatesTable,
    ).filter((f) => f.bankId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _bankTemplatesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: 'banks__id__accounts__bank_id',
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.bankId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BanksTableFilterComposer extends Composer<_$AppDatabase, $BanksTable> {
  $$BanksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bankTemplatesTableRefs(
    Expression<bool> Function($$BankTemplatesTableTableFilterComposer f) f,
  ) {
    final $$BankTemplatesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bankTemplatesTable,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankTemplatesTableTableFilterComposer(
            $db: $db,
            $table: $db.bankTemplatesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BanksTableOrderingComposer
    extends Composer<_$AppDatabase, $BanksTable> {
  $$BanksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BanksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BanksTable> {
  $$BanksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> bankTemplatesTableRefs<T extends Object>(
    Expression<T> Function($$BankTemplatesTableTableAnnotationComposer a) f,
  ) {
    final $$BankTemplatesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.bankTemplatesTable,
          getReferencedColumn: (t) => t.bankId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BankTemplatesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.bankTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BanksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BanksTable,
          Bank,
          $$BanksTableFilterComposer,
          $$BanksTableOrderingComposer,
          $$BanksTableAnnotationComposer,
          $$BanksTableCreateCompanionBuilder,
          $$BanksTableUpdateCompanionBuilder,
          (Bank, $$BanksTableReferences),
          Bank,
          PrefetchHooks Function({
            bool bankTemplatesTableRefs,
            bool accountsRefs,
          })
        > {
  $$BanksTableTableManager(_$AppDatabase db, $BanksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BanksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BanksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BanksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> primaryColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BanksCompanion(
                id: id,
                name: name,
                primaryColor: primaryColor,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> primaryColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BanksCompanion.insert(
                id: id,
                name: name,
                primaryColor: primaryColor,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BanksTable, Bank>(table),
                  $$BanksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({bankTemplatesTableRefs = false, accountsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bankTemplatesTableRefs) db.bankTemplatesTable,
                    if (accountsRefs) db.accounts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bankTemplatesTableRefs)
                        await $_getPrefetchedDataByColumns<
                          Bank,
                          $BanksTable,
                          BankTemplatesTableData,
                          $BankTemplatesTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$BanksTableReferences
                              ._bankTemplatesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BanksTableReferences(
                                db,
                                table,
                                p0,
                              ).bankTemplatesTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_id',
                          typedResults: items,
                        ),
                      if (accountsRefs)
                        await $_getPrefetchedDataByColumns<
                          Bank,
                          $BanksTable,
                          Account,
                          $AccountsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BanksTableReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BanksTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BanksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BanksTable,
      Bank,
      $$BanksTableFilterComposer,
      $$BanksTableOrderingComposer,
      $$BanksTableAnnotationComposer,
      $$BanksTableCreateCompanionBuilder,
      $$BanksTableUpdateCompanionBuilder,
      (Bank, $$BanksTableReferences),
      Bank,
      PrefetchHooks Function({bool bankTemplatesTableRefs, bool accountsRefs})
    >;
typedef $$BankTemplatesTableTableCreateCompanionBuilder =
    BankTemplatesTableCompanion Function({
      required String id,
      required String bankId,
      required String bankName,
      required String senderIds,
      required String txnType,
      required String pattern,
      required String dateFormat,
      required String currencyKeywords,
      required String tokenMap,
      Value<int> version,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$BankTemplatesTableTableUpdateCompanionBuilder =
    BankTemplatesTableCompanion Function({
      Value<String> id,
      Value<String> bankId,
      Value<String> bankName,
      Value<String> senderIds,
      Value<String> txnType,
      Value<String> pattern,
      Value<String> dateFormat,
      Value<String> currencyKeywords,
      Value<String> tokenMap,
      Value<int> version,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$BankTemplatesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BankTemplatesTableTable,
          BankTemplatesTableData
        > {
  $$BankTemplatesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BanksTable _bankIdTable(_$AppDatabase db) =>
      db.banks.createAlias('bank_templates_table__bank_id__banks__id');

  $$BanksTableProcessedTableManager get bankId {
    final $_column = $_itemColumn<String>('bank_id')!;

    final manager = $$BanksTableTableManager(
      $_db,
      $_db.banks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BankTemplatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $BankTemplatesTableTable> {
  $$BankTemplatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderIds => $composableBuilder(
    column: $table.senderIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get txnType => $composableBuilder(
    column: $table.txnType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateFormat => $composableBuilder(
    column: $table.dateFormat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyKeywords => $composableBuilder(
    column: $table.currencyKeywords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tokenMap => $composableBuilder(
    column: $table.tokenMap,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BanksTableFilterComposer get bankId {
    final $$BanksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableFilterComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankTemplatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BankTemplatesTableTable> {
  $$BankTemplatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderIds => $composableBuilder(
    column: $table.senderIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get txnType => $composableBuilder(
    column: $table.txnType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateFormat => $composableBuilder(
    column: $table.dateFormat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyKeywords => $composableBuilder(
    column: $table.currencyKeywords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tokenMap => $composableBuilder(
    column: $table.tokenMap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BanksTableOrderingComposer get bankId {
    final $$BanksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableOrderingComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankTemplatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankTemplatesTableTable> {
  $$BankTemplatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get senderIds =>
      $composableBuilder(column: $table.senderIds, builder: (column) => column);

  GeneratedColumn<String> get txnType =>
      $composableBuilder(column: $table.txnType, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<String> get dateFormat => $composableBuilder(
    column: $table.dateFormat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyKeywords => $composableBuilder(
    column: $table.currencyKeywords,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tokenMap =>
      $composableBuilder(column: $table.tokenMap, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BanksTableAnnotationComposer get bankId {
    final $$BanksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableAnnotationComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankTemplatesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankTemplatesTableTable,
          BankTemplatesTableData,
          $$BankTemplatesTableTableFilterComposer,
          $$BankTemplatesTableTableOrderingComposer,
          $$BankTemplatesTableTableAnnotationComposer,
          $$BankTemplatesTableTableCreateCompanionBuilder,
          $$BankTemplatesTableTableUpdateCompanionBuilder,
          (BankTemplatesTableData, $$BankTemplatesTableTableReferences),
          BankTemplatesTableData,
          PrefetchHooks Function({bool bankId})
        > {
  $$BankTemplatesTableTableTableManager(
    _$AppDatabase db,
    $BankTemplatesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankTemplatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankTemplatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BankTemplatesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bankId = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String> senderIds = const Value.absent(),
                Value<String> txnType = const Value.absent(),
                Value<String> pattern = const Value.absent(),
                Value<String> dateFormat = const Value.absent(),
                Value<String> currencyKeywords = const Value.absent(),
                Value<String> tokenMap = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankTemplatesTableCompanion(
                id: id,
                bankId: bankId,
                bankName: bankName,
                senderIds: senderIds,
                txnType: txnType,
                pattern: pattern,
                dateFormat: dateFormat,
                currencyKeywords: currencyKeywords,
                tokenMap: tokenMap,
                version: version,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bankId,
                required String bankName,
                required String senderIds,
                required String txnType,
                required String pattern,
                required String dateFormat,
                required String currencyKeywords,
                required String tokenMap,
                Value<int> version = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankTemplatesTableCompanion.insert(
                id: id,
                bankId: bankId,
                bankName: bankName,
                senderIds: senderIds,
                txnType: txnType,
                pattern: pattern,
                dateFormat: dateFormat,
                currencyKeywords: currencyKeywords,
                tokenMap: tokenMap,
                version: version,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BankTemplatesTableTable, BankTemplatesTableData>(
                    table,
                  ),
                  $$BankTemplatesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bankId = false}) {
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
                    if (bankId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.bankId,
                        referencedTable: $$BankTemplatesTableTableReferences
                            ._bankIdTable(db),
                        referencedColumn: $$BankTemplatesTableTableReferences
                            ._bankIdTable(db)
                            .id,
                      ) as T;
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

typedef $$BankTemplatesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankTemplatesTableTable,
      BankTemplatesTableData,
      $$BankTemplatesTableTableFilterComposer,
      $$BankTemplatesTableTableOrderingComposer,
      $$BankTemplatesTableTableAnnotationComposer,
      $$BankTemplatesTableTableCreateCompanionBuilder,
      $$BankTemplatesTableTableUpdateCompanionBuilder,
      (BankTemplatesTableData, $$BankTemplatesTableTableReferences),
      BankTemplatesTableData,
      PrefetchHooks Function({bool bankId})
    >;
typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  required String id,
  Value<String?> bankId,
  required String bankName,
  required String last4Digits,
  Value<String?> nickname,
  Value<bool> isOwnAccount,
  Value<bool> isArchived,
  Value<int> runningBalancePaise,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  Value<String?> bankId,
  Value<String> bankName,
  Value<String> last4Digits,
  Value<String?> nickname,
  Value<bool> isOwnAccount,
  Value<bool> isArchived,
  Value<int> runningBalancePaise,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BanksTable _bankIdTable(_$AppDatabase db) =>
      db.banks.createAlias('accounts__bank_id__banks__id');

  $$BanksTableProcessedTableManager? get bankId {
    final $_column = $_itemColumn<String>('bank_id');
    if ($_column == null) return null;
    final manager = $$BanksTableTableManager(
      $_db,
      $_db.banks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SalarySourcesTable, List<SalarySource>>
  _salarySourcesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salarySources,
    aliasName: 'accounts__id__salary_sources__linked_account_id',
  );

  $$SalarySourcesTableProcessedTableManager get salarySourcesRefs {
    final manager = $$SalarySourcesTableTableManager($_db, $_db.salarySources)
        .filter(
          (f) => f.linkedAccountId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_salarySourcesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'accounts__id__transactions__account_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecurringRulesTable, List<RecurringRule>>
  _recurringRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recurringRules,
    aliasName: 'accounts__id__recurring_rules__account_id',
  );

  $$RecurringRulesTableProcessedTableManager get recurringRulesRefs {
    final manager = $$RecurringRulesTableTableManager(
      $_db,
      $_db.recurringRules,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recurringRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get last4Digits => $composableBuilder(
    column: $table.last4Digits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOwnAccount => $composableBuilder(
    column: $table.isOwnAccount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get runningBalancePaise => $composableBuilder(
    column: $table.runningBalancePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BanksTableFilterComposer get bankId {
    final $$BanksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableFilterComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> salarySourcesRefs(
    Expression<bool> Function($$SalarySourcesTableFilterComposer f) f,
  ) {
    final $$SalarySourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salarySources,
      getReferencedColumn: (t) => t.linkedAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalarySourcesTableFilterComposer(
            $db: $db,
            $table: $db.salarySources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringRulesRefs(
    Expression<bool> Function($$RecurringRulesTableFilterComposer f) f,
  ) {
    final $$RecurringRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringRulesTableFilterComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get last4Digits => $composableBuilder(
    column: $table.last4Digits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOwnAccount => $composableBuilder(
    column: $table.isOwnAccount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get runningBalancePaise => $composableBuilder(
    column: $table.runningBalancePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BanksTableOrderingComposer get bankId {
    final $$BanksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableOrderingComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get last4Digits => $composableBuilder(
    column: $table.last4Digits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<bool> get isOwnAccount => $composableBuilder(
    column: $table.isOwnAccount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get runningBalancePaise => $composableBuilder(
    column: $table.runningBalancePaise,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BanksTableAnnotationComposer get bankId {
    final $$BanksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableAnnotationComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> salarySourcesRefs<T extends Object>(
    Expression<T> Function($$SalarySourcesTableAnnotationComposer a) f,
  ) {
    final $$SalarySourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salarySources,
      getReferencedColumn: (t) => t.linkedAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalarySourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.salarySources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringRulesRefs<T extends Object>(
    Expression<T> Function($$RecurringRulesTableAnnotationComposer a) f,
  ) {
    final $$RecurringRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({
            bool bankId,
            bool salarySourcesRefs,
            bool transactionsRefs,
            bool recurringRulesRefs,
          })
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> bankId = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String> last4Digits = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<bool> isOwnAccount = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> runningBalancePaise = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                bankId: bankId,
                bankName: bankName,
                last4Digits: last4Digits,
                nickname: nickname,
                isOwnAccount: isOwnAccount,
                isArchived: isArchived,
                runningBalancePaise: runningBalancePaise,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> bankId = const Value.absent(),
                required String bankName,
                required String last4Digits,
                Value<String?> nickname = const Value.absent(),
                Value<bool> isOwnAccount = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> runningBalancePaise = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                bankId: bankId,
                bankName: bankName,
                last4Digits: last4Digits,
                nickname: nickname,
                isOwnAccount: isOwnAccount,
                isArchived: isArchived,
                runningBalancePaise: runningBalancePaise,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountsTable, Account>(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                bankId = false,
                salarySourcesRefs = false,
                transactionsRefs = false,
                recurringRulesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (salarySourcesRefs) db.salarySources,
                    if (transactionsRefs) db.transactions,
                    if (recurringRulesRefs) db.recurringRules,
                  ],
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
                        if (bankId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.bankId,
                            referencedTable: $$AccountsTableReferences
                                ._bankIdTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._bankIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (salarySourcesRefs)
                        await $_getPrefetchedDataByColumns<
                          Account,
                          $AccountsTable,
                          SalarySource,
                          $SalarySourcesTable
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._salarySourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).salarySourcesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'linked_account_id',
                          typedResults: items,
                        ),
                      if (transactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Account,
                          $AccountsTable,
                          Transaction,
                          $TransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'account_id',
                          typedResults: items,
                        ),
                      if (recurringRulesRefs)
                        await $_getPrefetchedDataByColumns<
                          Account,
                          $AccountsTable,
                          RecurringRule,
                          $RecurringRulesTable
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._recurringRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringRulesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'account_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({
        bool bankId,
        bool salarySourcesRefs,
        bool transactionsRefs,
        bool recurringRulesRefs,
      })
    >;
typedef $$SalarySourcesTableCreateCompanionBuilder =
    SalarySourcesCompanion Function({
      required String id,
      required String label,
      Value<String?> sendingAccountDigits,
      Value<String?> linkedAccountId,
      Value<int?> lastCreditedAmountPaise,
      Value<DateTime?> lastCreditedDate,
      Value<bool> isPaused,
      Value<int> rowid,
    });
typedef $$SalarySourcesTableUpdateCompanionBuilder =
    SalarySourcesCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<String?> sendingAccountDigits,
      Value<String?> linkedAccountId,
      Value<int?> lastCreditedAmountPaise,
      Value<DateTime?> lastCreditedDate,
      Value<bool> isPaused,
      Value<int> rowid,
    });

final class $$SalarySourcesTableReferences
    extends BaseReferences<_$AppDatabase, $SalarySourcesTable, SalarySource> {
  $$SalarySourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTable _linkedAccountIdTable(_$AppDatabase db) => db.accounts
      .createAlias('salary_sources__linked_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get linkedAccountId {
    final $_column = $_itemColumn<String>('linked_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SalarySourcesTableFilterComposer
    extends Composer<_$AppDatabase, $SalarySourcesTable> {
  $$SalarySourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sendingAccountDigits => $composableBuilder(
    column: $table.sendingAccountDigits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastCreditedAmountPaise => $composableBuilder(
    column: $table.lastCreditedAmountPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCreditedDate => $composableBuilder(
    column: $table.lastCreditedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get linkedAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalarySourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalarySourcesTable> {
  $$SalarySourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sendingAccountDigits => $composableBuilder(
    column: $table.sendingAccountDigits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastCreditedAmountPaise => $composableBuilder(
    column: $table.lastCreditedAmountPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCreditedDate => $composableBuilder(
    column: $table.lastCreditedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get linkedAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalarySourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalarySourcesTable> {
  $$SalarySourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get sendingAccountDigits => $composableBuilder(
    column: $table.sendingAccountDigits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastCreditedAmountPaise => $composableBuilder(
    column: $table.lastCreditedAmountPaise,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCreditedDate => $composableBuilder(
    column: $table.lastCreditedDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  $$AccountsTableAnnotationComposer get linkedAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalarySourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalarySourcesTable,
          SalarySource,
          $$SalarySourcesTableFilterComposer,
          $$SalarySourcesTableOrderingComposer,
          $$SalarySourcesTableAnnotationComposer,
          $$SalarySourcesTableCreateCompanionBuilder,
          $$SalarySourcesTableUpdateCompanionBuilder,
          (SalarySource, $$SalarySourcesTableReferences),
          SalarySource,
          PrefetchHooks Function({bool linkedAccountId})
        > {
  $$SalarySourcesTableTableManager(_$AppDatabase db, $SalarySourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalarySourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalarySourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalarySourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> sendingAccountDigits = const Value.absent(),
                Value<String?> linkedAccountId = const Value.absent(),
                Value<int?> lastCreditedAmountPaise = const Value.absent(),
                Value<DateTime?> lastCreditedDate = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalarySourcesCompanion(
                id: id,
                label: label,
                sendingAccountDigits: sendingAccountDigits,
                linkedAccountId: linkedAccountId,
                lastCreditedAmountPaise: lastCreditedAmountPaise,
                lastCreditedDate: lastCreditedDate,
                isPaused: isPaused,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String label,
                Value<String?> sendingAccountDigits = const Value.absent(),
                Value<String?> linkedAccountId = const Value.absent(),
                Value<int?> lastCreditedAmountPaise = const Value.absent(),
                Value<DateTime?> lastCreditedDate = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalarySourcesCompanion.insert(
                id: id,
                label: label,
                sendingAccountDigits: sendingAccountDigits,
                linkedAccountId: linkedAccountId,
                lastCreditedAmountPaise: lastCreditedAmountPaise,
                lastCreditedDate: lastCreditedDate,
                isPaused: isPaused,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SalarySourcesTable, SalarySource>(table),
                  $$SalarySourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({linkedAccountId = false}) {
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
                    if (linkedAccountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.linkedAccountId,
                        referencedTable: $$SalarySourcesTableReferences
                            ._linkedAccountIdTable(db),
                        referencedColumn: $$SalarySourcesTableReferences
                            ._linkedAccountIdTable(db)
                            .id,
                      ) as T;
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

typedef $$SalarySourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalarySourcesTable,
      SalarySource,
      $$SalarySourcesTableFilterComposer,
      $$SalarySourcesTableOrderingComposer,
      $$SalarySourcesTableAnnotationComposer,
      $$SalarySourcesTableCreateCompanionBuilder,
      $$SalarySourcesTableUpdateCompanionBuilder,
      (SalarySource, $$SalarySourcesTableReferences),
      SalarySource,
      PrefetchHooks Function({bool linkedAccountId})
    >;
typedef $$CyclesTableCreateCompanionBuilder = CyclesCompanion Function({
  required String id,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<DateTime?> expectedNextDate,
  required int confirmedSalaryPaise,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$CyclesTableUpdateCompanionBuilder = CyclesCompanion Function({
  Value<String> id,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<DateTime?> expectedNextDate,
  Value<int> confirmedSalaryPaise,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$CyclesTableReferences
    extends BaseReferences<_$AppDatabase, $CyclesTable, Cycle> {
  $$CyclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'cycles__id__transactions__cycle_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.cycleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CyclesTableFilterComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedNextDate => $composableBuilder(
    column: $table.expectedNextDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confirmedSalaryPaise => $composableBuilder(
    column: $table.confirmedSalaryPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.cycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedNextDate => $composableBuilder(
    column: $table.expectedNextDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confirmedSalaryPaise => $composableBuilder(
    column: $table.confirmedSalaryPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedNextDate => $composableBuilder(
    column: $table.expectedNextDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confirmedSalaryPaise => $composableBuilder(
    column: $table.confirmedSalaryPaise,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.cycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CyclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CyclesTable,
          Cycle,
          $$CyclesTableFilterComposer,
          $$CyclesTableOrderingComposer,
          $$CyclesTableAnnotationComposer,
          $$CyclesTableCreateCompanionBuilder,
          $$CyclesTableUpdateCompanionBuilder,
          (Cycle, $$CyclesTableReferences),
          Cycle,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$CyclesTableTableManager(_$AppDatabase db, $CyclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime?> expectedNextDate = const Value.absent(),
                Value<int> confirmedSalaryPaise = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CyclesCompanion(
                id: id,
                startDate: startDate,
                endDate: endDate,
                expectedNextDate: expectedNextDate,
                confirmedSalaryPaise: confirmedSalaryPaise,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime?> expectedNextDate = const Value.absent(),
                required int confirmedSalaryPaise,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CyclesCompanion.insert(
                id: id,
                startDate: startDate,
                endDate: endDate,
                expectedNextDate: expectedNextDate,
                confirmedSalaryPaise: confirmedSalaryPaise,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CyclesTable, Cycle>(table),
                  $$CyclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedDataByColumns<
                      Cycle,
                      $CyclesTable,
                      Transaction,
                      $TransactionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CyclesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$CyclesTableReferences(
                        db,
                        table,
                        p0,
                      ).transactionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'cycle_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CyclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CyclesTable,
      Cycle,
      $$CyclesTableFilterComposer,
      $$CyclesTableOrderingComposer,
      $$CyclesTableAnnotationComposer,
      $$CyclesTableCreateCompanionBuilder,
      $$CyclesTableUpdateCompanionBuilder,
      (Cycle, $$CyclesTableReferences),
      Cycle,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  required String icon,
  required String budgetType,
  Value<int?> monthlyLimitPaise,
  Value<bool> isCustom,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> icon,
  Value<String> budgetType,
  Value<int?> monthlyLimitPaise,
  Value<bool> isCustom,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PayeesTable, List<Payee>> _payeesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payees,
    aliasName: 'categories__id__payees__default_category_id',
  );

  $$PayeesTableProcessedTableManager get payeesRefs {
    final manager = $$PayeesTableTableManager($_db, $_db.payees).filter(
      (f) => f.defaultCategoryId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_payeesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'categories__id__transactions__category_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get budgetType => $composableBuilder(
    column: $table.budgetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlyLimitPaise => $composableBuilder(
    column: $table.monthlyLimitPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> payeesRefs(
    Expression<bool> Function($$PayeesTableFilterComposer f) f,
  ) {
    final $$PayeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableFilterComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get budgetType => $composableBuilder(
    column: $table.budgetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyLimitPaise => $composableBuilder(
    column: $table.monthlyLimitPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get budgetType => $composableBuilder(
    column: $table.budgetType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monthlyLimitPaise => $composableBuilder(
    column: $table.monthlyLimitPaise,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  Expression<T> payeesRefs<T extends Object>(
    Expression<T> Function($$PayeesTableAnnotationComposer a) f,
  ) {
    final $$PayeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableAnnotationComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool payeesRefs, bool transactionsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> budgetType = const Value.absent(),
                Value<int?> monthlyLimitPaise = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                icon: icon,
                budgetType: budgetType,
                monthlyLimitPaise: monthlyLimitPaise,
                isCustom: isCustom,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String icon,
                required String budgetType,
                Value<int?> monthlyLimitPaise = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                budgetType: budgetType,
                monthlyLimitPaise: monthlyLimitPaise,
                isCustom: isCustom,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({payeesRefs = false, transactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (payeesRefs) db.payees,
                    if (transactionsRefs) db.transactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (payeesRefs)
                        await $_getPrefetchedDataByColumns<
                          Category,
                          $CategoriesTable,
                          Payee,
                          $PayeesTable
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._payeesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).payeesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'default_category_id',
                          typedResults: items,
                        ),
                      if (transactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Category,
                          $CategoriesTable,
                          Transaction,
                          $TransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'category_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool payeesRefs, bool transactionsRefs})
    >;
typedef $$PayeesTableCreateCompanionBuilder = PayeesCompanion Function({
  required String id,
  required String name,
  required String cleanedName,
  required String keywordPatterns,
  Value<String?> defaultCategoryId,
  Value<String?> defaultClassification,
  Value<String?> p2pPurpose,
  Value<int> rowid,
});
typedef $$PayeesTableUpdateCompanionBuilder = PayeesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> cleanedName,
  Value<String> keywordPatterns,
  Value<String?> defaultCategoryId,
  Value<String?> defaultClassification,
  Value<String?> p2pPurpose,
  Value<int> rowid,
});

final class $$PayeesTableReferences
    extends BaseReferences<_$AppDatabase, $PayeesTable, Payee> {
  $$PayeesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _defaultCategoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('payees__default_category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get defaultCategoryId {
    final $_column = $_itemColumn<String>('default_category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'payees__id__transactions__payee_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.payeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecurringRulesTable, List<RecurringRule>>
  _recurringRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recurringRules,
    aliasName: 'payees__id__recurring_rules__payee_id',
  );

  $$RecurringRulesTableProcessedTableManager get recurringRulesRefs {
    final manager = $$RecurringRulesTableTableManager(
      $_db,
      $_db.recurringRules,
    ).filter((f) => f.payeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recurringRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PayeesTableFilterComposer
    extends Composer<_$AppDatabase, $PayeesTable> {
  $$PayeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cleanedName => $composableBuilder(
    column: $table.cleanedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keywordPatterns => $composableBuilder(
    column: $table.keywordPatterns,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultClassification => $composableBuilder(
    column: $table.defaultClassification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get p2pPurpose => $composableBuilder(
    column: $table.p2pPurpose,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get defaultCategoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.payeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recurringRulesRefs(
    Expression<bool> Function($$RecurringRulesTableFilterComposer f) f,
  ) {
    final $$RecurringRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.payeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringRulesTableFilterComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PayeesTableOrderingComposer
    extends Composer<_$AppDatabase, $PayeesTable> {
  $$PayeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cleanedName => $composableBuilder(
    column: $table.cleanedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keywordPatterns => $composableBuilder(
    column: $table.keywordPatterns,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultClassification => $composableBuilder(
    column: $table.defaultClassification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get p2pPurpose => $composableBuilder(
    column: $table.p2pPurpose,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get defaultCategoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PayeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayeesTable> {
  $$PayeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get cleanedName => $composableBuilder(
    column: $table.cleanedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keywordPatterns => $composableBuilder(
    column: $table.keywordPatterns,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultClassification => $composableBuilder(
    column: $table.defaultClassification,
    builder: (column) => column,
  );

  GeneratedColumn<String> get p2pPurpose => $composableBuilder(
    column: $table.p2pPurpose,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get defaultCategoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.payeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recurringRulesRefs<T extends Object>(
    Expression<T> Function($$RecurringRulesTableAnnotationComposer a) f,
  ) {
    final $$RecurringRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRules,
      getReferencedColumn: (t) => t.payeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.recurringRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PayeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayeesTable,
          Payee,
          $$PayeesTableFilterComposer,
          $$PayeesTableOrderingComposer,
          $$PayeesTableAnnotationComposer,
          $$PayeesTableCreateCompanionBuilder,
          $$PayeesTableUpdateCompanionBuilder,
          (Payee, $$PayeesTableReferences),
          Payee,
          PrefetchHooks Function({
            bool defaultCategoryId,
            bool transactionsRefs,
            bool recurringRulesRefs,
          })
        > {
  $$PayeesTableTableManager(_$AppDatabase db, $PayeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> cleanedName = const Value.absent(),
                Value<String> keywordPatterns = const Value.absent(),
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultClassification = const Value.absent(),
                Value<String?> p2pPurpose = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayeesCompanion(
                id: id,
                name: name,
                cleanedName: cleanedName,
                keywordPatterns: keywordPatterns,
                defaultCategoryId: defaultCategoryId,
                defaultClassification: defaultClassification,
                p2pPurpose: p2pPurpose,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String cleanedName,
                required String keywordPatterns,
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultClassification = const Value.absent(),
                Value<String?> p2pPurpose = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayeesCompanion.insert(
                id: id,
                name: name,
                cleanedName: cleanedName,
                keywordPatterns: keywordPatterns,
                defaultCategoryId: defaultCategoryId,
                defaultClassification: defaultClassification,
                p2pPurpose: p2pPurpose,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PayeesTable, Payee>(table),
                  $$PayeesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                defaultCategoryId = false,
                transactionsRefs = false,
                recurringRulesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsRefs) db.transactions,
                    if (recurringRulesRefs) db.recurringRules,
                  ],
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
                        if (defaultCategoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.defaultCategoryId,
                            referencedTable: $$PayeesTableReferences
                                ._defaultCategoryIdTable(db),
                            referencedColumn: $$PayeesTableReferences
                                ._defaultCategoryIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Payee,
                          $PayeesTable,
                          Transaction,
                          $TransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PayeesTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PayeesTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'payee_id',
                          typedResults: items,
                        ),
                      if (recurringRulesRefs)
                        await $_getPrefetchedDataByColumns<
                          Payee,
                          $PayeesTable,
                          RecurringRule,
                          $RecurringRulesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PayeesTableReferences
                              ._recurringRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PayeesTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringRulesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'payee_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PayeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayeesTable,
      Payee,
      $$PayeesTableFilterComposer,
      $$PayeesTableOrderingComposer,
      $$PayeesTableAnnotationComposer,
      $$PayeesTableCreateCompanionBuilder,
      $$PayeesTableUpdateCompanionBuilder,
      (Payee, $$PayeesTableReferences),
      Payee,
      PrefetchHooks Function({
        bool defaultCategoryId,
        bool transactionsRefs,
        bool recurringRulesRefs,
      })
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required String accountId,
      Value<String?> cycleId,
      required int amountPaise,
      required String txnType,
      Value<String> classification,
      Value<String?> categoryId,
      Value<String?> payeeId,
      required String payeeName,
      Value<int?> balanceAfterPaise,
      required DateTime timestamp,
      required DateTime receivedAt,
      required String rawSmsBody,
      required String dedupeHash,
      Value<String?> upiRef,
      Value<bool> isFlagged,
      Value<String?> flagReason,
      Value<String> tagStatus,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String?> cycleId,
      Value<int> amountPaise,
      Value<String> txnType,
      Value<String> classification,
      Value<String?> categoryId,
      Value<String?> payeeId,
      Value<String> payeeName,
      Value<int?> balanceAfterPaise,
      Value<DateTime> timestamp,
      Value<DateTime> receivedAt,
      Value<String> rawSmsBody,
      Value<String> dedupeHash,
      Value<String?> upiRef,
      Value<bool> isFlagged,
      Value<String?> flagReason,
      Value<String> tagStatus,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('transactions__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CyclesTable _cycleIdTable(_$AppDatabase db) =>
      db.cycles.createAlias('transactions__cycle_id__cycles__id');

  $$CyclesTableProcessedTableManager? get cycleId {
    final $_column = $_itemColumn<String>('cycle_id');
    if ($_column == null) return null;
    final manager = $$CyclesTableTableManager(
      $_db,
      $_db.cycles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cycleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('transactions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PayeesTable _payeeIdTable(_$AppDatabase db) =>
      db.payees.createAlias('transactions__payee_id__payees__id');

  $$PayeesTableProcessedTableManager? get payeeId {
    final $_column = $_itemColumn<String>('payee_id');
    if ($_column == null) return null;
    final manager = $$PayeesTableTableManager(
      $_db,
      $_db.payees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get txnType => $composableBuilder(
    column: $table.txnType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classification => $composableBuilder(
    column: $table.classification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payeeName => $composableBuilder(
    column: $table.payeeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceAfterPaise => $composableBuilder(
    column: $table.balanceAfterPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawSmsBody => $composableBuilder(
    column: $table.rawSmsBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dedupeHash => $composableBuilder(
    column: $table.dedupeHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get upiRef => $composableBuilder(
    column: $table.upiRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFlagged => $composableBuilder(
    column: $table.isFlagged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flagReason => $composableBuilder(
    column: $table.flagReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagStatus => $composableBuilder(
    column: $table.tagStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CyclesTableFilterComposer get cycleId {
    final $$CyclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cycleId,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableFilterComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PayeesTableFilterComposer get payeeId {
    final $$PayeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableFilterComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get txnType => $composableBuilder(
    column: $table.txnType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classification => $composableBuilder(
    column: $table.classification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payeeName => $composableBuilder(
    column: $table.payeeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceAfterPaise => $composableBuilder(
    column: $table.balanceAfterPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawSmsBody => $composableBuilder(
    column: $table.rawSmsBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dedupeHash => $composableBuilder(
    column: $table.dedupeHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get upiRef => $composableBuilder(
    column: $table.upiRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFlagged => $composableBuilder(
    column: $table.isFlagged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flagReason => $composableBuilder(
    column: $table.flagReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagStatus => $composableBuilder(
    column: $table.tagStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CyclesTableOrderingComposer get cycleId {
    final $$CyclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cycleId,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableOrderingComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PayeesTableOrderingComposer get payeeId {
    final $$PayeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableOrderingComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get txnType =>
      $composableBuilder(column: $table.txnType, builder: (column) => column);

  GeneratedColumn<String> get classification => $composableBuilder(
    column: $table.classification,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payeeName =>
      $composableBuilder(column: $table.payeeName, builder: (column) => column);

  GeneratedColumn<int> get balanceAfterPaise => $composableBuilder(
    column: $table.balanceAfterPaise,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawSmsBody => $composableBuilder(
    column: $table.rawSmsBody,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dedupeHash => $composableBuilder(
    column: $table.dedupeHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get upiRef =>
      $composableBuilder(column: $table.upiRef, builder: (column) => column);

  GeneratedColumn<bool> get isFlagged =>
      $composableBuilder(column: $table.isFlagged, builder: (column) => column);

  GeneratedColumn<String> get flagReason => $composableBuilder(
    column: $table.flagReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagStatus =>
      $composableBuilder(column: $table.tagStatus, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CyclesTableAnnotationComposer get cycleId {
    final $$CyclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cycleId,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableAnnotationComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PayeesTableAnnotationComposer get payeeId {
    final $$PayeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableAnnotationComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({
            bool accountId,
            bool cycleId,
            bool categoryId,
            bool payeeId,
          })
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> cycleId = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<String> txnType = const Value.absent(),
                Value<String> classification = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> payeeId = const Value.absent(),
                Value<String> payeeName = const Value.absent(),
                Value<int?> balanceAfterPaise = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<String> rawSmsBody = const Value.absent(),
                Value<String> dedupeHash = const Value.absent(),
                Value<String?> upiRef = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                Value<String?> flagReason = const Value.absent(),
                Value<String> tagStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                accountId: accountId,
                cycleId: cycleId,
                amountPaise: amountPaise,
                txnType: txnType,
                classification: classification,
                categoryId: categoryId,
                payeeId: payeeId,
                payeeName: payeeName,
                balanceAfterPaise: balanceAfterPaise,
                timestamp: timestamp,
                receivedAt: receivedAt,
                rawSmsBody: rawSmsBody,
                dedupeHash: dedupeHash,
                upiRef: upiRef,
                isFlagged: isFlagged,
                flagReason: flagReason,
                tagStatus: tagStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                Value<String?> cycleId = const Value.absent(),
                required int amountPaise,
                required String txnType,
                Value<String> classification = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> payeeId = const Value.absent(),
                required String payeeName,
                Value<int?> balanceAfterPaise = const Value.absent(),
                required DateTime timestamp,
                required DateTime receivedAt,
                required String rawSmsBody,
                required String dedupeHash,
                Value<String?> upiRef = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                Value<String?> flagReason = const Value.absent(),
                Value<String> tagStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                accountId: accountId,
                cycleId: cycleId,
                amountPaise: amountPaise,
                txnType: txnType,
                classification: classification,
                categoryId: categoryId,
                payeeId: payeeId,
                payeeName: payeeName,
                balanceAfterPaise: balanceAfterPaise,
                timestamp: timestamp,
                receivedAt: receivedAt,
                rawSmsBody: rawSmsBody,
                dedupeHash: dedupeHash,
                upiRef: upiRef,
                isFlagged: isFlagged,
                flagReason: flagReason,
                tagStatus: tagStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, Transaction>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                cycleId = false,
                categoryId = false,
                payeeId = false,
              }) {
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
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$TransactionsTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (cycleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cycleId,
                            referencedTable: $$TransactionsTableReferences
                                ._cycleIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._cycleIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$TransactionsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (payeeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.payeeId,
                            referencedTable: $$TransactionsTableReferences
                                ._payeeIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._payeeIdTable(db)
                                .id,
                          ) as T;
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

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({
        bool accountId,
        bool cycleId,
        bool categoryId,
        bool payeeId,
      })
    >;
typedef $$RecurringRulesTableCreateCompanionBuilder =
    RecurringRulesCompanion Function({
      required String id,
      required String payeeId,
      required String accountId,
      required int medianAmountPaise,
      required String toleranceType,
      required int cadenceDays,
      required String status,
      Value<int?> dueDayOfMonth,
      Value<DateTime?> lastDebitedDate,
      Value<int> rowid,
    });
typedef $$RecurringRulesTableUpdateCompanionBuilder =
    RecurringRulesCompanion Function({
      Value<String> id,
      Value<String> payeeId,
      Value<String> accountId,
      Value<int> medianAmountPaise,
      Value<String> toleranceType,
      Value<int> cadenceDays,
      Value<String> status,
      Value<int?> dueDayOfMonth,
      Value<DateTime?> lastDebitedDate,
      Value<int> rowid,
    });

final class $$RecurringRulesTableReferences
    extends BaseReferences<_$AppDatabase, $RecurringRulesTable, RecurringRule> {
  $$RecurringRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PayeesTable _payeeIdTable(_$AppDatabase db) =>
      db.payees.createAlias('recurring_rules__payee_id__payees__id');

  $$PayeesTableProcessedTableManager get payeeId {
    final $_column = $_itemColumn<String>('payee_id')!;

    final manager = $$PayeesTableTableManager(
      $_db,
      $_db.payees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('recurring_rules__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringRulesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringRulesTable> {
  $$RecurringRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get medianAmountPaise => $composableBuilder(
    column: $table.medianAmountPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toleranceType => $composableBuilder(
    column: $table.toleranceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cadenceDays => $composableBuilder(
    column: $table.cadenceDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDayOfMonth => $composableBuilder(
    column: $table.dueDayOfMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastDebitedDate => $composableBuilder(
    column: $table.lastDebitedDate,
    builder: (column) => ColumnFilters(column),
  );

  $$PayeesTableFilterComposer get payeeId {
    final $$PayeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableFilterComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringRulesTable> {
  $$RecurringRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get medianAmountPaise => $composableBuilder(
    column: $table.medianAmountPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toleranceType => $composableBuilder(
    column: $table.toleranceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cadenceDays => $composableBuilder(
    column: $table.cadenceDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDayOfMonth => $composableBuilder(
    column: $table.dueDayOfMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastDebitedDate => $composableBuilder(
    column: $table.lastDebitedDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$PayeesTableOrderingComposer get payeeId {
    final $$PayeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableOrderingComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringRulesTable> {
  $$RecurringRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get medianAmountPaise => $composableBuilder(
    column: $table.medianAmountPaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toleranceType => $composableBuilder(
    column: $table.toleranceType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cadenceDays => $composableBuilder(
    column: $table.cadenceDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get dueDayOfMonth => $composableBuilder(
    column: $table.dueDayOfMonth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastDebitedDate => $composableBuilder(
    column: $table.lastDebitedDate,
    builder: (column) => column,
  );

  $$PayeesTableAnnotationComposer get payeeId {
    final $$PayeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payeeId,
      referencedTable: $db.payees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayeesTableAnnotationComposer(
            $db: $db,
            $table: $db.payees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringRulesTable,
          RecurringRule,
          $$RecurringRulesTableFilterComposer,
          $$RecurringRulesTableOrderingComposer,
          $$RecurringRulesTableAnnotationComposer,
          $$RecurringRulesTableCreateCompanionBuilder,
          $$RecurringRulesTableUpdateCompanionBuilder,
          (RecurringRule, $$RecurringRulesTableReferences),
          RecurringRule,
          PrefetchHooks Function({bool payeeId, bool accountId})
        > {
  $$RecurringRulesTableTableManager(
    _$AppDatabase db,
    $RecurringRulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> payeeId = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> medianAmountPaise = const Value.absent(),
                Value<String> toleranceType = const Value.absent(),
                Value<int> cadenceDays = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> dueDayOfMonth = const Value.absent(),
                Value<DateTime?> lastDebitedDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringRulesCompanion(
                id: id,
                payeeId: payeeId,
                accountId: accountId,
                medianAmountPaise: medianAmountPaise,
                toleranceType: toleranceType,
                cadenceDays: cadenceDays,
                status: status,
                dueDayOfMonth: dueDayOfMonth,
                lastDebitedDate: lastDebitedDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String payeeId,
                required String accountId,
                required int medianAmountPaise,
                required String toleranceType,
                required int cadenceDays,
                required String status,
                Value<int?> dueDayOfMonth = const Value.absent(),
                Value<DateTime?> lastDebitedDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringRulesCompanion.insert(
                id: id,
                payeeId: payeeId,
                accountId: accountId,
                medianAmountPaise: medianAmountPaise,
                toleranceType: toleranceType,
                cadenceDays: cadenceDays,
                status: status,
                dueDayOfMonth: dueDayOfMonth,
                lastDebitedDate: lastDebitedDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecurringRulesTable, RecurringRule>(table),
                  $$RecurringRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({payeeId = false, accountId = false}) {
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
                    if (payeeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.payeeId,
                        referencedTable: $$RecurringRulesTableReferences
                            ._payeeIdTable(db),
                        referencedColumn: $$RecurringRulesTableReferences
                            ._payeeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$RecurringRulesTableReferences
                            ._accountIdTable(db),
                        referencedColumn: $$RecurringRulesTableReferences
                            ._accountIdTable(db)
                            .id,
                      ) as T;
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

typedef $$RecurringRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringRulesTable,
      RecurringRule,
      $$RecurringRulesTableFilterComposer,
      $$RecurringRulesTableOrderingComposer,
      $$RecurringRulesTableAnnotationComposer,
      $$RecurringRulesTableCreateCompanionBuilder,
      $$RecurringRulesTableUpdateCompanionBuilder,
      (RecurringRule, $$RecurringRulesTableReferences),
      RecurringRule,
      PrefetchHooks Function({bool payeeId, bool accountId})
    >;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String id,
  required String title,
  required int targetPaise,
  Value<int> savedPaise,
  Value<int> priorityOrder,
  Value<bool> isActive,
  Value<bool> isPaused,
  Value<DateTime?> targetDate,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> targetPaise,
  Value<int> savedPaise,
  Value<int> priorityOrder,
  Value<bool> isActive,
  Value<bool> isPaused,
  Value<DateTime?> targetDate,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetPaise => $composableBuilder(
    column: $table.targetPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savedPaise => $composableBuilder(
    column: $table.savedPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityOrder => $composableBuilder(
    column: $table.priorityOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetPaise => $composableBuilder(
    column: $table.targetPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savedPaise => $composableBuilder(
    column: $table.savedPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityOrder => $composableBuilder(
    column: $table.priorityOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get targetPaise => $composableBuilder(
    column: $table.targetPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get savedPaise => $composableBuilder(
    column: $table.savedPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priorityOrder => $composableBuilder(
    column: $table.priorityOrder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
          Goal,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> targetPaise = const Value.absent(),
                Value<int> savedPaise = const Value.absent(),
                Value<int> priorityOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                title: title,
                targetPaise: targetPaise,
                savedPaise: savedPaise,
                priorityOrder: priorityOrder,
                isActive: isActive,
                isPaused: isPaused,
                targetDate: targetDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int targetPaise,
                Value<int> savedPaise = const Value.absent(),
                Value<int> priorityOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                title: title,
                targetPaise: targetPaise,
                savedPaise: savedPaise,
                priorityOrder: priorityOrder,
                isActive: isActive,
                isPaused: isPaused,
                targetDate: targetDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalsTable, Goal>(table),
                  BaseReferences<_$AppDatabase, $GoalsTable, Goal>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
      Goal,
      PrefetchHooks Function()
    >;
typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  required String id,
  required String entityType,
  required String entityId,
  required String noteText,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<String> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> noteText,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteText => $composableBuilder(
    column: $table.noteText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteText => $composableBuilder(
    column: $table.noteText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get noteText =>
      $composableBuilder(column: $table.noteText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
          Note,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> noteText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                noteText: noteText,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required String noteText,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                noteText: noteText,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotesTable, Note>(table),
                  BaseReferences<_$AppDatabase, $NotesTable, Note>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
      Note,
      PrefetchHooks Function()
    >;
typedef $$NudgeLogsTableCreateCompanionBuilder = NudgeLogsCompanion Function({
  required String id,
  required String nudgeType,
  required String numbersPayloadJson,
  Value<String?> userAction,
  Value<DateTime> timestamp,
  Value<int> rowid,
});
typedef $$NudgeLogsTableUpdateCompanionBuilder = NudgeLogsCompanion Function({
  Value<String> id,
  Value<String> nudgeType,
  Value<String> numbersPayloadJson,
  Value<String?> userAction,
  Value<DateTime> timestamp,
  Value<int> rowid,
});

class $$NudgeLogsTableFilterComposer
    extends Composer<_$AppDatabase, $NudgeLogsTable> {
  $$NudgeLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nudgeType => $composableBuilder(
    column: $table.nudgeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numbersPayloadJson => $composableBuilder(
    column: $table.numbersPayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userAction => $composableBuilder(
    column: $table.userAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NudgeLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $NudgeLogsTable> {
  $$NudgeLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nudgeType => $composableBuilder(
    column: $table.nudgeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numbersPayloadJson => $composableBuilder(
    column: $table.numbersPayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userAction => $composableBuilder(
    column: $table.userAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NudgeLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NudgeLogsTable> {
  $$NudgeLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nudgeType =>
      $composableBuilder(column: $table.nudgeType, builder: (column) => column);

  GeneratedColumn<String> get numbersPayloadJson => $composableBuilder(
    column: $table.numbersPayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userAction => $composableBuilder(
    column: $table.userAction,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$NudgeLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NudgeLogsTable,
          NudgeLog,
          $$NudgeLogsTableFilterComposer,
          $$NudgeLogsTableOrderingComposer,
          $$NudgeLogsTableAnnotationComposer,
          $$NudgeLogsTableCreateCompanionBuilder,
          $$NudgeLogsTableUpdateCompanionBuilder,
          (NudgeLog, BaseReferences<_$AppDatabase, $NudgeLogsTable, NudgeLog>),
          NudgeLog,
          PrefetchHooks Function()
        > {
  $$NudgeLogsTableTableManager(_$AppDatabase db, $NudgeLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NudgeLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NudgeLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NudgeLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nudgeType = const Value.absent(),
                Value<String> numbersPayloadJson = const Value.absent(),
                Value<String?> userAction = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NudgeLogsCompanion(
                id: id,
                nudgeType: nudgeType,
                numbersPayloadJson: numbersPayloadJson,
                userAction: userAction,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nudgeType,
                required String numbersPayloadJson,
                Value<String?> userAction = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NudgeLogsCompanion.insert(
                id: id,
                nudgeType: nudgeType,
                numbersPayloadJson: numbersPayloadJson,
                userAction: userAction,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NudgeLogsTable, NudgeLog>(table),
                  BaseReferences<_$AppDatabase, $NudgeLogsTable, NudgeLog>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NudgeLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NudgeLogsTable,
      NudgeLog,
      $$NudgeLogsTableFilterComposer,
      $$NudgeLogsTableOrderingComposer,
      $$NudgeLogsTableAnnotationComposer,
      $$NudgeLogsTableCreateCompanionBuilder,
      $$NudgeLogsTableUpdateCompanionBuilder,
      (NudgeLog, BaseReferences<_$AppDatabase, $NudgeLogsTable, NudgeLog>),
      NudgeLog,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      required String settingKey,
      required String settingValueJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<String> settingKey,
      Value<String> settingValueJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settingValueJson => $composableBuilder(
    column: $table.settingValueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settingValueJson => $composableBuilder(
    column: $table.settingValueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get settingKey => $composableBuilder(
    column: $table.settingKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get settingValueJson => $composableBuilder(
    column: $table.settingValueJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTable,
          UserSetting,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSetting,
            BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
          ),
          UserSetting,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> settingKey = const Value.absent(),
                Value<String> settingValueJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion(
                settingKey: settingKey,
                settingValueJson: settingValueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String settingKey,
                required String settingValueJson,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                settingKey: settingKey,
                settingValueJson: settingValueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserSettingsTable, UserSetting>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserSettingsTable,
                    UserSetting
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTable,
      UserSetting,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSetting,
        BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
      ),
      UserSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db, _db.banks);
  $$BankTemplatesTableTableTableManager get bankTemplatesTable =>
      $$BankTemplatesTableTableTableManager(_db, _db.bankTemplatesTable);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$SalarySourcesTableTableManager get salarySources =>
      $$SalarySourcesTableTableManager(_db, _db.salarySources);
  $$CyclesTableTableManager get cycles =>
      $$CyclesTableTableManager(_db, _db.cycles);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$PayeesTableTableManager get payees =>
      $$PayeesTableTableManager(_db, _db.payees);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$RecurringRulesTableTableManager get recurringRules =>
      $$RecurringRulesTableTableManager(_db, _db.recurringRules);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$NudgeLogsTableTableManager get nudgeLogs =>
      $$NudgeLogsTableTableManager(_db, _db.nudgeLogs);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
}
