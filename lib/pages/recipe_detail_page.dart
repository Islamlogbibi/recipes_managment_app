import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'add_edit_page.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Recipe _currentRecipe;

  @override
  void initState() {
    super.initState();
    _currentRecipe = widget.recipe;
  }

  void _navigateToEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditPage(recipeToEdit: _currentRecipe),
      ),
    );

    // If the edit page returned true, it means the recipe was updated.
    if (result == true) {
      // Since we don't have a direct way to fetch the single updated recipe
      // without a dedicated service method, we'll rely on the Home/Search page
      // to refresh the list when navigating back. For simplicity, we'll pop
      // the detail page to force a refresh on the previous screen.
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentRecipe.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEditPage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Recipe Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              child: Center(
                child: _currentRecipe.imagePath != null && _currentRecipe.imagePath!.isNotEmpty
                    ? Text(
                        'Image Placeholder: ${_currentRecipe.imagePath}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      )
                    : Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _currentRecipe.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const Text(
              'Keywords/Categories:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Wrap(
              spacing: 8.0,
              children: _currentRecipe.keywords.split(',').map((keyword) {
                return Chip(label: Text(keyword.trim()));
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Steps:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              _currentRecipe.steps,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
