class Division {
  final int id;
  final String name;
  final int countryId;

  Division({required this.id, required this.name, required this.countryId});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      countryId: json['country_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
    };
  }
}
