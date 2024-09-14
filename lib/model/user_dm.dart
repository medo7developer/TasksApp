class UserDm {
  static UserDm? currentUser;
  static const collectionName = 'users';
  String id;
  String email;
  String userName;

  UserDm({required this.id, required this.email, required this.userName});

  UserDm.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        userName = json['userName'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
    };
  }
}