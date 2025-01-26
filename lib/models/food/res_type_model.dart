class RestaurantType {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  RestaurantType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from a Map
  factory RestaurantType.fromJson(Map<String, dynamic> json) {
    return RestaurantType(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Convert instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
