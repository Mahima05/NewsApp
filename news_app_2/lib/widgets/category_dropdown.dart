import 'package:flutter/material.dart';
import '../string_extensions.dart';

class CategoryDropdown extends StatefulWidget {
  final Function(String) onCategorySelected;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final String fontFamily;

  CategoryDropdown({
    required this.onCategorySelected,
    this.fontSize = 18.0,
    this.fontColor = Colors.black,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Times New Roman',
  });

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final List<String> categories = [
    "general",
    "world",
    "nation", // Default category
    "business",
    "technology",
    "entertainment",
    "sports",
    "science",
    "health",
  ];

  String selectedCategory = "nation"; // Default category

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCategory,
      icon: Icon(Icons.arrow_upward), // Arrow facing up
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value.capitalizeFirstOfEach(),
            style: TextStyle(
              fontSize: widget.fontSize,
              color: widget.fontColor,
              fontWeight: widget.fontWeight,
              fontFamily: widget.fontFamily,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            selectedCategory = newValue; // Update the displayed category
          });
          widget.onCategorySelected(newValue);
        }
      },
    );
  }
}


