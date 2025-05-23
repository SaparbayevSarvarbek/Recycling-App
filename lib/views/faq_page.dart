import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC6E5BA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(45),
          ),
        ),
        title: Text(
          'FORUM',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'FAQs:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SeoulNamsan'),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BulletText('WHAT ARE SOME ITEMS WE SHOULD NEVER RECYCLE?'),
                    BulletText(
                        'WHAT IS COMPOSTING AND HOW IS IT BENEFICIAL FOR THE ENVIRONMENT?'),
                    BulletText('HOW CAN I RECYCLE HOUSEHOLD HAZARDOUS WASTE?'),
                    BulletText('WHERE DO I RECYCLE ELECTRONICS?'),
                    BulletText('HOW DO I PROPERLY RECYCLE SHARP ITEMS?'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'QUICK TIPS & TRICKS:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SeoulNamsan'),
            ),
            const SizedBox(height: 18),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BulletText(
                        'REMEMBER TO CLEAN OUT THE ITEMS BEFORE RECYCLING!'),
                    SizedBox(height: 4),
                    Text(
                      '*RECYCLING ITEMS AND CONTAINERS THAT STILL HAVE FOOD ON THEM CAN CONTAMINATE AN ENTIRE TRUCKLOAD OF RECYCLING PRODUCTS! MAKE SURE ALL PRODUCTS ARE EMPTY, CLEAN, AND DRY BEFORE RECYCLING!',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A441D),
                          fontFamily: 'SeoulNamsan'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  final String text;

  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1A441D),
                  fontFamily: 'SeoulNamsan')),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF1A441D),
                      fontFamily: 'SeoulNamsan'))),
        ],
      ),
    );
  }
}
