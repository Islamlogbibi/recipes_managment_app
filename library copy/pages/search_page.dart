import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../models/recipe.dart';
import 'recipe_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _searchResults = [];
  bool _isSearching = false;

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final results = await DatabaseHelper.instance.searchRecipes(query);

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipes'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Title or Keywords',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _performSearch(_searchController.text),
                ),
                border: const OutlineInputBorder(),
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
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final recipe = _searchResults[index];
                            return ListTile(
                              title: Text(recipe.title),
                              subtitle: Text('Keywords: ${recipe.keywords}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailPage(recipe: recipe),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}
