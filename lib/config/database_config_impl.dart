// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_config.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DatabaseConfig> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DatabaseConfig();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseConfig extends DatabaseConfig {
  _$DatabaseConfig([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: migrationScripts.length,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          await database.execute(migrationScripts[i]!);
        }

        // await MigrationAdapter.runMigrations(
        //     database, oldVersion, newVersion, migrations);
        //
        // await callback?.onUpgrade?.call(database, oldVersion, newVersion);
      },
      onCreate: (database, version) async {
        for (int i = 1; i <= migrationScripts.length; i++) {
          await database.execute(migrationScripts[i]!);
        }

        // await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  ProfileDao? _profileDao;
  @override
  ProfileDao get profileDao =>
      _profileDao ??=
          ProfileDaoImpl(database, changeListener);

  PengaturanAutocodeAndroidDao? _pengaturanAutocodeAndroidDao;
  @override
  PengaturanAutocodeAndroidDao get pengaturanAutocodeAndroidDao =>
      _pengaturanAutocodeAndroidDao ??=
          PengaturanAutocodeAndroidDaoImpl(database, changeListener);

  MasterReasonTypeDao? _masterReasonTypeDao;
  @override
  MasterReasonTypeDao get masterReasonTypeDao =>
      _masterReasonTypeDao ??=
          MasterReasonTypeDaoImpl(database, changeListener);

  MasterReasonHcDao? _masterReasonHcDao;
  @override
  MasterReasonHcDao get masterReasonHcDao =>
      _masterReasonHcDao ??=
          MasterReasonHcDaoImpl(database, changeListener);

  MasterPicDao? _masterPicDao;
  @override
  MasterPicDao get masterPicDao =>
      _masterPicDao ??=
          MasterPicDaoImpl(database, changeListener);

  MasterAuthMenuDao? _masterAuthMenuDao;
  @override
  MasterAuthMenuDao get masterAuthMenuDao =>
      _masterAuthMenuDao ??=
          MasterAuthMenuDaoImpl(database, changeListener);
}
