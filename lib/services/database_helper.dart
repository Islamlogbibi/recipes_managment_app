import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';
import 'static_recipes.dart';

class DatabaseHelper {
  static const _databaseName = "RecipeDatabase.db";
  static const _databaseVersion = 2;

  static const tableRecette = 'Recette';
  static const columnId = 'ID';
  static const columnTitle = 'TITRE';
  static const columnSteps = 'ETAPES';
  static const columnKeywords = 'keywords';
  static const columnImagePath = 'imagePath';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    Database db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    // --- DEVELOPMENT ONLY: force refresh static recipes ---
    // Comment this out after initial testing
    await db.delete(tableRecette); // clear old recipes
    await _prefillDatabase(db);    // insert fresh static recipes

    return db;
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableRecette (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnSteps TEXT NOT NULL,
        $columnKeywords TEXT NOT NULL,
        $columnImagePath TEXT
      )
    ''');

    await _prefillDatabase(db);
  }

  Future<void> _prefillDatabase(Database db) async {
    for (var recipe in staticRecipes) {
      await db.insert(tableRecette, {
        columnTitle: recipe.title,
        columnSteps: recipe.steps,
        columnKeywords: recipe.keywords,
        columnImagePath: recipe.imagePath,
      });
    }
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE $tableRecette ADD COLUMN $columnImagePath TEXT');
    }
  }

  // --- Recipe CRUD Operations ---

  Future<int> insert(Recipe recipe) async {
    Database db = await instance.database;
    return await db.insert(tableRecette, {
      columnTitle: recipe.title,
      columnSteps: recipe.steps,
      columnKeywords: recipe.keywords,
      columnImagePath: recipe.imagePath,
    });
  }

  Future<int> update(Recipe recipe) async {
    Database db = await instance.database;
    return await db.update(
      tableRecette,
      {
        columnTitle: recipe.title,
        columnSteps: recipe.steps,
        columnKeywords: recipe.keywords,
        columnImagePath: recipe.imagePath,
      },
      where: '$columnId = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableRecette,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Get all recipes + load favorite status from SharedPreferences
  Future<List<Recipe>> getAllRecipes() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableRecette);

    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorites') ?? [];

    return maps.map((map) {
      final recipe = Recipe(
        id: map[columnId],
        title: map[columnTitle],
        steps: map[columnSteps],
        keywords: map[columnKeywords],
        imagePath: map[columnImagePath],
      );
      recipe.isFavorite = favoriteIds.contains(recipe.id.toString());
      return recipe;
    }).toList();
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableRecette,
      where: '$columnTitle LIKE ? OR $columnKeywords LIKE ? OR $columnSteps LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );

    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorites') ?? [];

    return maps.map((map) {
      final recipe = Recipe(
        id: map[columnId],
        title: map[columnTitle],
        steps: map[columnSteps],
        keywords: map[columnKeywords],
        imagePath: map[columnImagePath],
      );
      recipe.isFavorite = favoriteIds.contains(recipe.id.toString());
      return recipe;
    }).toList();
  }

  // --- Favorites with SharedPreferences ---

  Future<void> toggleFavorite(int recipeId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorites') ?? [];

    if (isFavorite) {
      if (!favoriteIds.contains(recipeId.toString())) {
        favoriteIds.add(recipeId.toString());
      }
    } else {
      favoriteIds.remove(recipeId.toString());
    }

    await prefs.setStringList('favorites', favoriteIds);
  }

  Future<List<Recipe>> getFavoriteRecipes() async {
    final allRecipes = await getAllRecipes();
    return allRecipes.where((recipe) => recipe.isFavorite).toList();
  }
}
