# Recipe App Report

## 1. Project Overview

The Recipe App is a mobile application built with **Flutter** and **SQLite**. It allows users to browse a collection of recipes, mark recipes as favorites, and quickly access their favorite recipes. The app demonstrates database management, persistent storage, and a clean, interactive UI.

## 2. Objectives

1. Display a collection of recipes in a structured and visually appealing way.
2. Allow users to search recipes by title, keywords, or steps.
3. Enable users to mark recipes as favorites.
4. Persist favorite status across app sessions using **SharedPreferences**.
5. Pre-fill the app with a set of static recipes for immediate use.

## 3. Technology Stack

* **Programming Language:** Dart
* **Framework:** Flutter
* **Database:** SQLite (via `sqflite` package)
* **Persistent Storage for Favorites:** SharedPreferences
* **Platform:** Android / iOS
* **Assets:** Local images stored in `assets/images/` folder

## 4. Architecture

### 4.1 Database Structure

**Table:** `Recette`

| Column Name | Type                              | Description                       |
| ----------- | --------------------------------- | --------------------------------- |
| `ID`        | INTEGER PRIMARY KEY AUTOINCREMENT | Unique identifier for each recipe |
| `TITRE`     | TEXT                              | Recipe title                      |
| `ETAPES`    | TEXT                              | Step-by-step instructions         |
| `keywords`  | TEXT                              | Keywords for searching/filtering  |
| `imagePath` | TEXT                              | Path to recipe image in assets    |

**Favorites:**

* Stored in **SharedPreferences**, using a list of recipe IDs (`favorites`).
* No additional database table is used for favorites.

### 4.2 Data Initialization

* The app includes a file `static_recipes.dart` containing 16 pre-defined recipes.
* On first run, the database is pre-filled with these recipes.
* Recipes are only inserted if the table is empty to prevent overwriting user data.

### 4.3 Features

1. **Recipe Listing**

   * Displays all recipes in a scrollable list using `ListView.builder`.
   * Each recipe shows title, image, and a favorite toggle.

2. **Favorites Management**

   * Users can mark/unmark recipes as favorite.
   * Favorite status is persisted via `SharedPreferences`.
   * Favorites page displays only the recipes marked as favorite.

3. **Search Functionality**

   * Users can search recipes by title, keywords, or steps.
   * Partial matches are supported using SQL `LIKE`.

4. **Responsive UI**

   * Uses `RecipeCard` widget for consistent display of recipes.
   * Tapping favorite icon immediately updates UI.

## 5. Program Flow

1. **App Launch**

   * Database initialized via `DatabaseHelper`.
   * `staticRecipes` are pre-filled if table is empty.

2. **Recipe Listing**

   * `getAllRecipes()` fetches all recipes from the database.
   * `isFavorite` is checked from SharedPreferences.

3. **Favorite Toggle**

   * Tapping heart icon calls `toggleFavorite()` in `DatabaseHelper`.
   * Updates SharedPreferences and UI instantly.

4. **Favorites Page**

   * Shows all favorited recipes.
   * Removing a recipe from favorites instantly removes it from the list.

5. **Search**

   * Queries SQLite with `LIKE` to match title, keywords, or steps.
   * Favorites are still respected during search.

## 6. Challenges & Solutions

| Challenge                                  | Solution                                                                      |
| ------------------------------------------ | ----------------------------------------------------------------------------- |
| Static recipes not showing after first run | Added check to insert recipes only if the table is empty.                     |
| Favorites persistence                      | Stored favorite IDs in SharedPreferences, removed SQLite join for simplicity. |
| Instant UI updates when toggling favorites | Updated the in-memory list instead of reloading the database every time.      |

## 7. Future Improvements

1. Add categories/tags for better filtering.
2. Support remote sync so favorites persist across devices.
3. Allow users to add their own recipes.
4. Improve UI with animations and better image handling.
5. Add rating and review system for recipes.

## 8. Conclusion

The Recipe App demonstrates a simple yet functional mobile application integrating **Flutter**, **SQLite**, and **SharedPreferences**. It showcases database management, persistent state, and reactive UI design. Users can browse, search, and favorite recipes with smooth and immediate feedback.
