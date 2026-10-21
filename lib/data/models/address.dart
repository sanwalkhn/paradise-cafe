class Address {
  final String id;
  final String userId;
  final String label;       // e.g. "Home", "Work"
  final String fullAddress;
  final String city;
  final bool isDefault;

  Address({
    required this.id,
    required this.userId,
    required this.label,
    required this.fullAddress,
    required this.city,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'label': label,
      'fullAddress': fullAddress,
      'city': city,
      'isDefault': isDefault,
    };
  }

  factory Address.fromFirestore(String id, Map<String, dynamic> data) {
    return Address(
      id: id,
      userId: data['userId'] ?? '',
      label: data['label'] ?? '',
      fullAddress: data['fullAddress'] ?? '',
      city: data['city'] ?? '',
      isDefault: data['isDefault'] ?? false,
    );
  }
}