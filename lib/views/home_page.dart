import 'package:flutter/material.dart';
import 'package:recyceling_app/views/qr_scanner_page.dart';

import 'faq_page.dart';
import 'item_search_page.dart';
import 'location_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ItemSearchPage(),
    LocationPage(),
    QrScannerPage(),
    FaqPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 92,
        child: BottomNavigationBar(
          backgroundColor: Color(0xFF8DD0DD),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF1A441D),
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info_outline,
                  size: 40,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on,
                  size: 40,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 40,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.question_answer,
                  size: 40,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }
}
