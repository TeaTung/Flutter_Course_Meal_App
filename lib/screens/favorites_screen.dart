import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'You have no favorites yet - start adding some!',
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favoriteMeals![index].id,
            title: favoriteMeals![index].title,
            imgUrl: favoriteMeals![index].imageUrl,
            complexity: favoriteMeals![index].complexity,
            affordability: favoriteMeals![index].affordability,
            duration: favoriteMeals![index].duration,
          );
        },
        itemCount: favoriteMeals!.length,
      );
    }
  }
}
