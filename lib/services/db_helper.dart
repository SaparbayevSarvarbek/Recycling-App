import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/bin_model.dart';
import '../models/category_item.dart';
import '../models/instruction_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'category.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE category_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            groupId INTEGER,
            imagePath TEXT,
            title TEXT,
            description TEXT
          )
        ''');
        await db.execute('''
    CREATE TABLE bin_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      description TEXT,
      latitude REAL,
      longitude REAL,
      imagePath TEXT,
      category TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE instruction_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      binId INTEGER,
      name TEXT,
      imagePath TEXT,
      FOREIGN KEY (binId) REFERENCES bin_items(id) ON DELETE CASCADE
    )
  ''');
      },
    );
  }

  Future<void> insertBin(Bin bin) async {
    final db = await database;
    final binId = await db.insert(
      'bin_items',
      bin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (var instruction in bin.instructions) {
      await db.insert(
        'instruction_items',
        {
          'binId': binId,
          'name': instruction.name,
          'imagePath': instruction.imagePath,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
  Future<List<Bin>> getAllBins() async {
    final db = await database;
    final List<Map<String, dynamic>> binMaps = await db.query('bin_items');

    List<Bin> bins = [];

    for (var binMap in binMaps) {
      final binId = binMap['id'];

      final List<Map<String, dynamic>> instructionMaps = await db.query(
        'instruction_items',
        where: 'binId = ?',
        whereArgs: [binId],
      );

      final instructions = instructionMaps.map((map) => Instruction.fromMap(map)).toList();

      bins.add(Bin.fromMap(binMap, instructions));
    }

    return bins;
  }


  Future<void> insertCategory(CategoryItem item) async {
    final db = await database;
    await db.insert('category_items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CategoryItem>> getCategoriesByGroup(int groupId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'category_items',
      where: 'groupId = ?',
      whereArgs: [groupId],
    );
    return List.generate(maps.length, (i) {
      return CategoryItem.fromMap(maps[i]);
    });
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('category_items');
  }
}
