import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String name,
    required String email,
    required String token,
  }) : super(name: name, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return UserModel(
      name: data['name'],
      email: data['email'],
      token: data['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}
