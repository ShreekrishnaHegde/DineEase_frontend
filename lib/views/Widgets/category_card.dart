import 'package:flutter/material.dart';

import '../../models/Category.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  const CategoryCard({
    required this.category
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
