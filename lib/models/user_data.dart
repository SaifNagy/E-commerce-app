
// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserData {
  String id;
  String username;
  String email;
  String createdAt;
  UserData({
    required this.id,
    required this.email,
    required this.username,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': id,
      'email': email,
      'username': username,
      'createdAt': createdAt,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['userId'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
