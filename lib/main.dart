import 'package:flutter/material.dart';
import 'package:recyceling_app/services/db_helper.dart';
import 'package:recyceling_app/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/bin_model.dart';
import 'models/category_item.dart';
import 'models/instruction_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().database;
  await addInitialCategoriesOnce();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recyceling app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SeoulNamsan'),
      home: HomePage(),
    );
  }
}

Future<void> addInitialCategoriesOnce() async {
  final prefs = await SharedPreferences.getInstance();
  final isInserted = prefs.getBool('isCategoryInserted') ?? false;

  if (!isInserted) {
    final db = DBHelper();

    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/plastic.png',
      title:
          'Plastic bottles and containers coded #1-#7 Six or twelve pack rings',
      description:
          'Plastic bags and film electronic items insecticide and hazardous chemical containers',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/recycle1.png',
      title: 'POLYETHYLENE TEREPHTHALATE COMMON ITEMS: ',
      description:
          'Cosmetic Containers Plastic Bottles Mouthwash Bottles Prepared Food Trays',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/recycle2.png',
      title: 'HIGH-DENSITY POLYETHYLENE COMMON ITEMS:  ',
      description:
          'Detergent Bottles Grocery Bags Milk Bottles Shampoo Bottles',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/recycle3.png',
      title: 'POLYVINYL CHLORIDE COMMON ITEMS:  ',
      description: 'Garden Hose Window Frames Blood Bags Blister Packs',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/recycle4.png',
      title: 'LOW-DENSITY POLYETHYLENE COMMON ITEMS: ',
      description: '6 Packs Rings Cling Film Bread Bags Squeezble Bottles',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/recycle5.png',
      title: 'POLYETHYLENE COMMON ITEMS: ',
      description: 'Yogurt Containers Medicine Bottles Caps Straws',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/recycle6.png',
      title: 'POLYSTYRENE COMMON ITEMS:  ',
      description:
          'Disposable PLates/Cups Egg Cartons Meat Trays Take-out Containers',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 1,
      imagePath: 'assets/images/recycle7.png',
      title: 'OTHER PLASTICS COMMON ITEMS: :  ',
      description:
          'Sunglasses Nylon Bulletproof Materials 3 & 5 gallon water bottles',
    ));

    await db.insertCategory(CategoryItem(
      groupId: 2,
      imagePath: 'assets/images/metal.png',
      title:
          'Aluminum cans and foil Tin and steel cans including empty aerosol cans ',
      description: 'Needles or syringes',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 2,
      imagePath: 'assets/images/recycle8.png',
      title: 'STEEL COMMON ITEMS:  ',
      description: 'FOOD CANS',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 2,
      imagePath: 'assets/images/recycle9.png',
      title: 'ALUMINIUM COMMON ITEMS:  ',
      description:
          'SOFt drink cans deodorant cans disposable food containers aluminium foil heat sinks',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 3,
      imagePath: 'assets/images/cardboard.png',
      title: 'CClean corrugated cardboard',
      description:
          'Pizza Boxes Boxes with plastic film, wax, or other embellishments',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 3,
      imagePath: 'assets/images/recycle22.png',
      title: 'CORRUGATED FIBERBOARD COMMON ITEMS: ',
      description: 'food storage jars',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 4,
      imagePath: 'assets/images/battery.png',
      title: 'Battery',
      description: 'Boxes',
    ));

    await db.insertCategory(CategoryItem(
      groupId: 4,
      imagePath: 'assets/images/recycle10.png',
      title:
          'Mixed Paper: advertisements, direct mail, office paper, newspaper, catalogs, and telephone books',
      description:
          'Disposable diapers or rags soiled items such as pizza boxes, napkins, and tissues',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 5,
      imagePath: 'assets/images/paper.png',
      title:
          'Mixed Paper: advertisements, stationary, emvelopes, and telephone books',
      description:
          'Disposable diapers or rags soiled items such, napkins, and tissues',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 5,
      imagePath: 'assets/images/recycle10.png',
      title:
      'PAPERBOARD COMMON ITEMS: ',
      description:
      'cereal boxes snack boxes',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 5,
      imagePath: 'assets/images/recycle10.png',
      title:
      'PAPER COMMON ITEMS: ',
      description:
      'Newspaper books/magazines wrapping paper wallpaper paper bags paper straws',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 6,
      imagePath: 'assets/images/glass.png',
      title: 'Clear, green and brown glass bottles and jars',
      description: 'Window glass and mirror Compact fluorescent and other light bulbs Ceramics',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 6,
      imagePath: 'assets/images/recycle10.png',
      title:
      'CLEAR GLASS ITEMS: ',
      description:
      'food storage jars',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 6,
      imagePath: 'assets/images/recycle10.png',
      title:
      'GREEN GLASS ITEMS: ',
      description:
      'wine bottles',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 6,
      imagePath: 'assets/images/recycle10.png',
      title:
      'BROWN GLASS ITEMS: ',
      description:
      'beer, light-sensitive products',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 7,
      imagePath: 'assets/images/electric.png',
      title: 'Most electronic devices',
      description: 'LCD televisions and monitors Old televisions pre 1991',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 8,
      imagePath: 'assets/images/organic.png',
      title: 'Materials made out of wood, cork, cotton, and jute ',
      description: 'Items that have other materials than what is listed above',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 8,
      imagePath: 'assets/images/recycle10.png',
      title: 'WOOD COMMON ITEMS: ',
      description: 'Furniture chopping boards brooms pencils spoons ',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 8,
      imagePath: 'assets/images/recycle10.png',
      title: 'WOOD COMMON ITEMS: ',
      description: 'Furniture chopping boards brooms pencils spoons ',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 8,
      imagePath: 'assets/images/recycle10.png',
      title: 'CORK COMMON ITEMS: ',
      description: 'Bottle stoppers placemats construction material',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 8,
      imagePath: 'assets/images/recycle10.png',
      title: 'COTTON COMMON ITEMS: ',
      description: 'towels t-shirts swabs pads',
    ));
    await db.insertCategory(CategoryItem(
      groupId: 8,
      imagePath: 'assets/images/recycle10.png',
      title: 'JUTE COMMON ITEMS: ',
      description: 'Clothing',
    ));

    await DBHelper().insertBin(Bin(
      name: 'Location: 123 xxx Street, State College, PA ',
      description: 'Metal,Paper',
      latitude: 41.555314,
      longitude: 60.620246,
      imagePath: 'assets/images/bin.png',
      category: 'Cardboard Mixed Paper Plastic',
      instructions: [
        Instruction(
            binId: 0,
            name: 'For cardboard',
            imagePath: 'assets/images/in1.png'),
        Instruction(
            binId: 0, name: 'For plastic', imagePath: 'assets/images/in2.png'),
      ],
    ));
    await DBHelper().insertBin(Bin(
      name: 'Location: 123 xxx Street, State College, PA',
      description: 'Plastic Glass',
      latitude: 41.553018,
      longitude: 60.619688,
      imagePath: 'assets/images/bin.png',
      category: 'Mixed',
      instructions: [
        Instruction(
            binId: 1,
            name: 'For cardboard',
            imagePath: 'assets/images/in1.png'),
        Instruction(
            binId: 1, name: 'For plastic', imagePath: 'assets/images/in2.png'),
      ],
    ));
    await DBHelper().insertBin(Bin(
      name: 'Location: 123 xxx Street, State College, PA',
      description: 'Cardboard Glass',
      latitude: 41.554118,
      longitude: 60.618594,
      imagePath: 'assets/images/bin.png',
      category: 'Mixed',
      instructions: [
        Instruction(
            binId: 2,
            name: 'For cardboard',
            imagePath: 'assets/images/in1.png'),
        Instruction(
            binId: 2, name: 'For plastic', imagePath: 'assets/images/in2.png'),
      ],
    ));
    await DBHelper().insertBin(Bin(
      name: 'Location: 123 xxx Street, State College, PA',
      description: 'Paper Electric',
      latitude: 41.553331,
      longitude: 60.619345,
      imagePath: 'assets/images/bin.png',
      category: 'Mixed',
      instructions: [
        Instruction(
            binId: 3,
            name: 'For cardboard',
            imagePath: 'assets/images/in1.png'),
        Instruction(
            binId: 3, name: 'For plastic', imagePath: 'assets/images/in2.png'),
      ],
    ));
    await DBHelper().insertBin(Bin(
      name: 'Location: 123 xxx Street, State College, PA',
      description: 'Electronic Organic',
      latitude: 41.554833,
      longitude: 60.620053,
      imagePath: 'assets/images/bin.png',
      category: 'Mixed',
      instructions: [
        Instruction(
            binId: 4,
            name: 'For cardboard',
            imagePath: 'assets/images/in1.png'),
        Instruction(
            binId: 4, name: 'For plastic', imagePath: 'assets/images/in2.png'),
      ],
    ));
    await prefs.setBool('isCategoryInserted', true);
  }
}
