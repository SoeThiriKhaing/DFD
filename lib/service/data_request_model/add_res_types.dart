class AddResTypes {
  final String name;
  String? id;
  AddResTypes({required this.name, this.id});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
