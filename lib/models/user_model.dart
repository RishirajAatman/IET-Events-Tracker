class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String? phone;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.phone,
    this.profileImage,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      role: data['role'] ?? 'Student',
      phone: data['phone'],
      profileImage: data['profileImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'phone': phone,
      'profileImage': profileImage,
    };
  }

  // Add a default UserModel instance for null safety
  static UserModel defaultUser() {
    return UserModel(
      id: 'default',
      name: 'Default User',
      email: '',
      password: '',
      role: 'Student',
    );
  }

  static UserModel empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      password: '',
      role: 'Student',
    );
  }

  bool get isEmpty => id.isEmpty && name.isEmpty && email.isEmpty;
}
