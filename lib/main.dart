import 'package:flutter/material.dart';
import 'package:meal/screens/filter_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

import './screens/category_screen.dart';
import './screens/category_meals_screen.dart';
import './dummy_data.dart';
import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void _setFilter(Map<String, bool> filterData) {
    setState(
      () {
        _filters = filterData;
        _availableMeal = DUMMY_MEALS.where((meal) {
          if (_filters['gluten']! && !meal.isGlutenFree) return false;
          if (_filters['lactose']! && !meal.isLactoseFree) return false;
          if (_filters['vegan']! && !meal.isVegan) return false;
          if (_filters['vegetarian']! && !meal.isVegetarian) return false;
          return true;
        }).toList();
      },
    );
    print('You are elegant');
  }

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoritesMeal = [];

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoritesMeal.indexWhere(
      (meal) {
        return meal.id == mealId;
      },
    );
    if (existingIndex >= 0) {
      setState(
        () {
          _favoritesMeal.removeAt(existingIndex);
        },
      );
    } else {
      setState(
        () {
          _favoritesMeal.add(
            DUMMY_MEALS.firstWhere((element) => element.id == mealId),
          );
        },
      );
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritesMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delimeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                color: Color.fromRGBO(255, 242, 242, 1),
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsScreen(_favoritesMeal),
      routes: {
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(_filters, _setFilter),
      },
      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
