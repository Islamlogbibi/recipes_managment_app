import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../services/database_helper.dart';
import '../services/theme_provider.dart';
import '../utils/constants.dart';
import '../widgets/recipe_card.dart';
import 'add_edit_page.dart';
import 'favorites_page.dart';
import 'search_page.dart';
import 'delete_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = recipeCategories.first;
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = _loadRecipes();
  }

  Future<List<Recipe>> _loadRecipes() async {
    return DatabaseHelper.instance.getAllRecipes();
  }

  void _toggleFavorite(Recipe recipe) async {
    await DatabaseHelper.instance.toggleFavorite(recipe.id!, !recipe.isFavorite);
    setState(() {
      _recipesFuture = _loadRecipes(); // Reload to update favorite status
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme(themeProvider.themeMode != ThemeMode.dark);
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search Recipes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add New Recipe'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditPage())).then((_) {
                  setState(() {
                    _recipesFuture = _loadRecipes();
                  });
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Recipe'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DeletePage())).then((_) {
                  setState(() {
                    _recipesFuture = _loadRecipes();
                  });
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Category Filter Chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recipeCategories.length,
              itemBuilder: (context, index) {
                final category = recipeCategories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : recipeCategories.first;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: _recipesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No recipes found.'));
                } else {
                  final allRecipes = snapshot.data!;
                  final filteredRecipes = _selectedCategory == 'All'
                      ? allRecipes
                      : allRecipes.where((r) => r.keywords.toLowerCase().contains(_selectedCategory.toLowerCase())).toList();

                  if (filteredRecipes.isEmpty) {
                    return Center(child: Text('No $_selectedCategory recipes found.'));
                  }

                  return ListView.builder(
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return RecipeCard(
                        recipe: recipe,
                        onFavoriteToggle: () => _toggleFavorite(recipe),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditPage()),
          ).then((_) {
            setState(() {
              _recipesFuture = _loadRecipes();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
