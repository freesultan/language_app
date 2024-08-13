import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final _databaseName = "FlashcardDB.db";
  static final _databaseVersion = 1;

  static final table = 'flashcards';

  static final columnId = 'id';
  static final columnFrontText = 'front_text';
  static final columnBackText = 'back_text';
  static final columnStatus = 'status';
  static final columnLastReviewed = 'last_reviewed';

  DatabaseHelper._privateConstructor() {
    print('DatabaseHelper private constructor called');
  }
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print('Returning existing database instance');
      return _database!;
    }
    print('Initializing new database instance');
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    print('Creating new database');
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('Creating tables in the database');
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnFrontText TEXT NOT NULL,
        $columnBackText TEXT NOT NULL,
        $columnStatus TEXT NOT NULL,
        $columnLastReviewed TEXT
      )
    ''');
    print('Database tables created');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    print('Inserting row: $row');
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    print('Querying all rows');
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    print('Updating row with id $id: $row');
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }
}
