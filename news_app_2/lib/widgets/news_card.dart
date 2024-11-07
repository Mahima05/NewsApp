import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/news_article.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  // Customizable style properties for title and description
  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;

  NewsCard({
    required this.article,
    this.titleTextStyle = const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Times New Roman'),
    this.descriptionTextStyle = const TextStyle(fontSize: 20,fontWeight: FontWeight.normal, color: Colors.black54, fontFamily: 'Times New Roman'),
  });

  // Method to save bookmark
  Future<void> saveBookmark(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];

    // Convert the article to JSON and save it
    bookmarks.add(jsonEncode({
      'title': article.title,
      'description': article.description,
      'urlToImage': article.urlToImage,
    }));
    await prefs.setStringList('bookmarks', bookmarks);

    // Show a snackbar confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bookmarked successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(article.urlToImage),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(article.title, style: titleTextStyle), // Apply title style
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(article.description, style: descriptionTextStyle), // Apply description style
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () => saveBookmark(context),
          ),
        ],
      ),
    );
  }
}
