import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_article.dart';
import '../widgets/news_card.dart';
import '../string_extensions.dart';
import 'bookmarks_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsArticle> articles = [];
  int currentIndex = 0;
  String category = "national"; // Default category

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final url = 'https://gnews.io/api/v4/top-headlines?topic=$category&lang=en&token=7c8855b303c3e7b42faaf0992ab2920d';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['articles'];
        setState(() {
          articles = data.map((json) => NewsArticle.fromJson(json)).toList();
        });
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Failed to fetch news: $e');
    }
  }

  void nextArticle() {
    setState(() {
      currentIndex = (currentIndex + 1) % articles.length;
    });
  }

  void previousArticle() {
    setState(() {
      currentIndex = (currentIndex - 1 + articles.length) % articles.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "News",
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.white), // Three horizontal lines
            onSelected: (value) {
              if (value == 'bookmarks') {
                // Navigate to the bookmarks screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookmarksScreen()),
                );
              } else {
                // Update the category and fetch news
                setState(() {
                  category = value;
                  currentIndex = 0;
                  fetchNews();
                });
              }
            },
            itemBuilder: (BuildContext context) => [
              ...[
                'general',
                'world',
                'nation',
                'business',
                'technology',
                'entertainment',
                'sports',
                'science',
                'health',
              ].map((category) => PopupMenuItem<String>(
                value: category,
                child: Text(
                  category.capitalizeFirstOfEach(),
                  style: TextStyle(fontFamily: 'Times New Roman'),
                ),
              )),
              const PopupMenuDivider(), // Divider above "Saved Bookmarks"
              PopupMenuItem<String>(
                value: 'bookmarks',
                child: Row(
                  children: [
                    Icon(Icons.bookmark, color: Colors.red),
                    SizedBox(width: 8),
                    Text("Saved Bookmarks"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy > 0) {
            previousArticle();
          } else {
            nextArticle();
          }
        },
        child: Container(
          color: Colors.white, // White background for the body
          child: Center(
            child: NewsCard(article: articles[currentIndex]),
          ),
        ),
      ),
    );
  }
}
