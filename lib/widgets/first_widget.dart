import 'package:flutter/material.dart';

import '../models/category_item.dart';

class FirstInfoPage extends StatelessWidget {
  final CategoryItem data;
  final int currentPage;
  final int totalPages;

  const FirstInfoPage({
    super.key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFA2CE92),
      child: Column(
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.only(top: 16),
                child: Image.asset(data.imagePath, height: 165)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'YES:',
                      style: TextStyle(color: Color(0xFF70B458), fontSize: 24),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      " · ${data.title}",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'NO:',
                      style: TextStyle(color: Color(0xFFD63D3D), fontSize: 24),
                    ),
                    const SizedBox(height: 5),
                    Text(" · ${data.description}",
                        style: TextStyle(fontSize: 24)),
                    Spacer(),
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
          ),
        ],
      ),
    );
  }
}
