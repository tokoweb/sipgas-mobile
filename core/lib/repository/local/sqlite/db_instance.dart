import 'package:data/util/table_sariangin.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  Future<Database> initDb() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), Util.DATABASE_NAME),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return _createDb(db);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return database;
  }

  static void _createDb(Database db) {
    db.execute(
      'CREATE TABLE ${Util.TABLE_SCAN_TUBE} (${Util.ENTITY_ID} INTEGER PRIMARY KEY AUTOINCREMENT, ${Util.ENTITY_TUBE_ID} INTEGER, ${Util.ENTITY_TUBE_CATEGORY_ID} INTEGER, ${Util.ENTITY_TUBE_CATEGORY_NAME} TEXT, ${Util.ENTITY_TUBE_SERIAL_NUMBER} TEXT, ${Util.ENTITY_TUBE_STATUS} TEXT, ${Util.ENTITY_TUBE_LOCATION} TEXT, ${Util.ENTITY_TUBE_NOTE} TEXT, ${Util.ENTITY_TUBE_USER_ID} TEXT)',
    );
    db.execute(
      'CREATE TABLE ${Util.TABLE_NOTE} (${Util.ENTITY_ID} INTEGER PRIMARY KEY AUTOINCREMENT, ${Util.ENTITY_NOTE_DESC} TEXT, ${Util.ENTITY_NOTE_NAME} TEXT)',
    );
  }
}
