class Street {
  final int id;
  final String name;
  final int wardId;

  Street({required this.id, required this.name, required this.wardId});

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      id: json['id'],
      name: json['name'],
      wardId: json['ward_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ward_id': wardId,
    };
  }
}
