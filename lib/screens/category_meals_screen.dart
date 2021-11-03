import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;
  // CategoryMealScreen(this.categoryId, this.categoryTitle);

  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _isInitDataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_isInitDataLoaded) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'] as String;
      final categoryid = routeArgs['id'] as String;
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryid);
      }).toList();
      _isInitDataLoaded = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
