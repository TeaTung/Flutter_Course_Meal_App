import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    if (isLoaded == true) return;
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    displayedMeals = widget.availableMeals.where((item) {
      return item.categories.contains(categoryId);
    }).toList();
    isLoaded = true;
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(
        () => {displayedMeals!.removeWhere((element) => element.id == mealId)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
              id: displayedMeals![index].id,
              title: displayedMeals![index].title,
              imgUrl: displayedMeals![index].imageUrl,
              complexity: displayedMeals![index].complexity,
              affordability: displayedMeals![index].affordability,
              duration: displayedMeals![index].duration);
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
