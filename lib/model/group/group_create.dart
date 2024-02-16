class Group {
  final String name;
  final String description;
  final List<String> createdBy;
  final List<String> participants;
  final String image;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  Group({
    required this.name,
    required this.description,
    required this.createdBy,
    required this.participants,
    required this.image,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['data']['name'],
      description: json['data']['description'],
      createdBy: List<String>.from(json['data']['createdBy']),
      participants: List<String>.from(json['data']['participants']),
      image: json['data']['image'],
      id: json['data']['_id'],
      createdAt: DateTime.parse(json['data']['createdAt']),
      updatedAt: DateTime.parse(json['data']['updatedAt']),
    );
  }
}
