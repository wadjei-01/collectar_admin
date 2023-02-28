class Category {
  int id;
  String name;
  Category({required this.id, required this.name});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
  static Category fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );
}
