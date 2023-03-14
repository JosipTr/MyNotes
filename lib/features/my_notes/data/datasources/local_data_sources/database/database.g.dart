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
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `content` TEXT, `date` TEXT, `isSelected` INTEGER, `isDeleted` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Sort` (`id` INTEGER NOT NULL, `sortType` TEXT NOT NULL, PRIMARY KEY (`id`))');

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
  )   : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'date': item.date,
                  'isSelected': item.isSelected == null
                      ? null
                      : (item.isSelected! ? 1 : 0),
                  'isDeleted':
                      item.isDeleted == null ? null : (item.isDeleted! ? 1 : 0)
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'date': item.date,
                  'isSelected': item.isSelected == null
                      ? null
                      : (item.isSelected! ? 1 : 0),
                  'isDeleted':
                      item.isDeleted == null ? null : (item.isDeleted! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  @override
  Future<List<Note>> getNotes(String sortType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Note WHERE isDeleted=0 ORDER BY CASE ?1 WHEN "title" THEN title WHEN "date" THEN date ELSE title END',
        mapper: (Map<String, Object?> row) => Note(id: row['id'] as int?, title: row['title'] as String?, content: row['content'] as String?, date: row['date'] as String?, isSelected: row['isSelected'] == null ? null : (row['isSelected'] as int) != 0, isDeleted: row['isDeleted'] == null ? null : (row['isDeleted'] as int) != 0),
        arguments: [sortType]);
  }

  @override
  Future<List<Note>> getDeletedNotes(String sortType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Note WHERE isDeleted=1ORDER BY CASE ?1 WHEN "title" THEN title WHEN "date" THEN date ELSE title END',
        mapper: (Map<String, Object?> row) => Note(id: row['id'] as int?, title: row['title'] as String?, content: row['content'] as String?, date: row['date'] as String?, isSelected: row['isSelected'] == null ? null : (row['isSelected'] as int) != 0, isDeleted: row['isDeleted'] == null ? null : (row['isDeleted'] as int) != 0),
        arguments: [sortType]);
  }

  @override
  Future<List<Note>> getSearchedNotes(String searchValue) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Note WHERE title LIKE ?1 OR content LIKE ?1',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            title: row['title'] as String?,
            content: row['content'] as String?,
            date: row['date'] as String?,
            isSelected: row['isSelected'] == null
                ? null
                : (row['isSelected'] as int) != 0,
            isDeleted: row['isDeleted'] == null
                ? null
                : (row['isDeleted'] as int) != 0),
        arguments: [searchValue]);
  }

  @override
  Future<void> unselectAllNotes() async {
    await _queryAdapter.queryNoReturn('UPDATE Note SET isSelected=0');
  }

  @override
  Future<void> selectAllNotes() async {
    await _queryAdapter
        .queryNoReturn('UPDATE Note SET isSelected=1 WHERE isDeleted=0');
  }

  @override
  Future<void> selectNote(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Note SET isSelected=CASE WHEN isSelected=1 THEN 0 ELSE 1 END WHERE id=?1',
        arguments: [id]);
  }

  @override
  Future<void> setNoteDeleted() async {
    await _queryAdapter
        .queryNoReturn('UPDATE Note SET isDeleted=1 WHERE isSelected=1');
  }

  @override
  Future<void> setNoteUndeleted() async {
    await _queryAdapter
        .queryNoReturn('UPDATE Note SET isDeleted=0 WHERE isSelected=1');
  }

  @override
  Future<void> removeNotes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Note WHERE isDeleted=true');
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNoteContent(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }
}

class _$SortDao extends SortDao {
  _$SortDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sortInsertionAdapter = InsertionAdapter(
            database,
            'Sort',
            (Sort item) =>
                <String, Object?>{'id': item.id, 'sortType': item.sortType});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sort> _sortInsertionAdapter;

  @override
  Future<String?> getSortType() async {
    return _queryAdapter.query('SELECT sortType FROM Sort WHERE id=1',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<void> updateSortType(String sortType) async {
    await _queryAdapter.queryNoReturn('UPDATE Sort SET sortType=?1 WHERE id=1',
        arguments: [sortType]);
  }

  @override
  Future<void> insertSort(Sort sort) async {
    await _sortInsertionAdapter.insert(sort, OnConflictStrategy.abort);
  }
}
