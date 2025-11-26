import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../models/recipe.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _stepsController = TextEditingController();
  final _keywordsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _stepsController.dispose();
    _keywordsController.dispose();
    super.dispose();
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        title: _titleController.text,
        steps: _stepsController.text,
        keywords: _keywordsController.text,
      );

      int id = await DatabaseHelper.instance.insert(newRecipe);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recipe "${newRecipe.title}" added with ID: $id')),
        );
        // Clear the form
        _titleController.clear();
        _stepsController.clear();
        _keywordsController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Recipe'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title (max 30 chars)',
                  border: OutlineInputBorder(),
                ),
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stepsController,
                decoration: const InputDecoration(
                  labelText: 'Steps (max 300 chars)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                maxLength: 300,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the steps';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _keywordsController,
                decoration: const InputDecoration(
                  labelText: 'Keywords (max 30 chars, e.g., pasta, italian)',
                  border: OutlineInputBorder(),
                ),
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one keyword';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _saveRecipe,
                icon: const Icon(Icons.save),
                label: const Text('Save Recipe', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
