import 'package:flutter/material.dart';
import '../models/category_item.dart';
import '../services/db_helper.dart';
import '../widgets/first_widget.dart';
import '../widgets/second_widget.dart';

class PlasticPage extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;

  const PlasticPage({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
  });

  @override
  State<PlasticPage> createState() => _PlasticPageState();
}

class _PlasticPageState extends State<PlasticPage> {
  List<CategoryItem> items = [];
  bool isLoading = true;
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadItems() async {
    final dbHelper = DBHelper();
    final data = await dbHelper.getCategoriesByGroup(widget.categoryId);
    setState(() {
      items = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryTitle,
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: items.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = items[index];
                  return index == 0
                      ? FirstInfoPage(
                    data: page,
                    currentPage: _currentPage,
                    totalPages: items.length,
                  )
                      : SecondInfoPage(
                    data: page,
                    currentPage: _currentPage,
                    totalPages: items.length,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
