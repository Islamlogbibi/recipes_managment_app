import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'models/recipe.dart';

class DatabaseHelper {
  static const _databaseName = "RecipeDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'Recette';

  static const columnId = 'ID';
  static const columnTitle = 'TITRE';
  static const columnSteps = 'ETAPES';
  static const columnKeywords = 'keywords';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database or create it if it doesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle VARCHAR(30) NOT NULL,
            $columnSteps VARCHAR(300) NOT NULL,
            $columnKeywords VARCHAR(30) NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a recipe into the database.
  Future<int> insert(Recipe recipe) async {
    Database db = await instance.database;
    return await db.insert(table, recipe.toMap());
  }

  // Searches for recipes by title or keywords.
  Future<List<Recipe>> searchRecipes(String query) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: '$columnTitle LIKE ? OR $columnKeywords LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );

    if (maps.isNotEmpty) {
      return maps.map((map) => Recipe.fromMap(map)).toList();
    }
    return [];
  }

  // Deletes the recipe with the given id.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Retrieves all recipes (for the delete page list).
  Future<List<Recipe>> getAllRecipes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return maps.map((map) => Recipe.fromMap(map)).toList();
  }
}
