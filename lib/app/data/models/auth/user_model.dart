class UserModel {
  final String? uid;
  final String? name;
  final String? password;
  final String? email;
  final String? photoUrl;
  final String? role;
  final String? bio;
  final String? emailPersonal;
  final String? phoneNumber;
  final String? address;
  final String? proffession;

  UserModel({
    this.uid,
    this.name,
    this.password,
    this.email,
    this.photoUrl,
    this.role,
    this.bio,
    this.emailPersonal,
    this.phoneNumber,
    this.address,
    this.proffession
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      password: map['password'], // optional: remove for security
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      role: map['role'] ?? 'user',
      bio: map['bio'],
      emailPersonal: map['emailPersonal'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      proffession: map['proffession'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'password': password, // optional: remove for security
      'email': email,
      'photoUrl': photoUrl,
      'role': role ?? 'user',
      'bio': bio,
      'emailPersonal': emailPersonal,
      'phoneNumber': phoneNumber,
      'address': address,
      'proffession': proffession
    };
  }
}
