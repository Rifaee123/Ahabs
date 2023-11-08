class Notifications {
  final String id;
  final String receiver;
  final User user;
  final String content;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notifications({
    required this.id,
    required this.receiver,
    required this.user,
    required this.content,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['_id'],
      receiver: json['receiver'],
      user: User.fromJson(json['user']),
      content: json['content'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class User {
  final String id;
  final String username;
  final String profilePicture;

  User({
    required this.id,
    required this.username,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      profilePicture: json['profilepicture'],
    );
  }
}
