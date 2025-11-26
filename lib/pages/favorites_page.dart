import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/database_helper.dart';
import '../widgets/recipe_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Recipe>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = _loadFavorites();
  }

  Future<List<Recipe>> _loadFavorites() async {
    return DatabaseHelper.instance.getFavoriteRecipes();
  }

  void _toggleFavorite(Recipe recipe) async {
    // Toggle the favorite status (which will remove it from this list)
    await DatabaseHelper.instance.toggleFavorite(recipe.id!, !recipe.isFavorite);
    
    // Reload the list to reflect the change
    setState(() {
      _favoritesFuture = _loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'You have no favorite recipes yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return RecipeCard(
                  recipe: recipe,
                  onFavoriteToggle: () => _toggleFavorite(recipe),
                );
              },
            );
          }
        },
      ),
    );
  }
}
