class Category {
  final String id;
  final String name;
  final String imageUrl;
  final int order;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.order,
  });

  factory Category.fromFirestore(String id, Map<String, dynamic> data) {
    return Category(
      id: id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      order: (data['order'] ?? 0).toInt(),
    );
  }
}