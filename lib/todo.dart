import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'todo.g.dart'; // Generated file for Hive

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String contact;

  @HiveField(3)
  final String link;

  @HiveField(4)
  final List<String> multipleLinks;

  @HiveField(5)
  final Uint8List? image;

  Todo({
    required this.title,
    required this.description,
    required this.contact,
    required this.link,
    required this.multipleLinks,
    this.image,
  });
}
