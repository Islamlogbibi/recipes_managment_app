import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../models/recipe.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = _loadRecipes();
  }

  Future<List<Recipe>> _loadRecipes() async {
    return await DatabaseHelper.instance.getAllRecipes();
  }

  void _deleteRecipe(int id, String title) async {
    await DatabaseHelper.instance.delete(id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recipe "$title" deleted successfully.')),
      );
      // Reload the list
      setState(() {
        _recipesFuture = _loadRecipes();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Recipe'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found.'));
          } else {
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  title: Text(recipe.title),
                  subtitle: Text('ID: ${recipe.id} | Keywords: ${recipe.keywords}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(recipe),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _confirmDelete(Recipe recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete the recipe "${recipe.title}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _deleteRecipe(recipe.id!, recipe.title);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
