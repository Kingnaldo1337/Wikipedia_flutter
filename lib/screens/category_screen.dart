import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'article_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  CategoryScreen({required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> _articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  void _fetchArticles() async {
    try {
      final articles = await ApiService.fetchArticlesByCategory(widget.category);
      setState(() {
        _articles = articles;
      });
    } catch (e) {
      print('Failed to load articles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles in ${widget.category}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _articles.isNotEmpty
          ? ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(_articles[index]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleScreen(
                              articleTitle: _articles[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}