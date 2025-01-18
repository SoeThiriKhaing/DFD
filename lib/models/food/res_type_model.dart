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
  factory RestaurantType.fromJson(Map<String, dynamic> map) {
    return RestaurantType(
      id: map['id'],
      name: map['name'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
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
