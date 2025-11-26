class Recipe {
  int? id;
  String title;
  String steps;
  String keywords;

  Recipe({
    this.id,
    required this.title,
    required this.steps,
    required this.keywords,
  });

  // Convert a Recipe object into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'TITRE': title,
      'ETAPES': steps,
      'keywords': keywords,
    };
  }

  // Implement toString to make it easier to see information about
  // each recipe when using the print statement.
  @override
  String toString() {
    return 'Recipe{id: $id, title: $title, steps: $steps, keywords: $keywords}';
  }

  // Convert a Map into a Recipe object.
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['ID'],
      title: map['TITRE'],
      steps: map['ETAPES'],
      keywords: map['keywords'],
    );
  }
}
