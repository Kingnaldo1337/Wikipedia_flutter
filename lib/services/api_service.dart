import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://en.wikipedia.org/w/api.php';

  static Future<List<String>> fetchSpecificCategories() async {
    List<String> specificCategories = ['History', 'Music', 'News', 'Health', 'Technology'];
    return specificCategories;
  }

  static Future<List<String>> fetchArticlesByCategory(String category) async {
    final url = '$_baseUrl?action=query&list=categorymembers&cmtitle=Category:$category&cmlimit=10&format=json';
    print('Fetching articles for category $category from: $url');
    
    final response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> articles = (data['query']['categorymembers'] as List)
          .map((article) => article['title'] as String)
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  static Future<String> fetchArticleContent(String title) async {
    final url = '$_baseUrl?action=query&prop=extracts&exintro&titles=$title&format=json';
    print('Fetching content for article $title from: $url');
    
    final response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pages = data['query']['pages'];
      final page = pages.values.first;
      final extract = page['extract'];
      return extract ?? 'No content available';
    } else {
      throw Exception('Failed to load article content');
    }
  }
}