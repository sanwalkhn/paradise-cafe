class MenuItem {
  final String id;
  final String name;
  final int price;
  final double rating;
  final String category;
  final String imageUrl;
  final String description;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.category,
    required this.imageUrl,
    required this.description,
  });

  // ── Convert raw Firestore data into a MenuItem ────
  factory MenuItem.fromFirestore(String id, Map<String, dynamic> data) {
    return MenuItem(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toInt(),
      rating: (data['rating'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }
}