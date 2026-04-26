import 'package:flutter/material.dart';
import 'package:news/home/category_fragment/category_fragment.dart';
import 'package:news/home/drawer/home_drawer.dart';

import 'category_details/category_details.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hoome',style: Theme.of(context).textTheme.labelMedium,), centerTitle: true),
      drawer: HomeDrawer(
        onHomePress: () {
        },
      ),
      body: CategoryFragment(),
    );
  }
}
