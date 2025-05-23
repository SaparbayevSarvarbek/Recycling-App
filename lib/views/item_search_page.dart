import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recyceling_app/models/category_model.dart';

import '../widgets/category_card.dart';

class ItemSearchPage extends StatefulWidget implements PreferredSizeWidget {
  final Size preferredSize;

  ItemSearchPage({Key? key})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);

  @override
  State<ItemSearchPage> createState() => _ItemSearchPageState();
}

class _ItemSearchPageState extends State<ItemSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<CategoryModel> filteredCategories = [];
  final List<CategoryModel> categories = [
    CategoryModel(1, "PLASTIC", "assets/images/plastic.png"),
    CategoryModel(2, "METAL", "assets/images/metal.png"),
    CategoryModel(3, "CARDBOARD", "assets/images/cardboard.png"),
    CategoryModel(4, "BATTERY", "assets/images/battery.png"),
    CategoryModel(5, "PAPER", "assets/images/paper.png"),
    CategoryModel(6, "GLASS", "assets/images/glass.png"),
    CategoryModel(7, "Electric", "assets/images/electric.png"),
    CategoryModel(8, "ORGANIC", "assets/images/organic.png"),
  ];

  void _filterSearch() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredCategories = [];
      } else {
        filteredCategories = categories.where((category) {
          return category.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          ),
        ),
        title: Text(
          'ITEM SEARCH',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFC6E5BA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Search By Item:',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'EX) MILK BOTTLE',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Color(0xFF70B458),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              filteredCategories = [];
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    GestureDetector(
                      onTap: _filterSearch,
                      child: Container(
                        width: 49,
                        height: 49,
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      "Search By Category:",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (filteredCategories.isEmpty) ...[
                    SizedBox(
                      height: 177.34,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: CategoryCard(
                              category: categories[index],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 177.34,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: CategoryCard(
                              category: categories[index + 4],
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      height: 177.34,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredCategories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: CategoryCard(
                              category: filteredCategories[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
