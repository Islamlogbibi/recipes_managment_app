import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/database_helper.dart';
import '../widgets/recipe_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // The searchRecipes method in DatabaseHelper already searches by Title, Keywords, and Steps.
    final results = await DatabaseHelper.instance.searchRecipes(query.trim());

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  void _toggleFavorite(Recipe recipe) async {
    await DatabaseHelper.instance.toggleFavorite(recipe.id!, !recipe.isFavorite);
    // Re-run the search to update the favorite status in the list
    _performSearch(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Title, Keywords, or Steps',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _performSearch(_searchController.text),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              onSubmitted: _performSearch,
            ),
          ),
          _isSearching
              ? const LinearProgressIndicator()
              : Expanded(
                  child: _searchResults.isEmpty
                      ? Center(
                          child: Text(
                            _searchController.text.isEmpty
                                ? 'Enter a query to search for recipes.'
                                : 'No recipes found for "${_searchController.text}"',
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final recipe = _searchResults[index];
                            return RecipeCard(
                              recipe: recipe,
                              onFavoriteToggle: () => _toggleFavorite(recipe),
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}
