import 'package:flutter/material.dart';
import 'package:recyceling_app/models/category_model.dart';
import 'package:recyceling_app/views/plastic_page.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlasticPage(
                categoryId: category.id,
                categoryTitle: category.name,
              ),
            ),
          );
        },
      child: Container(
        width: 138.26,
        height: 177.34,
        decoration: BoxDecoration(
          color: Color(0xFF70B458),
          borderRadius: BorderRadius.circular(33),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.asset(category.imagePath, width: 97.39, height: 97.39),
          ],
        ),
      ),
    );
  }
}
