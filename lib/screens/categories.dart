import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/data/data.dart';
import 'package:meals_app/models/category.dart';

import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/grid_items.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = meals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); //filtering meals

    if (meals.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MealsScreen(title: category.title, meals: filteredMeals)));
    } else {
      _selectEmptyCategory(context);
    }
  }

  void _selectEmptyCategory(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: ((context) => CupertinoAlertDialog(
                title: const Text('No Meals'),
                content: const Text(
                    'Hmmm... nothing seems to be here. Try another category!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Okay',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ])));
  }

  @override
  Widget build(context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Categories'),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      body: GridView(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width < 800 ? 2 : 4,
          childAspectRatio: 4 / 4,
          crossAxisSpacing: width < 800 ? 16 : 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            GridItems(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
