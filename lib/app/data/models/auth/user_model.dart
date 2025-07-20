class UserModel {
  final String? uid;
  final String? name;
  final String? password;
  final String? email;
  final String? photoUrl;
  final String? role;

  UserModel({
    this.uid,
    this.name,
    this.password,
    this.email,
    this.photoUrl,
    this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
      'role': role ?? 'user',
    };
  }
}
