class Recipe {
  int? id;
  String title;
  String steps;
  String keywords; // Used for categories/tags
  String? imagePath; // Optional path/URL for the recipe image
  bool isFavorite; // Stored in SharedPreferences

  Recipe({
    this.id,
    required this.title,
    required this.steps,
    required this.keywords,
    this.imagePath,
    this.isFavorite = false,
  });

  // Convert a Recipe object into a Map for SQLite insertion/update.
  // Note: imagePath and isFavorite are NOT stored in the Recette table.
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'TITRE': title,
      'ETAPES': steps,
      'keywords': keywords,
    };
  }

  // Convert a Map from SQLite into a Recipe object.
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['ID'],
      title: map['TITRE'],
      steps: map['ETAPES'],
      keywords: map['keywords'],
      // imagePath and isFavorite will be loaded separately or remain null/false
    );
  }

  // Helper method to create a copy with updated favorite status
  Recipe copyWith({bool? isFavorite}) {
    return Recipe(
      id: id,
      title: title,
      steps: steps,
      keywords: keywords,
      imagePath: imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() {
    return 'Recipe{id: $id, title: $title, steps: $steps, keywords: $keywords, imagePath: $imagePath, isFavorite: $isFavorite}';
  }
}
