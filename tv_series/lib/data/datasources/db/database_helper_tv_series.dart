import 'dart:async';
import 'package:core/core.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tv_series/tv_series.dart';

class DatabaseHelperTvSeries {
  static DatabaseHelperTvSeries? _databaseHelper;

  DatabaseHelperTvSeries._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperTvSeries() =>
      _databaseHelper ?? DatabaseHelperTvSeries._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistTvSeries = 'watchlist_tv_series';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_tvseries.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('123456'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTvSeries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTvSeries(TvSeriesTable tvSeriesTable) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvSeries, tvSeriesTable.toJson());
  }

  Future<int> removeWatchlistTvSeries(TvSeriesTable tvSeriesTable) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [tvSeriesTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistTvSeries);

    return results;
  }
}
