class RestaurantType {
  final String? id;
  final String name;

  RestaurantType({this.id, required this.name});

  factory RestaurantType.fromJson(Map<String, dynamic> json) {
    return RestaurantType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
