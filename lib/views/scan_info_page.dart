import 'package:flutter/material.dart';

import '../models/category_item.dart';
import '../services/db_helper.dart';

class ScanInfoPage extends StatefulWidget {
  final String scannedData;

  const ScanInfoPage({super.key, required this.scannedData});

  @override
  State<ScanInfoPage> createState() => _ScanInfoPageState();
}

class _ScanInfoPageState extends State<ScanInfoPage> {
  int? groupId;
  List<CategoryItem> filteredList = [];
  CategoryItem? item;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    if (widget.scannedData.isNotEmpty) {
      groupId = int.tryParse(widget.scannedData[0]);
    }

    if (groupId == null) {
      setState(() {
        isLoading = false;
        filteredList = [];
        item = null;
      });
      return;
    }

    final dbHelper = DBHelper();
    final data = await dbHelper.getCategoriesByGroup(groupId!);

    setState(() {
      filteredList = data;
      item = filteredList.isNotEmpty ? filteredList[0] : null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Yuklanayotgan holat
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (item == null) {
      return Scaffold(
        backgroundColor: Colors.redAccent,
        body: const Center(
          child: Text(
            "Ma'lumot topilmadi",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFA3D9A5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item!.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Description:",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                item!.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              const Text(
                "Category:",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                item!.groupId == 1
                    ? "PLASTIC"
                    : item!.groupId == 2
                    ? "METAL"
                    : item!.groupId == 3
                    ? "PAPER"
                    : "UNKNOWN",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF62B053),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  elevation: 5,
                ),
                child: const Text(
                  "GOT IT",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

