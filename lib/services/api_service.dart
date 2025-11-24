import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_124230168/models/meal_model.dart'; // Import sesuai project

class ApiService {
  // 1. Get Categories
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> list = data['categories'];
      return list.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal load kategori');
    }
  }

  // 2. Get Meals by Category
  Future<List<MealModel>> getMealsByCategory(String categoryName) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> list = data['meals'];
      return list.map((e) => MealModel.fromJsonLite(e)).toList();
    } else {
      throw Exception('Gagal load meals');
    }
  }

  // 3. Get Meal Detail
  Future<MealModel> getMealDetail(String id) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> list = data['meals'];
      return MealModel.fromJsonDetail(list[0]);
    } else {
      throw Exception('Gagal load detail');
    }
  }
}