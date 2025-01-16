class City {
  final int id;
  final String name;
  final int divisionId;

  City({required this.id, required this.name, required this.divisionId});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      divisionId: json['division_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'division_id': divisionId,
    };
  }
}
