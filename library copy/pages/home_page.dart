import 'package:flutter/material.dart';
import 'search_page.dart';
import 'add_page.dart';
import 'delete_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe App - Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildMenuButton(
              context,
              'Search Recipes',
              const SearchPage(),
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              'Add New Recipe',
              const AddPage(),
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              'Delete Recipe',
              const DeletePage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Widget page) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
