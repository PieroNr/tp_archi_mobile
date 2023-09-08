import 'dart:convert';

class User {
  int? id;
  int? userId;
  String? userName;
  String? userPassword;

  User({
    this.id,
    this.userId,
    this.userName,
    this.userPassword,
  });

  User copyWith({
    int? id,
    int? userId,
    String? userName,
    String? userPassword,
  }) {
    return User(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPassword: userPassword ?? this.userPassword,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }

    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (userName != null) {
      result.addAll({'userName': userName});
    }
    if (userPassword != null) {
      result.addAll({'userPassword': userPassword});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      userId: map['userId']?.toInt(),
      userName: map['userName'],
      userPassword: map['userPassword'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id,userId: $userId, userName: $userName, userPassword: $userPassword)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.userId == userId && other.userName == userName && other.userPassword == userPassword;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ userName.hashCode ^ userPassword.hashCode;
  }
}
