class Ward {
  final int id;
  final String name;
  final int townshipId;

  Ward({required this.id, required this.name, required this.townshipId});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      townshipId: json['township_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'township_id': townshipId,
    };
  }
}
