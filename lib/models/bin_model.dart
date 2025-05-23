import 'instruction_model.dart';

class Bin {
  final int? id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String imagePath;
  final String category;
  final List<Instruction> instructions;

  Bin({
    this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imagePath,
    required this.category,
    required this.instructions,
  });

  factory Bin.fromMap(Map<String, dynamic> map, List<Instruction> instructions) {
    return Bin(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      imagePath: map['imagePath'],
      category: map['category'],
      instructions: instructions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imagePath': imagePath,
      'category': category,
    };
  }
}
