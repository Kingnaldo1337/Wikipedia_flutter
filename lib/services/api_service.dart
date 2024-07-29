import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://en.wikipedia.org/w/api.php';

  static Future<List<String>> fetchCategories() async {
    final url =
        '$_baseUrl?action=query&list=allcategories&aclimit=10&format=json';
    print('Fetching categories from: $url');

    final response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> categories = (data['query']['allcategories'] as List)
          .map((category) => category['*'] as String)
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<String>> fetchArticlesByCategory(String category) async {
    final url =
        '$_baseUrl?action=query&list=categorymembers&cmtitle=Category:$category&cmlimit=10&format=json';
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
}
