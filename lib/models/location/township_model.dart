class Township {
  final int id;
  final String name;
  final int cityId;

  Township({required this.id, required this.name, required this.cityId});

  factory Township.fromJson(Map<String, dynamic> json) {
    return Township(
      id: json['id'],
      name: json['name'],
      cityId: json['city_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city_id': cityId,
    };
  }
}
