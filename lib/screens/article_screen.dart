import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';

class ArticleScreen extends StatefulWidget {
  final String articleTitle;

  ArticleScreen({required this.articleTitle});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String _content = '';

  @override
  void initState() {
    super.initState();
    _fetchArticleContent();
  }

  void _fetchArticleContent() async {
    try {
      final content = await ApiService.fetchArticleContent(widget.articleTitle);
      setState(() {
        _content = content;
      });
    } catch (e) {
      print('Failed to load article content: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleTitle),
        backgroundColor: Colors.blueAccent,
      ),
      body: _content.isNotEmpty
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _content,
                style: TextStyle(fontSize: 16.0),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}