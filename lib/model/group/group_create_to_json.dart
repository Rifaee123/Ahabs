import 'dart:io';

class GroupCreate {
  late String name;
  late String description;
  late List<String> participants;
  late File image;

  GroupCreate({
    required this.name,
    required this.description,
    required this.participants,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'participants': participants,
      'image': image,
    };
  }
}