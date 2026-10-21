class UserProfile {
  final String uid;
  final String name;
  final String phone;
  final String address;
  final String about;

  UserProfile({
    required this.uid,
    required this.name,
    required this.phone,
    required this.address,
    required this.about,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'about': about,
    };
  }

  factory UserProfile.fromFirestore(String uid, Map<String, dynamic> data) {
    return UserProfile(
      uid: uid,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      about: data['about'] ?? '',
    );
  }

  factory UserProfile.empty(String uid) {
    return UserProfile(uid: uid, name: '', phone: '', address: '', about: '');
  }
}