import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsi_124230168/models/meal_model.dart';
import 'package:responsi_124230168/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String mealId;

  const DetailScreen({super.key, required this.mealId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  MealModel? _meal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    try {
      final data = await ApiService().getMealDetail(widget.mealId);
      setState(() {
        _meal = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _launchYoutube(String url) async {
    if (url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak bisa buka link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meal Detail")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meal == null
              ? const Center(child: Text("Data Kosong"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(_meal!.thumbnail),
                      const SizedBox(height: 10),
                      Text(_meal!.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("Category: ${_meal!.category} | Area: ${_meal!.area}"),
                      const Divider(),
                      const Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold)),
                      ..._meal!.ingredients.map((e) => Text("- $e")),
                      const SizedBox(height: 10),
                      const Text("Instructions", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(_meal!.instructions, textAlign: TextAlign.justify),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchYoutube(_meal!.youtubeUrl),
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Tonton Tutorial"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}