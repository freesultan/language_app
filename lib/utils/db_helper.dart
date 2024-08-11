import 'dart:async';
import 'dart:io' show Platform, Directory;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Future<Database> database() async {
    print('DBHelper: Initializing database');

    if (kIsWeb) {
      print('DBHelper: Running on Web');
      try {
        final db = await openDatabase(
          'user.db',
          version: 1,
          onCreate: (db, version) async {
            print('DBHelper: Creating users table on Web');
            try {
              await db.execute(
                'CREATE TABLE users(username TEXT PRIMARY KEY, password TEXT)',
              ).timeout(Duration(seconds: 10));
              print('DBHelper: Users table created on Web');
            } catch (e) {
              print('DBHelper: Error executing table creation on Web: $e');
              rethrow;
            }
          },
        ).timeout(Duration(seconds: 10));
        return db;
      } catch (e) {
        print('DBHelper: Error creating database on Web: $e');
        rethrow;
      }
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      print('DBHelper: Running on Desktop');
      try {
        sqfliteFfiInit();
        var databaseFactory = databaseFactoryFfi;
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, 'user.db');
        print('DBHelper: Opening database at $path on Desktop');
        final db = await databaseFactory.openDatabase(
          path,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              print('DBHelper: Creating users table on Desktop');
              try {
                await db.execute(
                  'CREATE TABLE users(username TEXT PRIMARY KEY, password TEXT)',
                ).timeout(Duration(seconds: 10));
                print('DBHelper: Users table created on Desktop');
              } catch (e) {
                print('DBHelper: Error executing table creation on Desktop: $e');
                rethrow;
              }
            },
          ),
        ).timeout(Duration(seconds: 10));
        return db;
      } catch (e) {
        print('DBHelper: Error creating database on Desktop: $e');
        rethrow;
      }
    } else {
      print('DBHelper: Running on Mobile');
      try {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, 'user.db');
        print('DBHelper: Opening database at $path on Mobile');
        final db = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            print('DBHelper: Creating users table on Mobile');
            try {
              await db.execute(
                'CREATE TABLE users(username TEXT PRIMARY KEY, password TEXT)',
              ).timeout(Duration(seconds: 10));
              print('DBHelper: Users table created on Mobile');
            } catch (e) {
              print('DBHelper: Error executing table creation on Mobile: $e');
              rethrow;
            }
          },
        ).timeout(Duration(seconds: 10));
        return db;
      } catch (e) {
        print('DBHelper: Error creating database on Mobile: $e');
        rethrow;
      }
    }
  }

  static Future<void> saveUser(String username, String password) async {
    print('DBHelper: Saving user $username');
    try {
      final db = await DBHelper.database();
      print('DBHelper: Database opened, inserting user');
      await db.insert(
        'users',
        {'username': username, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('DBHelper: User saved: $username');
    } catch (e) {
      print('DBHelper: Error saving user $username: $e');
    }
  }

  static Future<Map<String, dynamic>?> getUser(String username, String password) async {
    print('DBHelper: Retrieving user $username');
    try {
      final db = await DBHelper.database();
      print('DBHelper: Database opened, querying user');
      final users = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      if (users.isNotEmpty) {
        print('DBHelper: User found: ${users.first}');
        return users.first;
      } else {
        print('DBHelper: User not found: $username');
      }
    } catch (e) {
      print('DBHelper: Error retrieving user $username: $e');
    }
    return null;
  }
}
