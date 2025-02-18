import 'package:sqflite/sqflite.dart';

import '../../constants/storage_constants.dart';

class DatabaseConfig {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      StorageConstants.databaseName,
      version: 1,
      onCreate: (Database db, _) async {
        await db.execute(StorageConstants.cartCreateCommand);
      },
    );

    return _database!;
  }

  Future<void> closeDatabase() async {
    await _database?.close();
  }
}
