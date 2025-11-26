import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/database_helper.dart';
import '../widgets/toast_message.dart';

class AddEditPage extends StatefulWidget {
  final Recipe? recipeToEdit;

  const AddEditPage({super.key, this.recipeToEdit});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _stepsController;
  late TextEditingController _keywordsController;
  late TextEditingController _imagePathController;

  bool get isEditing => widget.recipeToEdit != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipeToEdit?.title ?? '');
    _stepsController = TextEditingController(text: widget.recipeToEdit?.steps ?? '');
    _keywordsController = TextEditingController(text: widget.recipeToEdit?.keywords ?? '');
    _imagePathController = TextEditingController(text: widget.recipeToEdit?.imagePath ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _stepsController.dispose();
    _keywordsController.dispose();
    _imagePathController.dispose();
    super.dispose();
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        id: widget.recipeToEdit?.id,
        title: _titleController.text,
        steps: _stepsController.text,
        keywords: _keywordsController.text,
        imagePath: _imagePathController.text.isEmpty ? null : _imagePathController.text,
      );

      if (isEditing) {
        await DatabaseHelper.instance.update(newRecipe);
        showToast(context, 'Recipe "${newRecipe.title}" updated successfully!');
      } else {
        await DatabaseHelper.instance.insert(newRecipe);
        showToast(context, 'Recipe "${newRecipe.title}" added successfully!');
        // Clear the form after adding
        _titleController.clear();
        _stepsController.clear();
        _keywordsController.clear();
        _imagePathController.clear();
      }
      
      if (mounted && isEditing) {
        Navigator.pop(context, true); // Return true to indicate a change
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Recipe' : 'Add New Recipe'),
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
                  labelText: 'Keywords (max 30 chars, e.g., Dessert, Algerian)',
                  border: OutlineInputBorder(),
                ),
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one keyword/category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imagePathController,
                decoration: const InputDecoration(
                  labelText: 'Image Path/URL (Optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _saveRecipe,
                icon: Icon(isEditing ? Icons.save : Icons.add),
                label: Text(isEditing ? 'Save Changes' : 'Add Recipe', style: const TextStyle(fontSize: 18)),
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
