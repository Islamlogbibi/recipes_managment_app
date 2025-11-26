import '../models/recipe.dart';

final List<Recipe> staticRecipes = [
  // --- Desserts ---
  Recipe(
    title: 'Classic Brownie',
    steps: '1. Melt butter and chocolate. 2. Whisk in sugar and eggs. 3. Fold in flour and cocoa powder. 4. Bake at 175°C for 25 minutes.',
    keywords: 'Dessert, Chocolate, Baking, Cake',
    imagePath: 'assets/images/brownie.png',
  ),
  Recipe(
    title: 'Tiramisu',
    steps: '1. Whisk egg yolks and sugar. 2. Fold in mascarpone cheese. 3. Dip ladyfingers in coffee and rum. 4. Layer cream and ladyfingers. 5. Dust with cocoa powder and chill.',
    keywords: 'Dessert, Italian, Coffee, No-Bake',
    imagePath: 'assets/images/tiramisu.jpg',
  ),
  Recipe(
    title: 'No-Bake Cheesecake',
    steps: '1. Mix crushed biscuits with melted butter for the base. 2. Beat cream cheese, sugar, and vanilla. 3. Fold in whipped cream. 4. Pour over base and chill for 4 hours.',
    keywords: 'Dessert, No-Bake, Creamy',
    imagePath: 'assets/images/cheesecake.jpg',
  ),
  // --- Traditional Algerian Dishes ---
  Recipe(
    title: 'Couscous with Vegetables',
    steps: '1. Steam the couscous grains. 2. Cook lamb/chicken with onions, chickpeas, and spices (ras el hanout, turmeric). 3. Add vegetables (carrots, zucchini, turnip). 4. Serve the meat and vegetables over the steamed couscous.',
    keywords: 'Traditional, Algerian, Main Dish, Lamb',
    imagePath: 'assets/images/couscous.jpg',
  ),
  Recipe(
    title: 'Chakhchoukha',
    steps: '1. Prepare the Rgag (thin flatbread). 2. Cook a rich tomato and meat stew (often lamb or beef) with chickpeas and chili. 3. Tear the R\'gag into small pieces and mix with the hot stew before serving.',
    keywords: 'Traditional, Algerian, Spicy, Main Dish',
    imagePath: 'assets/images/chakhchoukha.jpg',
  ),
  Recipe(
    title: 'Dolma (Stuffed Vegetables)',
    steps: '1. Hollow out vegetables (zucchini, bell peppers, tomatoes). 2. Mix ground meat, rice, and spices for the stuffing. 3. Stuff the vegetables and cook them in a light tomato or lemon sauce.',
    keywords: 'Traditional, Algerian, Vegetables, Main Dish',
    imagePath: 'assets/images/dolma.jpg',
  ),
  Recipe(
    title: 'Rechta (Algerian Noodles)',
    steps: '1. Steam the fine rechta noodles. 2. Prepare a white sauce with chicken, turnips, and chickpeas, seasoned with cinnamon. 3. Serve the rechta with the chicken and sauce on top.',
    keywords: 'Traditional, Algerian, Noodles, Chicken',
    imagePath: 'assets/images/rechta.jpg',
  ),
  // --- Breakfast ---
  Recipe(
    title: 'Fluffy Pancakes',
    steps: '1. Whisk flour, sugar, baking powder, and salt. 2. Mix egg, milk, and melted butter. 3. Combine wet and dry ingredients. 4. Cook on a hot, lightly oiled griddle until golden brown.',
    keywords: 'Breakfast, Sweet, Quick',
    imagePath: 'assets/images/pancakes.jpg',
  ),
  Recipe(
    title: 'Cheese and Herb Omelette',
    steps: '1. Whisk eggs with salt, pepper, and chopped herbs (chives, parsley). 2. Pour into a hot, buttered pan. 3. Sprinkle with cheese. 4. Cook until set and fold in half.',
    keywords: 'Breakfast, Eggs, Quick, Savory',
    imagePath: 'assets/images/omelette.jpg',
  ),
  // --- Drinks ---
  Recipe(
    title: 'Strawberry Milkshake',
    steps: '1. Combine fresh strawberries, milk, vanilla ice cream, and a splash of vanilla extract in a blender. 2. Blend until smooth and creamy. 3. Pour into a tall glass and serve immediately.',
    keywords: 'Drinks, Sweet, Quick, Strawberry',
    imagePath: 'assets/images/milkshake.jpg',
  ),
  Recipe(
    title: 'Fresh Orange Juice',
    steps: '1. Cut oranges in half. 2. Squeeze the juice using a juicer. 3. Strain the juice to remove pulp (optional). 4. Serve chilled.',
    keywords: 'Drinks, Healthy, Quick, Citrus',
    imagePath: 'assets/images/orange_juice.jpg',
  ),
  // --- Quick Meals ---
  Recipe(
    title: 'Pizza Wrap',
    steps: '1. Spread pizza sauce on a tortilla wrap. 2. Sprinkle with mozzarella cheese, pepperoni, and your favorite toppings. 3. Fold the wrap and grill in a pan or press until cheese is melted and the wrap is crispy.',
    keywords: 'Quick Meal, Pizza, Wrap, Fast Food',
    imagePath: 'assets/images/pizza_wrap.jpg',
  ),
  Recipe(
    title: 'Classic Beef Burger',
    steps: '1. Season ground beef and form into patties. 2. Grill or pan-fry the patties. 3. Toast the buns. 4. Assemble with lettuce, tomato, onion, cheese, and sauce.',
    keywords: 'Quick Meal, Beef, Fast Food, Grill',
    imagePath: 'assets/images/burger.jpg',
  ),
  // --- Cakes & Baking ---
  Recipe(
    title: 'Lemon Drizzle Cake',
    steps: '1. Cream butter and sugar. 2. Beat in eggs and lemon zest. 3. Fold in flour. 4. Bake. 5. While warm, pour a lemon juice and sugar glaze over the top.',
    keywords: 'Cake, Baking, Dessert, Lemon',
    imagePath: 'assets/images/lemon_cake.jpg',
  ),
  // --- Salads ---
  Recipe(
    title: 'Mediterranean Quinoa Salad',
    steps: '1. Cook quinoa and let it cool. 2. Chop cucumber, tomatoes, red onion, and feta cheese. 3. Mix quinoa and vegetables. 4. Dress with olive oil, lemon juice, and herbs.',
    keywords: 'Salad, Healthy, Vegetarian, Quick',
    imagePath: 'assets/images/quinoa_salad.jpg',
  ),
  // --- Extra Recipes (Total 16) ---
  Recipe(
    title: 'Spicy Chicken Wings',
    steps: '1. Marinate wings in hot sauce, paprika, and garlic powder. 2. Bake at 200°C for 40 minutes, flipping halfway. 3. Toss in extra sauce before serving.',
    keywords: 'Appetizer, Spicy, Chicken, Grill',
    imagePath: 'assets/images/chicken_wings.jpg',
  ),
];
