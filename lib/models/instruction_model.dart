class Instruction {
  final int? id;
  final int binId;
  final String name;
  final String imagePath;

  Instruction({
    this.id,
    required this.binId,
    required this.name,
    required this.imagePath,
  });

  factory Instruction.fromMap(Map<String, dynamic> map) {
    return Instruction(
      id: map['id'],
      binId: map['binId'],
      name: map['name'],
      imagePath: map['imagePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'binId': binId,
      'name': name,
      'imagePath': imagePath,
    };
  }
}
