// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
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
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  SortDao? _sortDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `date` TEXT NOT NULL, `isSelected` INTEGER NOT NULL, `isDeleted` INTEGER NOT NULL, `isFavorite` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SortModel` (`id` INTEGER NOT NULL, `sortType` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  SortDao get sortDao {
    return _sortDaoInstance ??= _$SortDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _noteModelInsertionAdapter = InsertionAdapter(
            database,
            'NoteModel',
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date': item.date,
                  'isSelected': item.isSelected ? 1 : 0,
                  'isDeleted': item.isDeleted ? 1 : 0,
                  'isFavorite': item.isFavorite ? 1 : 0
                },
            changeListener),
        _noteModelUpdateAdapter = UpdateAdapter(
            database,
            'NoteModel',
            ['id'],
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date': item.date,
                  'isSelected': item.isSelected ? 1 : 0,
                  'isDeleted': item.isDeleted ? 1 : 0,
                  'isFavorite': item.isFavorite ? 1 : 0
                },
            changeListener),
        _noteModelDeletionAdapter = DeletionAdapter(
            database,
            'NoteModel',
            ['id'],
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date': item.date,
                  'isSelected': item.isSelected ? 1 : 0,
                  'isDeleted': item.isDeleted ? 1 : 0,
                  'isFavorite': item.isFavorite ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteModel> _noteModelInsertionAdapter;

  final UpdateAdapter<NoteModel> _noteModelUpdateAdapter;

  final DeletionAdapter<NoteModel> _noteModelDeletionAdapter;

  @override
  Stream<List<NoteModel>> getNotes() {
    return _queryAdapter.queryListStream('SELECT * FROM NoteModel',
        mapper: (Map<String, Object?> row) => NoteModel(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            date: row['date'] as String,
            isSelected: (row['isSelected'] as int) != 0,
            isDeleted: (row['isDeleted'] as int) != 0,
            isFavorite: (row['isFavorite'] as int) != 0),
        queryableName: 'NoteModel',
        isView: false);
  }

  @override
  Future<void> insertNote(NoteModel noteModel) async {
    await _noteModelInsertionAdapter.insert(
        noteModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(NoteModel noteModel) async {
    await _noteModelUpdateAdapter.update(noteModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeNote(NoteModel noteModel) async {
    await _noteModelDeletionAdapter.delete(noteModel);
  }
}

class _$SortDao extends SortDao {
  _$SortDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sortModelInsertionAdapter = InsertionAdapter(
            database,
            'SortModel',
            (SortModel item) =>
                <String, Object?>{'id': item.id, 'sortType': item.sortType});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SortModel> _sortModelInsertionAdapter;

  @override
  Future<String?> getSortType() async {
    return _queryAdapter.query('SELECT sortType FROM SortModel WHERE id=1',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<void> updateSort(String sortType) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE SortModel SET sortType=?1 WHERE id=1',
        arguments: [sortType]);
  }

  @override
  Future<void> insertSort(SortModel sort) async {
    await _sortModelInsertionAdapter.insert(sort, OnConflictStrategy.abort);
  }
}
