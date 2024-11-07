import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/news_article.dart';

class BookmarksScreen extends StatefulWidget {
  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<NewsArticle> bookmarks = [];

  // Default font settings
  final String fontFamily = 'Times New Roman';
  final double headingFontSize = 18.0;
  final double textFontSize = 14.0;

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarksData = prefs.getStringList('bookmarks') ?? [];

    setState(() {
      bookmarks = bookmarksData.map((bookmark) {
        final json = jsonDecode(bookmark);
        return NewsArticle(
          title: json['title'],
          description: json['description'],
          urlToImage: json['urlToImage'],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Bookmarks",
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: bookmarks.isEmpty
          ? Center(
        child: Text(
          "No bookmarks saved.",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      )
          : ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final article = bookmarks[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: article.urlToImage.isNotEmpty
                  ? Image.network(article.urlToImage, width: 50, fit: BoxFit.cover)
                  : null,
              title: Text(
                article.title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              subtitle: Text(
                article.description,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: textFontSize,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
