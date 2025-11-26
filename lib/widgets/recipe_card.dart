import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../pages/recipe_detail_page.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onFavoriteToggle;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe: recipe),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image (Placeholder)
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              ),
              child: Center(
                child: recipe.imagePath != null && recipe.imagePath!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                      child: Image.asset(
                        recipe.imagePath!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Keywords: ${recipe.keywords}',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: recipe.isFavorite ? Colors.red : null,
                        ),
                        onPressed: onFavoriteToggle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
