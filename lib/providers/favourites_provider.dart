import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteNotifier extends StateNotifier<List<Meal>> {
  FavouriteNotifier() : super([]);

  bool toggleFavouriteStatus(Meal meal) {
    final isFavourite = state.contains(meal);
    if (isFavourite) {
      state
          .where((element) => element.id != meal.id)
          .toList(); // to remove a meal
      return false;
    } else {
      state = [...state, meal];
      return true; // adds individual elements to the list
    }
  }
}

final favouritesProvider =
    StateNotifierProvider<FavouriteNotifier, List<Meal>>((ref) {
  return FavouriteNotifier();
}); // used when data is changing and not static
