import 'package:flutter/material.dart';

import '../models/category_item.dart';

class SecondInfoPage extends StatelessWidget {
  final CategoryItem data;
  final int currentPage;
  final int totalPages;

  const SecondInfoPage(
      {super.key,
      required this.data,
      required this.currentPage,
      required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFA2CE92),
      child: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 16),
              child: Image.asset(data.imagePath,
                  height: 165, alignment: Alignment.center),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    data.title,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Image.asset("assets/images/underline.png"),
                  const SizedBox(height: 15),
                  Text(data.description,
                      style: TextStyle(fontSize: 24, color: Colors.black54),
                      textAlign: TextAlign.center),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(totalPages, (index) {
                      final isSelected = index == currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Color(0xFF8DD0DD) : Colors.black12,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
