class City {
  final int id;
  final String name;
  final int divisionId;

  City({required this.id, required this.name, required this.divisionId});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      divisionId: json['state_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': divisionId,
    };
  }
}
