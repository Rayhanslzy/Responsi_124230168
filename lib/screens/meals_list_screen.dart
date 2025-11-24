import 'package:flutter/material.dart';
import 'package:responsi_124230168/models/meal_model.dart';
import 'package:responsi_124230168/services/api_service.dart';
import 'package:responsi_124230168/screens/detail_screen.dart'; // Navigasi ke Detail

class MealsListScreen extends StatefulWidget {
  final String categoryName;

  const MealsListScreen({super.key, required this.categoryName});

  @override
  State<MealsListScreen> createState() => _MealsListScreenState();
}

class _MealsListScreenState extends State<MealsListScreen> {
  List<MealModel> _meals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    try {
      final data = await ApiService().getMealsByCategory(widget.categoryName);
      setState(() {
        _meals = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.categoryName} Meals")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _meals.length,
              itemBuilder: (context, index) {
                final meal = _meals[index];
                return InkWell(
                  onTap: () {
                    // Navigasi ke Detail dengan membawa ID Makanan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(mealId: meal.id)),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: Image.network(meal.thumbnail, fit: BoxFit.cover)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(meal.name, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}