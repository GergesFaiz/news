import 'package:flutter/material.dart';
import 'package:news/home/category_fragment/category_fragment.dart';
import 'package:news/home/drawer/home_drawer.dart';
import 'package:news/home/search/search_screen.dart';
import 'package:news/model/Category.dart';

import 'category_details/category_details.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? 'News' : selectedCategory!.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).splashColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      drawer: HomeDrawer(onDrawerClick: onHomePress),
      body: selectedCategory == null
          ? CategoryFragment(onCategoryClick: onCategoryClick)
          : CategoryDetails(category: selectedCategory!),
    );
  }

  void onCategoryClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  void onHomePress() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
